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

add_subdirectory(brotli)
add_subdirectory(c-ares)
add_subdirectory(gtest)
add_subdirectory(jsoncpp)
add_subdirectory(jwt-cpp)
add_subdirectory(simdjson)
add_subdirectory(yaml-cpp)
add_subdirectory(zlib)
add_subdirectory(mysql-connector-cpp)
add_subdirectory(drogon)