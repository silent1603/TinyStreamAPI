# Packaging support
set(CPACK_PACKAGE_VENDOR "TinyStreamAPI")
# these are cache variables, so they could be overwritten with -D,


set(CPACK_PACKAGE_INSTALL_DIRECTORY "${CMAKE_SOURCE_DIR}/export")
set(CPACK_OUTPUT_FILE_PREFIX "${CMAKE_SOURCE_DIR}/_packages")
set(CPACK_PACKAGE_CONTACT "trung.daoquoc@gameloft.com")

set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "TinyStreamAPi is web api for stream")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")
set(CPACK_SOURCE_GENERATOR "TGZ;ZIP")
set(CPACK_GENERATOR "TGZ;ZIP")
set(CPACK_SOURCE_IGNORE_FILES
    /.git
    /dist
    /.*build.*
    /\\\\.DS_Store
)
set(CPACK_STRIP_FILES YES)