#!/usr/bin/env python

from ansible import inventory, \
    callbacks, playbook

#print(dir(ansible))

def run_ansible():
    vaultpass = "password"
    I = inventory.Inventory("hosts.ini")

    parsed_extra_vars = { 'tags' : ['two'],
                          'date': 2
    }
    stats = callbacks.AggregateStats()
    playbook_cb = callbacks.PlaybookCallbacks(verbose=3)

    runner_cb = callbacks.PlaybookRunnerCallbacks(stats,
                                                  verbose=3)
    pb = playbook.PlayBook(
        playbook='sample_playbook.yaml',
        inventory=I,
        extra_vars=parsed_extra_vars,
        #private_key_file="/path/to/key.pem",
        #vault_password=vaultpass,
        stats=stats,
        callbacks=playbook_cb,
        runner_callbacks=runner_cb
    )
    pb.run()
    
    hosts = sorted(pb.stats.processed.keys())
    
    failed_hosts = []
    unreachable_hosts = []
    for h in hosts:
        t = pb.stats.summarize(h)
        if t['failures'] > 0:
            failed_hosts.append(h)
        if t['unreachable'] > 0:
            unreachable_hosts.append(h)

    print("failed hosts: ", failed_hosts)
    print("unreachable hosts: ", unreachable_hosts)
    
    retries = failed_hosts + unreachable_hosts
    print("retries:", retries)
    if len(retries) > 0:
        return 1
    return 0

run_ansible()
