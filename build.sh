#!/bin/bash
set -e
curl -L https://github.com/gohugoio/hugo/releases/download/v0.147.2/hugo_extended_0.147.2_linux-amd64.tar.gz | tar xz
./hugo --minify
