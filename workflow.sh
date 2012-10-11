#! /bin/bash

shopt -s expand_aliases
source virtualenvwrapper.sh

mkvirtualenv buildout-bash-completion
cp -f postactivate ~/.virtualenvs/buildout-bash-completion/bin/
deactivate
workon buildout-bash-completion

sleep 1
cd example
setbuildout

set -x verbose

sleep 1
cdco
python bootstrap.py --distribute
cd /tmp

sleep 1
yes | buildout -v
cdco

sleep 2
yes | ./bin/buildout -v

sleep 2
cds tornado

sleep 2
cdco

cds voxin
python voxin/server.py

sleep 1
cdomelette
add2virtualenv .
cds voxin
python voxin/server.py &

sleep 1
kill $!

voxin &
sleep 1
kill $!

supervisord
supervisorctl status
supervisorctl shutdown

sleep 1
cds tornado
ntest
yes | develop up

echo "profit"
