#!/usr/bin/env bash
cd "$(dirname "$(readlink -f "$0")")/.." || exit 1

version="$(curl -sH"Authorization: Bearer $GH_TOKEN" https://api.github.com/repos/tmux/tmux/releases/latest | jq -r .tag_name)"
# API rate limit exceeded
[ "$version" != null ] || exit 1
echo "VERSION=$version" >>"$GITHUB_OUTPUT"
perl -pi -e's/(?<=^set\(VERSION )\S+/'"$version/" CMakeLists.txt
[ -n "$(git diff)" ] || exit
git add CMakeLists.txt

cmake -Bbuild
cmake --build build
