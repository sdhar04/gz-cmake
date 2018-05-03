#===============================================================================
# Copyright (C) 2018 Open Source Robotics Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
########################################
# Find EIGEN3
#
# Usage of this module is as follows:
#
#     find_package(EIGEN3 [VERSION <major>[.<minor>[.<patch>]]])
#
# Variables defined by this module:
#
# Eigen3::Eigen            Imported target for eigen3
# EIGEN3_FOUND             System has eigen3 library and headers

find_package(Eigen3 ${EIGEN3_FIND_VERSION} CONFIG)

if(EIGEN3_FOUND)
  # We found an old version of Eigen, so we just need to make the
  # imported target.
  ign_import_target(EIGEN3 INTERFACE
    TARGET_NAME Eigen3::Eigen)
  return()
endif()

if(TARGET Eigen3::Eigen)
  # We found a newer version of Eigen that imports its target,
  # so we only need to set the EIGEN3_FOUND variable.
  set(EIGEN3_FOUND TRUE)
  return()
endif()

if(EIGEN3_FIND_VERSION)
  ign_pkg_check_modules_quiet(EIGEN3 "eigen3 >= ${EIGEN3_FIND_VERSION}"
    INTERFACE
    TARGET_NAME Eigen3::Eigen)
else()
  ign_pkg_check_modules_quiet(EIGEN3 "eigen3"
    INTERFACE
    TARGET_NAME Eigen3::Eigen)
endif()

if(MSVC)

  set(EIGEN3_FOUND TRUE)

  find_path(EIGEN3_INCLUDE_DIRS signature_of_eigen3_matrix_library)
  if(NOT EIGEN3_INCLUDE_DIRS)
    set(EIGEN3_FOUND FALSE)
    if(NOT EIGEN3_FIND_QUIETLY)
      message(STATUS "Looking for eigen headers (signature_of_eigen3_matrix_library) - not found")
    endif()
  endif()

  ign_import_target(EIGEN3 INTERFACE
    TARGET_NAME Eigen3::Eigen)

endif()
