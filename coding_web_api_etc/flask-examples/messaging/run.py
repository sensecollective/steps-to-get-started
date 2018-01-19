#!venv/bin/python

from tasks import print_hello
from tasks import gen_prime

print "print_hello():"
print_hello()

print "="*10

print "gen_prime(1000) WITHOUT delay:\n"
primes = gen_prime(1000)
print primes

print "="*10

print "gen_prime(5000) WITH delay and timeout:\n"
primes = gen_prime.delay(2000)
while not primes.ready():
    print primes.ready(),
print "\n",primes.get(timeout=2)
