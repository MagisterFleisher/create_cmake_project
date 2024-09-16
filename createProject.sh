#!/bin/bash

mkdir $1
mkdir $1/src
mkdir $1/build

touch $1/src/main.c
cat <<EOF > $1/src/main.c
#include <stdio.h>

int main(int argument_count, char** argument_vector) {
  int error = 0;
  (void) printf("%s] %s) %d- argument_count: %d\n", __FILE__, __FUNCTION__, __LINE__, argument_count);
  return error;
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
project($1 C)

set(C_STANDARD 23)

#set(CMAKE_EXE_LINKER_FLAGS "\${CMAKE_EXE_LINKER_FLAGS} -pg -fsanitize=address")
#set(CMAKE_SHARED_LINKER_FLAGS "\${CMAKE_SHARED_LINKER_FLAGS} -pg  -fsanitize=address")

#set(CMAKE_EXE_LINKER_FLAGS "\${CMAKE_EXE_LINKER_FLAGS} -fsanitize=address -ggdb")
#set(CMAKE_SHARED_LINKER_FLAGS "\${CMAKE_SHARED_LINKER_FLAGS} -fsanitize=address -ggdb")

set(CMAKE_EXE_LINKER_FLAGS "\${CMAKE_EXE_LINKER_FLAGS} -pg -fsanitize=address -ggdb")
set(CMAKE_SHARED_LINKER_FLAGS "\${CMAKE_SHARED_LINKER_FLAGS} -pg -fsanitize=address -ggdb")

add_executable(\${PROJECT_NAME} src/main.c)
EOF
