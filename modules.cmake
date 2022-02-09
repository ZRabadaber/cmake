include(FetchContent)

set(COMPONENT_INCLUDE_DIRECTORIES ${CMAKE_CURRENT_BINARY_DIR}/compinents_includes)
include_directories(${COMPONENT_INCLUDE_DIRECTORIES})
file(WRITE ${COMPONENT_INCLUDE_DIRECTORIES}/core_components.h "")

function(module MODULE)
    message(STATUS "Add module: ${MODULE}")

    set(MODULE_NAME ${MODULE})

    FetchContent_Declare(${MODULE_NAME} ${ARGN})
    FetchContent_MakeAvailable(${MODULE_NAME})

    string(TOLOWER "${MODULE}" lcName)
    set(${MODULE_NAME}_SOURCE_DIR ${${lcName}_SOURCE_DIR} PARENT_SCOPE)
    set(${MODULE_NAME}_BINARY_DIR ${${lcName}_BINARY_DIR} PARENT_SCOPE)

    get_property(SUBDIRECTORIES DIRECTORY ${CMAKE_CURRENT_LIST_DIR} PROPERTY SUBDIRECTORIES)
    list(FILTER SUBDIRECTORIES INCLUDE REGEX "^${${lcName}_SOURCE_DIR}$")
    IF (${SUBDIRECTORIES} MATCHES "^.*$")
        #INCLUDE_DIRECTORIES
        get_property(__INC DIRECTORY ${${lcName}_SOURCE_DIR} PROPERTY INCLUDE_DIRECTORIES)
        set_property(DIRECTORY ${CMAKE_SOURCE_DIR} PROPERTY INCLUDE_DIRECTORIES ${__INC})
        #INCLUDES
        get_property(__INCS TARGET ${lcName} PROPERTY INTERFACE_SOURCES)
        set(${lcName}_INTERFACES ${__INCS} PARENT_SCOPE)
        #SOURCES
        get_property(__SRC TARGET ${lcName} PROPERTY SOURCES)
        set(${lcName}_SOURCES ${__SRC} PARENT_SCOPE)
        #COMPILE_DEFINITIONS
        get_property(__DEF DIRECTORY ${${lcName}_SOURCE_DIR} PROPERTY COMPILE_DEFINITIONS)
        set_property(DIRECTORY ${CMAKE_SOURCE_DIR} PROPERTY COMPILE_DEFINITIONS ${__DEF})
        #COMPILE_OPTIONS
        get_property(__OPT DIRECTORY ${${lcName}_SOURCE_DIR} PROPERTY COMPILE_OPTIONS)
        set_property(DIRECTORY ${CMAKE_SOURCE_DIR} PROPERTY COMPILE_OPTIONS ${__OPT})
        #EXPORT MODULE
        set(MODULES ${MODULES} ${MODULE_NAME} PARENT_SCOPE)

        #COMPONENTS
        if (CORE_COMPONENTS)
            if (COMPONENTS)
                set(CORE_COMPONENTS "${CORE_COMPONENTS},")
            endif ()
        endif ()
        if (COMPONENTS)
            set(CORE_COMPONENTS "${CORE_COMPONENTS}${COMPONENTS}" PARENT_SCOPE)
        endif ()
        if (EXISTS ${${MODULE_NAME}_SOURCE_DIR}/component.h)
            file(READ ${${MODULE_NAME}_SOURCE_DIR}/component.h FILE_CONTENT)
            file(APPEND ${COMPONENT_INCLUDE_DIRECTORIES}/core_components.h "${FILE_CONTENT}")
        endif ()

    endif ()
endfunction()

function(module_no_build MODULE)
    list(FILTER MODULES EXCLUDE REGEX "^${MODULE}$")
    set(MODULES ${MODULES} PARENT_SCOPE)
endfunction()

function(modules_ready)
    message(STATUS "Make available modules")
    FetchContent_MakeAvailable(${MODULES})
    message(STATUS "Modules for build: ${MODULES}")

    #define components
    if (CORE_COMPONENTS)
        add_definitions(-DCORE_COMPONENTS=${CORE_COMPONENTS})
    endif()
    message(STATUS "Components: ${CORE_COMPONENTS}")
endfunction()
