#!/usr/bin/env python2

from stem.control import Controller
from stem import Signal
from stem import CircStatus

if __name__ == '__main__':
  with Controller.from_port(port = 9051) as controller:
    controller.authenticate('$test123^')  # provide the password here if you set one

    controller.signal(Signal.NEWNYM) # switch to clean circuits
    for circ in controller.get_circuits():
      if circ.status != CircStatus.BUILT:
          continue

      exit_fp, exit_nickname = circ.path[-1]

      exit_desc = controller.get_network_status(exit_fp, None)
      exit_address = exit_desc.address if exit_desc else 'unknown'

      print ("Exit relay")
      print ("  fingerprint: %s" % exit_fp)
      print ("  nickname: %s" % exit_nickname)
      print ("  address: %s" % exit_address)
