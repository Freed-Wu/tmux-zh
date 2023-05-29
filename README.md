# [tmux](https://github.com/tmux/tmux) 中文手册

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/Freed-Wu/tmux-zh/main.svg)](https://results.pre-commit.ci/latest/github/Freed-Wu/tmux-zh/main)
[![github/workflow](https://github.com/Freed-Wu/tmux-zh/actions/workflows/main.yml/badge.svg)](https://github.com/Freed-Wu/tmux-zh/actions)

[![github/downloads](https://shields.io/github/downloads/Freed-Wu/tmux-zh/total)](https://github.com/Freed-Wu/tmux-zh/releases)
[![github/downloads/latest](https://shields.io/github/downloads/Freed-Wu/tmux-zh/latest/total)](https://github.com/Freed-Wu/tmux-zh/releases/latest)
[![github/issues](https://shields.io/github/issues/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh/issues)
[![github/issues-closed](https://shields.io/github/issues-closed/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh/issues?q=is%3Aissue+is%3Aclosed)
[![github/issues-pr](https://shields.io/github/issues-pr/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh/pulls)
[![github/issues-pr-closed](https://shields.io/github/issues-pr-closed/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh/pulls?q=is%3Apr+is%3Aclosed)
[![github/discussions](https://shields.io/github/discussions/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh/discussions)
[![github/milestones](https://shields.io/github/milestones/all/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh/milestones)
[![github/forks](https://shields.io/github/forks/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh/network/members)
[![github/stars](https://shields.io/github/stars/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh/stargazers)
[![github/watchers](https://shields.io/github/watchers/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh/watchers)
[![github/contributors](https://shields.io/github/contributors/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh/graphs/contributors)
[![github/commit-activity](https://shields.io/github/commit-activity/w/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh/graphs/commit-activity)
[![github/last-commit](https://shields.io/github/last-commit/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh/commits)
[![github/release-date](https://shields.io/github/release-date/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh/releases/latest)

[![github/license](https://shields.io/github/license/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh/blob/main/LICENSE)
[![github/languages](https://shields.io/github/languages/count/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh)
[![github/languages/top](https://shields.io/github/languages/top/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh)
[![github/directory-file-count](https://shields.io/github/directory-file-count/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh)
[![github/code-size](https://shields.io/github/languages/code-size/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh)
[![github/repo-size](https://shields.io/github/repo-size/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh)
[![github/v](https://shields.io/github/v/release/Freed-Wu/tmux-zh)](https://github.com/Freed-Wu/tmux-zh)

## 安装

您可以先试一下在线预览。

- [![简体中文](https://img.shields.io/readthedocs/tmux?label=%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)](https://tmux.readthedocs.io/zh_CN/latest)
- [![繁體中文](https://img.shields.io/readthedocs/tmux?label=%E7%B9%81%E4%BD%93%E4%B8%AD%E6%96%87)](https://tmux.readthedocs.io/zh_TW/latest)

### Debian

[下载 deb](https://github.com/Freed-Wu/tmux-zh/releases)

```bash
dpkg -i tmux-zh_cn-*-Linux.deb
dpkg -i tmux-zh_tw-*-Linux.deb
```

### Redhat

[下载 rpm](https://github.com/Freed-Wu/tmux-zh/releases)

```bash
rpm -i tmux-zh_cn-*-Linux.rpm
rpm -i tmux-zh_tw-*-Linux.rpm
```

### [AUR](https://aur.archlinux.org/packages/tmux-zh_cn)

```bash
yay -S tmux-zh_cn
yay -S tmux-zh_tw
```

### nix

```bash
nix-shell -p github:Freed-Wu/tmux-zh
```

## 构建时依赖

### 必选

- [gettext](https://www.gnu.org/software/gettext)
- [po4a](https://github.com/mquinson/po4a)
- [cmake](https://github.com/Kitware/CMake)

### 可选

- [opencc](https://github.com/BYVoid/OpenCC): 繁体中文支持
- [groff](https://www.gnu.org/software/groff): HTML 格式支持

## 构建

```bash
cmake -Bbuild -DZH_CN=ON -DZH_TW=ON -DHTML=ON
cmake --build build
```

## 运行时依赖

- [man](http://man-db.nongnu.org)

## 用法

```bash
export -Lzh_CN:zh_CHS:zh
man tmux
```

## 贡献

修改 [`po4a/zh_CN/tmux.1.po`](po4a/zh_CN/tmux.1.po) 即可。

欢迎 [PR](https://github.com/Freed-Wu/tmux-zh/pulls) 。
