#!/bin/bash

set -euxo pipefail

exec fly deploy -c fly.toml "$@"
