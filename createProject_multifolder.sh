#!/bin/bash

mkdir $1
mkdir $1/src
mkdir $1/src/include
mkdir $1/build

touch $1/src/main.c
cat <<EOF > $1/src/main.c
#include <stdio.h>
#include "include/basic_header.h"

int main(int argument_count, char** argument_vector) {
  int error = 0;
  (void) printf("%s] %s) %d- argument_count: %d\n", __FILE__, __FUNCTION__, __LINE__, argument_count);
  (void) temp();
  return error;
}
EOF


touch $1/src/include/basic_header.h
cat <<EOF > $1/src/include/basic_header.h
#ifndef BAISC_HEADER_H_
#define BAISC_HEADER_H_

#include "basic_header.c"

void temp(void);

#endif
EOF


touch $1/src/include/basic_header.c
cat <<EOF > $1/src/include/basic_header.c
#include <stdio.h>

void temp(void) {
  (void) printf("%s] %s) %d- Hello, Header!\n", __FILE__, __func__, __LINE__);
  return;
}
EOF


touch $1/compile.sh
cat <<EOF > $1/compile.sh
cd build
cmake --build .
EOF


touch $1/CMakeLists.txt
cat <<EOF > $1/CMakeLists.txt
cmake_minimum_required(VERSION 3.30)
project(fibGen5 C)

set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED 11)

set(CMAKE_EXE_LINKER_FLAGS "\${CMAKE_EXE_LINKER_FLAGS} -pg -fsanitize=address -ggdb")
set(CMAKE_SHARED_LINKER_FLAGS "\${CMAKE_SHARED_LINKER_FLAGS} -pg -fsanitize=address -ggdb")

add_executable(\${PROJECT_NAME} src/main.c)
add_subdirectory(src/include)
EOF

touch $1/src/CMakeLists.txt
cat <<EOF > $1/src/CMakeLists.txt
target_sources(\${PROJECT_NAME} main.c)
add_subdirectory(\${PROJECT_NAME} /include)
EOF

touch $1/src/include/CMakeLists.txt
cat <<EOF > $1/src/CMakeLists.txt
target_sources(\${PROJECT_NAME}
  PUBLIC
    basic_header.h)
EOF
