cmake_minimum_required(VERSION 3.11)
project(hvr_ios_codec C CXX)

set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# Source files
set(PROJECT_SRCS
${PROJECT_SOURCE_DIR}/src/HelloWorld.cpp
${PROJECT_SOURCE_DIR}/src/HelloWorldIOS.mm
)

set(PROJECT_INCS
${PROJECT_SOURCE_DIR}/include/Hvr/Codec/HelloWorld.hpp
${PROJECT_SOURCE_DIR}/include/Hvr/Codec/HelloWorldIOS.h
)

find_package( FFMPEG_IOS REQUIRED )

# Library
if(BUILD_SHARED)
  add_library(${PROJECT_NAME} SHARED ${PROJECT_SRCS} ${PROJECT_INCS})
  message(STATUS "Building shared version...")
else()
  add_library(${PROJECT_NAME} STATIC ${PROJECT_SRCS} ${PROJECT_INCS})
  message(STATUS "Building static version...")
endif()

# Link the library with the executable
target_link_libraries(${PROJECT_NAME}
  ${FFMPEG_IOS_LIBRARIES}
)

target_include_directories(${PROJECT_NAME} PUBLIC
  $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
  ${FFMPEG_IOS_INCLUDE_DIRS})

# Debug symbols set in XCode project
set_xcode_property(${PROJECT_NAME} GCC_GENERATE_DEBUGGING_SYMBOLS YES "All")

# Installation
#set(CMAKE_INSTALL_PREFIX "${example-ios_SOURCE_DIR}/../example-app/example-lib")
#install (TARGETS example helloworld DESTINATION lib)
#install (FILES ${HEADERS} DESTINATION include)
