#!/usr/bin/env bash

set -e

workspace=$(bazel info | grep "workspace:" | sed 's/^.* //')

$workspace/kompile_tool/gen-bazel.py $workspace "$@">BUILD
