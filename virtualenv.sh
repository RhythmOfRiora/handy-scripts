#!/bin/bash

##################################################################
#
#  RUN THIS USING $ source ./virtualenv.sh <virtualenv name> <python version>
#
##################################################################

VIRTUALENV=$1
PYTHON_VERSION=$2
SYSTEM_PYTHON=`python -c 'import sys; print(".".join(map(str, sys.version_info[:3])))'`

# -- Check if virtualenv is installed.

if [ -z "$1" ]; then
	echo "PLEASE RUN THIS USING $ source ./virtualenv.sh <virtualenv name> <python version>"
        VIRTUALENV=default
fi
python -c "import virtualenv"
if [ $? -ne 0 ]; then
        sudo pip install virtualenv
fi
if [ ! -d "~/virtualenvironment" ]; then
        mkdir ~/virtualenvironment
fi

if [ ! -d "~/virtualenvironment/$VIRTUALENV" ]; then 
	echo "Virtual Environment does not exist already... Creating..."
	if [ -z "$2" ];
              then
                   virtualenv ~/virtualenvironment/$VIRTUALENV
	      else
                   virtualenv -p `which $PYTHON_VERSION` ~/virtualenvironment/$VIRTUALENV 
		   if [ $? -ne 0 ]; then
			   echo "#######~~~  Please use a version of Python that is installed on the system, or install the version you desire. ~~~######"
		   fi
              fi
fi

if [ ! -d "~/virtualenvironment/$VIRTUALENV" ]; then
        cd ~/virtualenvironment/$VIRTUALENV/bin
        alias activate="source ~/virtualenvironment/$VIRTUALENV/bin/activate"
        activate
fi

