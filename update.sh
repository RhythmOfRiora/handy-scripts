#!/bin/bash

#cd ~
for d in */; do
    echo "$d" &&
    cd "$d" &&
    
    if [ -d .git ]; then
        echo "It's a git dir!";
        git stash && git checkout master && git pull;
        cd ..
    else
      git rev-parse --git-dir 2> /dev/null;
    
    fi; done 
    #(cd "$d"; ([ -d .git ] git stash && git checkout master && git pull ) || git rev-parse --git-dir 2> /dev/null); done
