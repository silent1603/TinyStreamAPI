cmake_minimum_required( VERSION 3.25)
find_package(Git)

if(GIT_FOUND AND EXISTS "${CMAKE_SOURCE_DIR}/.git")
# Update submodules as needed
    message(STATUS "Check Summodule")
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule update")
        execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT)
        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init --recursive failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
        endif()
    endif()
endif()

if(NOT EXISTS "${CMAKE_SOURCE_DIR}/vcpkg/bootstrap-vcpkg.bat")
    message(FATAL_ERROR "The submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again.")
else()
    if (WIN32)
        execute_process(COMMAND "${CMAKE_SOURCE_DIR}/vcpkg/bootstrap-vcpkg.bat" -disableMetrics
            WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}")
    else ()
        execute_process(COMMAND  "${CMAKE_SOURCE_DIR}/vcpkg/bootstrap-vcpkg.sh" -disableMetrics
            WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}")
    endif()
endif()
project(TinyStreamAPI LANGUAGES CXX DESCRIPTION "TinyStreamAPi is web api for stream")

include(CPack)
include(CMakePackageConfigHelpers)
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)
include(InstallRequiredSystemLibraries)

include(cmake/compiler_option_config.cmake)
include(cmake/clang_format.cmake)
include(cmake/package_config.cmake)

# Set Project version (used for library versioning and for CPack)
set(CMAKE_PROJECT_VERSION_MAJOR 0)
set(CMAKE_PROJECT_VERSION_MINOR 0)
set(CMAKE_PROJECT_VERSION_PATCH 1)
set(CMAKE_PROJECT_VERSION ${CMAKE_PROJECT_VERSION_MAJOR}.${CMAKE_PROJECT_VERSION_MINOR}.${CMAKE_PROJECT_VERSION_PATCH})

# Set required C++ Standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
# Generate the compile_commands.json file
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
# Set the Relative Path Configurations
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
# Configure the visibility of symbols in targets
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)

#####################################
# Define Options
#####################################
option(BUILD_TESTING "Build tests" ON)
option(BUILD_SHARED_LIBS "Build shared libraries" OFF)

#####################################
# Setup third party
#####################################
find_package(Drogon CONFIG REQUIRED)
find_package(Catch2 CONFIG REQUIRED)

#####################################
# Copy Exe and dll , lib  to bin
#####################################

foreach(CONFIG ${CMAKE_CONFIGURATION_TYPES})
    string(TOUPPER ${CONFIG} CONFIG_UPPER)
    set(CMAKE_VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CONFIG_UPPER} "${CMAKE_SOURCE_DIR}/bin/") # .exe and .dll
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CONFIG_UPPER} "${CMAKE_SOURCE_DIR}/bin/") # .so and .dylib
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CONFIG_UPPER} "${CMAKE_SOURCE_DIR}/bin/lib") # .lib and .a
endforeach()
file(COPY "${CMAKE_SOURCE_DIR}/frontend" DESTINATION "${CMAKE_SOURCE_DIR}/bin/")

#####################################
# Add sub script
#####################################

add_subdirectory(backend)

#####################################
# Export Project
#####################################
foreach(CONFIG ${CMAKE_CONFIGURATION_TYPES})
    install(DIRECTORY "${CMAKE_SOURCE_DIR}/frontend/"  CONFIGURATIONS ${CONFIG} DESTINATION "${CMAKE_SOURCE_DIR}/package/${CONFIG}")
endforeach()

