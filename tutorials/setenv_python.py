import os

BASE_DIR = os.path.join(os.path.dirname(__file__), '..')

rerun = True

if not 'ANSIBLE_CONFIG' in os.environ:
    os.environ['ANSIBLE_CONFIG'] = os.path.join(BASE_DIR,
                                                'conf/ansible.cfg')
else:
    rerun = False

if rerun:
    os.execve(os.path.realpath(__file__), sys.argv, os.environ)
