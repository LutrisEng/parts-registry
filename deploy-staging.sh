#!/bin/bash

set -euxo pipefail

exec flyctl deploy -c fly.staging.toml "$@"
