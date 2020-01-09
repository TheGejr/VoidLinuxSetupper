#!/bin/bash

pgrep compton && killall compton || compton -b

exit 0