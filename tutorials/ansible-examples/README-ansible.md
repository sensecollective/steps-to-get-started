### To run with Ansible's Python2 API 2.1

```
export ANSIBLE_CONFIG=/path/to/your/ansible.cfg
```

Edit ansible.cfg and change configs for log dir and callback_plugins accordingly.

Then run:

```
$ ./playbook_runner.py /path/to/playbook.yaml /path/to/hosts.ini 
```
