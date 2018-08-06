# - Find FFmpeg-IOS
# Find the native ffmpeg-ios headers and libraries.
#
#  FFMPEG_IOS_INCLUDE_DIRS - where to find avcodec.h, etc.
#  FFMPEG_IOS_LIBRARIES    - List of libraries when using ffmpeg.
#  FFMPEG_IOS_ROOT_DIR     - The base directory to search for ffmpeg.
#                       This can also be an environment variable.

# Look for header file
find_path(FFMPEG_IOS_INCLUDE_DIR
  NAMES libavcodec/avcodec.h
  PATHS ${CMAKE_SOURCE_DIR}/ffmpeg/include
  DOC "FFMPEG IOS include directory"
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH)

# Look for library
find_library(FFMPEG_IOS_AVFORMAT_LIBRARY
  NAMES avformat
  PATHS ${CMAKE_SOURCE_DIR}/ffmpeg/lib
  DOC "AVFormat library"
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH)

# Look for library
find_library(FFMPEG_IOS_AVUTIL_LIBRARY
  NAMES avutil
  PATHS ${CMAKE_SOURCE_DIR}/ffmpeg/lib
  DOC "AVUtil library"
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH)

# Look for library
find_library(FFMPEG_IOS_AVCODEC_LIBRARY
  NAMES avcodec
  PATHS ${CMAKE_SOURCE_DIR}/ffmpeg/lib
  DOC "AVcodec library"
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH)

# Look for library
find_library(FFMPEG_IOS_SWRESAMPLE_LIBRARY
  NAMES swresample
  PATHS ${CMAKE_SOURCE_DIR}/ffmpeg/lib
  DOC "AVResample library"
  NO_DEFAULT_PATH
  NO_CMAKE_FIND_ROOT_PATH)

# Find major version (optional)
if(FFMPEG_IOS_INCLUDE_DIR)
  foreach(_libavcodec_version_header libavcodec/version.h)
    if(EXISTS "${FFMPEG_IOS_INCLUDE_DIR}/${_libavcodec_version_header}")
      file(STRINGS "${FFMPEG_IOS_INCLUDE_DIR}/${_libavcodec_version_header}"
        libavcodec_version_str REGEX
        "^#define[\t ]+LIBAVCODEC_VERSION_MAJOR[\t ]+[0-9]")
      string(REGEX REPLACE
        "^#define[\t ]+LIBAVCODEC_VERSION_MAJOR[\t ]+([0-9]*)" "\\1"
        FFMPEG_IOS_MAJOR_VERSION "${libavcodec_version_str}")
      unset(libavcodec_version_str)
      break()
    endif()
  endforeach()
endif()

# Find minor version (optional)
if(FFMPEG_IOS_INCLUDE_DIR)
  foreach(_libavcodec_version_header libavcodec/version.h)
    if(EXISTS "${FFMPEG_IOS_INCLUDE_DIR}/${_libavcodec_version_header}")
      file(STRINGS "${FFMPEG_IOS_INCLUDE_DIR}/${_libavcodec_version_header}"
        libavcodec_version_str REGEX
        "^#define[\t ]+LIBAVCODEC_VERSION_MINOR[\t ]+[0-9]")
      string(REGEX REPLACE
        "^#define[\t ]+LIBAVCODEC_VERSION_MINOR[\t ]+([0-9]*)" "\\1"
        FFMPEG_IOS_MINOR_VERSION "${libavcodec_version_str}")
      unset(libavcodec_version_str)
      break()
    endif()
  endforeach()
endif()

# Merge verion string (optional)
string(CONCAT FFMPEG_IOS_VERSION_STRING
  ${FFMPEG_IOS_MAJOR_VERSION}
  "."
  ${FFMPEG_IOS_MINOR_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(FFMPEG_IOS REQUIRED_VARS
                                  FFMPEG_IOS_AVCODEC_LIBRARY
                                  FFMPEG_IOS_INCLUDE_DIR
                                  FFMPEG_IOS_AVFORMAT_LIBRARY
                                  FFMPEG_IOS_AVUTIL_LIBRARY
                                  FFMPEG_IOS_SWRESAMPLE_LIBRARY
                                  VERSION_VAR
                                  FFMPEG_VERSION_STRING)

if(FFMPEG_IOS_FOUND)
  set(FFMPEG_IOS_INCLUDE_DIRS ${FFMPEG_IOS_INCLUDE_DIR}
    CACHE PATH "FFMPEG IOS include directories")

  set(FFMPEG_IOS_LIBRARIES
    ${FFMPEG_IOS_AVFORMAT_LIBRARY}
    ${FFMPEG_IOS_AVUTIL_LIBRARY}
    ${FFMPEG_IOS_AVCODEC_LIBRARY}
    ${FFMPEG_IOS_SWRESAMPLE_LIBRARY}
    CACHE PATH "FFMPEG IOS libraries")
endif()
