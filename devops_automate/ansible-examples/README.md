### To run with Ansible's Python2 API 2.1

```
export ANSIBLE_CONFIG=/path/to/your/conf/ansible.cfg
```

Edit ansible.cfg and change configs for log dir and callback_plugins accordingly.

Then run:


#### for 1.9.6

# hardcoded paths for hosts.ini and playbook yaml, inside runner.py
```
$ ./1.9.6/runner.py
```

#### for 2.1

```
$ ./2.1/playbook_runner.py /path/to/playbook.yaml /path/to/hosts.ini 
```
