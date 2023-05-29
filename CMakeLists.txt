cmake_minimum_required(VERSION 3.10)
# cmake-format: off
set(VERSION 3.3a CACHE STRING "version of tmux")
# cmake-format: on
include(ExternalProject)
ExternalProject_Add(
  tmux
  URL "https://github.com/tmux/tmux/archive/refs/tags/${VERSION}.tar.gz"
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
  USES_TERMINAL_DOWNLOAD 1
  USES_TERMINAL_CONFIGURE 1
  USES_TERMINAL_BUILD 1)
option(ZH_TW "generate taiwan traditional translation")
if(ZH_TW)
  find_program(opencc opencc HINTS "/usr/bin/")
  if(NOT opencc)
    message(FATAL_ERROR "OpenCC isn't detected on your system!")
  endif()
  set(LANG zh_TW)
endif()
option(HTML "generate html")
if(HTML)
  find_program(groff groff HINTS "/usr/bin/")
  if(NOT groff)
    message(FATAL_ERROR "groff isn't detected on your system!")
  endif()
endif()
configure_file(po4a/po4a.cfg.in po4a/po4a.cfg)

add_custom_target(
  man ALL
  COMMAND po4a po4a/po4a.cfg
  DEPENDS tmux ${CMAKE_SOURCE_DIR}/po4a/zh_CN/tmux.1.po
  COMMENT "man pages")

if(ZH_TW)
  install(DIRECTORY ${CMAKE_BINARY_DIR}/zh_TW/zh_TW TYPE MAN)
  add_custom_target(
    zh_TW-po ALL
    COMMAND opencc -c s2twp.json -i ${CMAKE_SOURCE_DIR}/po4a/zh_CN/tmux.1.po -o ${CMAKE_SOURCE_DIR}/po4a/zh_TW/tmux.1.po
    COMMENT "po for zh_TW")
  add_custom_target(
    zh_TW-roff ALL
    COMMAND opencc -c s2twp.json -i ${CMAKE_SOURCE_DIR}/po4a/zh_CN/tmux.1.roff -o
            ${CMAKE_SOURCE_DIR}/po4a/zh_TW/tmux.1.roff
    COMMENT "addendum roff for zh_TW")
  add_dependencies(man zh_TW-po zh_TW-roff)
  if(HTML)
    add_custom_target(
      zh_TW-html ALL
      COMMAND groff -Kutf-8 -mmandoc -Thtml ${CMAKE_BINARY_DIR}/zh_TW/zh_TW/man1/tmux.1 >
              ${CMAKE_BINARY_DIR}/zh_TW/index.html
      DEPENDS man
      COMMENT "html for zh_TW")
  endif()
else()
  install(DIRECTORY ${CMAKE_BINARY_DIR}/zh_CN/zh_CN TYPE MAN)
  set(LANG zh_CN)
endif()

if(HTML)
  add_custom_target(
    zh_CN-html ALL
    COMMAND groff -Kutf-8 -mmandoc -Thtml ${CMAKE_BINARY_DIR}/zh_CN/zh_CN/man1/tmux.1 >
            ${CMAKE_BINARY_DIR}/zh_CN/index.html
    DEPENDS man
    COMMENT "html for zh_CN")
endif()

if(DEFINED ENV{GITHUB_REF_NAME})
  set(DOC_VERSION $ENV{GITHUB_REF_NAME})
else()
  set(DOC_VERSION 0.0.0.0)
endif()
project(
  tmux-${LANG}
  VERSION ${DOC_VERSION}
  DESCRIPTION "translation of tmux man pages for ${LANG}"
  HOMEPAGE_URL "https://github.com/Freed-Wu/tmux-zh"
  LANGUAGES)

set(CPACK_PACKAGE_CONTACT "https://github.com/Freed-Wu/tmux-zh/issues")
include(CPack)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
set(CPACK_ARCHIVE_THREADS 0)
set(CPACK_THREADS 0)
