add_subdirectory(application)
if(BUILD_TESTING)
    enable_testing()
    add_subdirectory(tests)
endif()

foreach(CONFIG ${CMAKE_CONFIGURATION_TYPES})
    install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/res" CONFIGURATIONS ${CONFIG} DESTINATION "${CMAKE_SOURCE_DIR}/package/${CONFIG}")
endforeach()
file(COPY "${CMAKE_CURRENT_SOURCE_DIR}/res" DESTINATION "${CMAKE_SOURCE_DIR}/bin")

