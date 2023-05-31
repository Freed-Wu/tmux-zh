cmake_minimum_required(VERSION 3.10)
# cmake-format: off
set(VERSION 3.3a CACHE STRING "version of tmux")
# cmake-format: on
option(ZH_CN "generate simplified Chinese translation" ON)
option(ZH_TW "generate taiwan traditional Chinese translation")
option(HTML "generate html")

string(REGEX MATCH "[a-z]" patch ${VERSION})
if(patch)
  string(HEX ${patch} hex)
  math(EXPR num "0x${hex} - 0x60")
  string(REPLACE ${patch} .${num} NEW_VERSION ${VERSION})
else()
  set(NEW_VERSION ${VERSION}.0)
endif()

find_program(po4a po4a HINTS "/usr/bin/" REQUIRED)
if(ZH_CN)
  set(LANG zh_cn)
endif()
if(ZH_TW)
  find_program(opencc opencc HINTS "/usr/bin/" REQUIRED)
  set(LANG zh_tw)
endif()
if(HTML)
  find_program(groff groff HINTS "/usr/bin/" REQUIRED)
endif()

project(
  tmux-${LANG}
  VERSION ${NEW_VERSION}
  DESCRIPTION "translation of tmux man pages for ${LANG}"
  HOMEPAGE_URL "https://github.com/Freed-Wu/tmux-zh"
  LANGUAGES)
configure_file(po4a/po4a.cfg.in po4a/po4a.cfg)

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
add_custom_target(
  man ALL
  COMMAND po4a po4a/po4a.cfg
  DEPENDS tmux ${CMAKE_SOURCE_DIR}/po4a/zh_CN/tmux.1.po
  COMMENT "man pages")
add_custom_target(
  zh_TW-po
  COMMAND opencc -c s2twp.json -i ${CMAKE_SOURCE_DIR}/po4a/zh_CN/tmux.1.po -o ${CMAKE_SOURCE_DIR}/po4a/zh_TW/tmux.1.po
  COMMENT "po for zh_TW")
add_custom_target(
  zh_TW-roff
  COMMAND opencc -c s2twp.json -i ${CMAKE_SOURCE_DIR}/po4a/zh_CN/tmux.1.roff -o
          ${CMAKE_SOURCE_DIR}/po4a/zh_TW/tmux.1.roff
  COMMENT "addendum roff for zh_TW")
if(ZH_CN AND HTML)
  set(ZH_CN_HTML ALL)
endif()
add_custom_target(
  zh_CN-html
  ${ZH_CN_HTML}
  COMMAND groff -Kutf-8 -mmandoc -Thtml ${CMAKE_BINARY_DIR}/zh_CN/zh_CN/man1/tmux.1 >
          ${CMAKE_BINARY_DIR}/zh_CN/index.html
  DEPENDS man
  COMMENT "html for zh_CN")
if(ZH_TW AND HTML)
  set(ZH_TW_HTML ALL)
endif()
add_custom_target(
  zh_TW-html
  ${ZH_TW_HTML}
  COMMAND groff -Kutf-8 -mmandoc -Thtml ${CMAKE_BINARY_DIR}/zh_TW/zh_TW/man1/tmux.1 >
          ${CMAKE_BINARY_DIR}/zh_TW/index.html
  DEPENDS man
  COMMENT "html for zh_TW")
if(ZH_TW)
  add_dependencies(man zh_TW-po zh_TW-roff)
endif()

if(LANG STREQUAL zh_cn)
  install(DIRECTORY ${CMAKE_BINARY_DIR}/zh_CN/zh_CN TYPE MAN)
else()
  install(DIRECTORY ${CMAKE_BINARY_DIR}/zh_TW/zh_TW TYPE MAN)
endif()

set(CPACK_PACKAGE_CONTACT "https://github.com/Freed-Wu/tmux-zh/issues")
set(CPACK_PACKAGE_FILE_NAME ${PROJECT_NAME}-${VERSION}-${CMAKE_SYSTEM_NAME})
include(CPack)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
set(CPACK_ARCHIVE_THREADS 0)
set(CPACK_THREADS 0)
