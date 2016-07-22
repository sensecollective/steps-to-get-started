#!/usr/bin/env python2

# Based on: https://serversforhackers.com/running-ansible-2-programmatically

import os
import sys

from ansible.executor import playbook_executor
from ansible.inventory import Inventory
from ansible.parsing.dataloader import DataLoader
from ansible.vars import VariableManager

try:
    from __main__ import display
except ImportError:
    from ansible.utils.display import Display
    display = Display()


class Options(object):
    """
    Options class to replace Ansible OptParser
    """
    def __init__(self, **kwargs):
        props = (
            'ask_pass', 'ask_sudo_pass', 'ask_su_pass', 'ask_vault_pass',
            'become_ask_pass', 'become_method', 'become', 'become_user',
            'check', 'connection', 'diff', 'extra_vars', 'flush_cache',
            'force_handlers', 'forks', 'inventory', 'listhosts', 'listtags',
            'listtasks', 'module_path', 'module_paths',
            'new_vault_password_file', 'one_line', 'output_file',
            'poll_interval', 'private_key_file', 'python_interpreter',
            'remote_user', 'scp_extra_args', 'seconds', 'sftp_extra_args',
            'skip_tags', 'ssh_common_args', 'ssh_extra_args', 'subset', 'sudo',
            'sudo_user', 'syntax', 'tags', 'timeout', 'tree',
            'vault_password_files', 'verbosity')

        for p in props:
            if p in kwargs:
                setattr(self, p, kwargs[p])
            else:
                setattr(self, p, None)


class Runner(object):
    def __init__(
            self, playbook, display, hosts='hosts', options={}, passwords={},
            vault_pass=None):

        # Set options
        self.options = Options()
        for k, v in options.iteritems():
            setattr(self.options, k, v)

        # Set global verbosity
        self.display = display
        self.display.verbosity = self.options.verbosity
        # Executor has its own verbosity setting
        playbook_executor.verbosity = self.options.verbosity

        # Gets data from YAML/JSON files
        self.loader = DataLoader()
        # Set vault password
        if vault_pass is not None:
            self.loader.set_vault_password(vault_pass)
        elif 'VAULT_PASS' in os.environ:
            self.loader.set_vault_password(os.environ['VAULT_PASS'])

        # All the variables from all the various places
        self.variable_manager = VariableManager()
        if self.options.python_interpreter is not None:
            self.variable_manager.extra_vars = {
                'ansible_python_interpreter': self.options.python_interpreter
            }

        # Set inventory, using most of above objects
        self.inventory = Inventory(
            loader=self.loader, variable_manager=self.variable_manager,
            host_list=hosts)

        if len(self.inventory.list_hosts()) == 0:
            # Empty inventory
            self.display.error("Provided hosts list is empty.")
            sys.exit(1)

        self.inventory.subset(self.options.subset)

        if len(self.inventory.list_hosts()) == 0:
            # Invalid limit
            self.display.error("Specified limit does not match any hosts.")
            sys.exit(1)

        self.variable_manager.set_inventory(self.inventory)

        # Setup playbook executor, but don't run until run() called
        self.pbex = playbook_executor.PlaybookExecutor(
            playbooks=[playbook],
            inventory=self.inventory,
            variable_manager=self.variable_manager,
            loader=self.loader,
            options=self.options,
            passwords=passwords)

    def run(self):
        # Run Playbook and get stats
        self.pbex.run()
        stats = self.pbex._tqm._stats

        return stats


def main():
    # tags in the tasks section of YAML playbook
    TASKS = ['debug', 'simple', 'sequence_count',
             'random_choice', 'until_find',
             'indexed_items', 'template']
    
    runner = Runner(
        playbook=sys.argv[1],
        hosts=sys.argv[2],
        display=display,
        options={
            # 'subset': '~^localhost',
            # 'become': True,
            # 'become_method': 'sudo',
            # 'become_user': 'root',
            # 'private_key_file': '/path/to/the/id_rsa',
            'tags': TASKS[:4],
            # 'skip_tags': 'debug',
            'verbosity': 1,
        },
        
        # passwords={
        #     'become_pass': 'sudo_password',
        #     'conn_pass': 'ssh_password',
        # },
        # vault_pass='vault_password',
    )

    stats = runner.run()

    # Maybe do something with stats here? If you want!


if __name__ == '__main__':
    main()
