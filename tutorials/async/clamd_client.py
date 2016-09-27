import asyncio
import sys
import struct

loop = asyncio.get_event_loop()

class ClamAVProtocol(asyncio.Protocol):
    def __init__(self, future, payload):
        self.future = future
        self.payload = payload
        self.response_data = b''

    def connection_made(self, transport):
        self.transport = transport

        self.transport.write(b'nINSTREAM\n')

        size = struct.pack(b'!L', len(self.payload))
        self.transport.write(size + self.payload)
        self.transport.write(struct.pack(b'!L', 0))

    def data_received(self, data):
        self.response_data += data

        if b'\n' not in self.response_data:
            return

        self.transport.close()

        response = self.response_data.split(b'\n')[0]

        # set the result on the Future so that the main() coroutine can
        # resume
        if response.endswith(b'FOUND'):
            name = response.split(b':', 1)[1].strip()
            self.future.set_result((True, name))
        else:
            self.future.set_result((False, None))

def clamav_scan(payload):
    future = asyncio.Future()
    if payload:
        scanner = ClamAVProtocol(future, payload)

        # kick off a task to create the connection to clamd.
        asyncio.async(loop.create_connection(lambda: scanner, host='127.0.0.1', port=3310))
    else:
        future.set_result((False, None))

    # return the future for the main() coroutine to wait on.
    return future


def main():
    with open(sys.argv[1], 'rb') as f:
        body = f.read()

    found_virus, name = yield from clamav_scan(body)

    if found_virus:
        print("Found a virus! %s" % name)
    else:
        print("No virus. Everything is safe.")

if __name__ == '__main__':
    loop.run_until_complete(main())
