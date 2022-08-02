#!/bin/bash

PLUGIN_NAME="fast-respawn-detector"

cd scripting
spcomp $PLUGIN_NAME.sp -i include -o ../plugins/$PLUGIN_NAME.smx
