#!/bin/sh
chown -R "$USER:$(id -gn)" ~/.gnupg
chmod 700 ~/.gnupg
chmod 600 ~/.gnupg/*
