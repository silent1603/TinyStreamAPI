set(TARGET_NAME Application_UnitTests)
project(${TARGET_NAME} LANGUAGES CXX)
file(GLOB_RECURSE TARGET_SOURCES CONFIGURE_DEPENDS *.cpp *.h)
add_executable(${TARGET_NAME} ${TARGET_SOURCES})
target_link_libraries(${TARGET_NAME} PRIVATE Catch2::Catch2 Catch2::Catch2WithMain)
target_compile_options(${TARGET_NAME} PRIVATE ${compiler_options})
target_compile_definitions(${TARGET_NAME} PRIVATE ${compiler_definitions})
target_link_options(${TARGET_NAME} PRIVATE ${linker_flags})
target_include_directories(${TARGET_NAME}
  PRIVATE 
    ${CMAKE_SOURCE_DIR}/src
    # Any other extra include required
)

include(CTest)
include(Catch)
add_test(${TARGET_NAME} ${TARGET_NAME})



