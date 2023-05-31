#!/usr/bin/env bash
[ -n "$VERSION" ] || exit
cd "$(dirname "$(readlink -f "$0")")/.." || exit 1

# call po4a to format po files
cmake --build build
git add po4a/zh_CN/tmux.1.po
git config --global user.name 'Github Actions'
git config --global user.email '41898282+github-actions[bot]@users.noreply.github.com'
git commit -m ":bookmark: Dump version to $VERSION"
git tag "$VERSION"
git remote set-url origin "https://x-access-token:$GH_TOKEN@github.com/$GITHUB_REPOSITORY"
git push
git push --tags
