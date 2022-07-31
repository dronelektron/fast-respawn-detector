#!/bin/bash

PLUGIN_NAME="fast-respawn-detector"

cd scripting
spcomp $PLUGIN_NAME.sp -o ../plugins/$PLUGIN_NAME.smx
