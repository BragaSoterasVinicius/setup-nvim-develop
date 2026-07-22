#!/bin/bash
set -e

mkdir -p /home/dev/.local/share/nvim
mkdir -p /home/dev/.local/state/nvim
mkdir -p /home/dev/.m2
mkdir -p /home/dev/.gradle

chown -R dev:dev /home/dev

exec sudo -u dev "$@"