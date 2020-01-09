#!/bin/bash

pgrep conky && killall conky || conky -q

exit 0