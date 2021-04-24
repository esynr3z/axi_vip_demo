#! /bin/bash

# exit on first error
set -e

# elaboration
./clean.sh
if [[ $1 = "nolib" ]]
then
    ./elab_nolib.sh
else
    ./elab.sh
fi

# simulation
./sim.sh
