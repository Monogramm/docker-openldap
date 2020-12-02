#!/bin/sh

set -e

echo "Waiting to ensure everything is fully ready for the tests..."
sleep 90

echo "Checking main containers are reachable..."
if ! ping -c 10 -q openldap ; then
    echo 'OpenLDAP Main container is not responding!'
    # TODO Display logs to help bug fixing
    #echo 'Check the following logs for details:'
    #tail -n 100 logs/*.log
    exit 2
fi

# Add your own tests
# https://docs.docker.com/docker-hub/builds/automated-testing/
echo "Checking OpenLDAP status..."
nc -z openldap 389 || exit 1

# Success
echo 'Docker tests successful'
exit 0
