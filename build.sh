#!/bin/bash
set -euf -o pipefail

GOBIN=$(command -v go) || GOBIN=${GOBIN:=$GOROOT/bin/go}
ECHOBIN=$(command -v echo)
GOVVVBIN="${GOBIN} run github.com/ahmetb/govvv@v0.3.0"
GOXBIN="${GOBIN} run github.com/mitchellh/gox@v0.4.0"

$ECHOBIN "Building..."
$ECHOBIN ""

GOVVVLIST=$($GOVVVBIN list ./cmd)
LDFLAGS=$($GOVVVBIN -flags -pkg $GOVVVLIST)
$GOXBIN -os="linux darwin windows" -arch="amd64" -output="./bin/paperless-cli.{{.OS}}.{{.Arch}}" -ldflags "$LDFLAGS" -verbose ./...

$ECHOBIN ""
$ECHOBIN "Build complete!"
