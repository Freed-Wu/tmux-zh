#!/usr/bin/env bash
cd "$(dirname "$(readlink -f "$0")")/.." || exit 1

version="$(curl --silent https://api.github.com/repos/tmux/tmux/releases/latest | jq -r .tag_name)"
perl -pi -e's/(?<=^set\(VERSION )\S+)/'"$version/" CMakeLists.txt
[ -n "$(git diff)" ] || exit

cmake -Bbuild
cmake --build build
git add CMakeLists.txt po4a/zh_CN/tmux.1.po
git config --global user.name 'Github Actions'
git config --global user.email '41898282+github-actions[bot]@users.noreply.github.com'
git commit -m ":bookmark: Dump version to $version"
