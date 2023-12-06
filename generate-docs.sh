#!/usr/bin/env bash
READLINK=$([[ $OSTYPE == 'darwin'* ]] && echo 'greadlink' || echo 'readlink')
script_path=$($READLINK -f "${BASH_SOURCE:-$0}")
REPO_ROOT=$(dirname $script_path)
arch=$(uname -m)
ARCH=$arch
if [ 'aarch64' = "$arch" ]; then
    ARCH=arm64
fi
OS=$(uname -s)

BINDIR=$REPO_ROOT/bin
HELM_DOCS=$BINDIR/helm-docs
VERSION="1.11.3"

version=$($HELM_DOCS --version 2>/dev/null | cut -d' ' -f3)

if [ ! -f "$HELM_DOCS" ] || [ "$version" != "$VERSION" ]; then
    mkdir -p $BINDIR
    curl -sSL "https://github.com/norwoodj/helm-docs/releases/download/v${VERSION}/helm-docs_${VERSION}_${OS}_${ARCH}.tar.gz" | tar xz -C $BINDIR helm-docs
fi
$HELM_DOCS --version
$HELM_DOCS -s=file --ignore-non-descriptions -c=$REPO_ROOT/charts
