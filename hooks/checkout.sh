#!/bin/bash

rootDir=$(git rev-parse --show-toplevel)
pwd="${PWD}"

(cd "$(git rev-parse --show-toplevel)" && exec sql-migrate down) && git checkout ${@} && (cd "$(git rev-parse --show-toplevel)" && exec sql-migrate up)