#####################################
# Define Target Information
#####################################
set(TARGET_NAME Application)
set(TARGET_INCLUDE_FOLDER ${CMAKE_CURRENT_SOURCE_DIR})
project(${TARGET_NAME} LANGUAGES CXX)
file(GLOB_RECURSE TARGET_SOURCES CONFIGURE_DEPENDS *.h *cpp *.cc)


#####################################
# Support IDE Visualization
#####################################
source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${TARGET_SOURCES})

#####################################
# Define Target according to options
#####################################
add_executable(${TARGET_NAME} ${TARGET_SOURCES})

target_link_libraries(${TARGET_NAME} PRIVATE Drogon::Drogon)

#####################################
# Define Target Properties and Optional Dependencies
#####################################


# add target properties such as debug postfix and MSVC runtime
set_target_properties(${TARGET_NAME} PROPERTIES DEBUG_POSTFIX "-d" )

# set target compile options as defined in the cmake/compiler_options.cmake Module
target_compile_options(${TARGET_NAME} PRIVATE ${compiler_options})

# add compiler definition WITH_OPENSSL, if found
target_compile_definitions(${TARGET_NAME} PRIVATE ${compiler_definitions} $<$<BOOL:${BUILD_SHARED_LIBS}>:BUILD_SHARED_CORE> )#$<$<BOOL:${OPENSSL_FOUND}>:WITH_OPENSSL>)

# set target link options as defined in the cmake/compiler_options.cmake Module
target_link_options(${TARGET_NAME} PRIVATE ${linker_flags})

# include all the necessary directories
target_include_directories(${TARGET_NAME}
  PRIVATE 
    ${TARGET_INCLUDE_FOLDER} 
)

target_link_directories(${TARGET_NAME} 
  PRIVATE    ${CMAKE_CURRENT_BINARY_DIR}
)

foreach(CONFIG ${CMAKE_CONFIGURATION_TYPES})
  set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "${PROJECT_NAME}_${CONFIG}")
endforeach()

foreach(CONFIG ${CMAKE_CONFIGURATION_TYPES})
    install(TARGETS ${TARGET_NAME} 
          LIBRARY DESTINATION "${CMAKE_SOURCE_DIR}/package/lib/${CONFIG}"
          ARCHIVE DESTINATION "${CMAKE_SOURCE_DIR}/package/lib/${CONFIG}"
          RUNTIME DESTINATION "${CMAKE_SOURCE_DIR}/package/${CONFIG}"
          CONFIGURATIONS ${CONFIG})
endforeach()

