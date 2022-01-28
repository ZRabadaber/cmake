if(NOT MCU)
  set(MCU ${CMAKE_SOURCE_DIR}/cube)
endif()

message(STATUS "STM32CubeMX files root: ${MCU}")

add_definitions(-DUSE_HAL_DRIVER)

#LD script
file(GLOB LD_SCRIPT ${MCU}/*.ld)
set(LINKER_SCRIPT ${LD_SCRIPT})

#INCLUDE dirs
file(GLOB_RECURSE MCU_INLUDE_DIRS LIST_DIRECTORIES true ${MCU}/___fake___file___)
list(FILTER MCU_INLUDE_DIRS INCLUDE REGEX "^.*[Ii]nc(lude)?$")

#C sources
file(GLOB_RECURSE MCU_SOURCES LIST_DIRECTORIES false ${MCU}/*.c)
list(FILTER MCU_SOURCES EXCLUDE REGEX "^.*template.c$")

#ASM sources
file(GLOB_RECURSE MSU_ASM LIST_DIRECTORIES false ${MCU}/*.s)
list(FILTER MSU_ASM EXCLUDE REGEX "^.*template.s$")

include_directories(${MCU_INLUDE_DIRS})
set(SOURCES ${SOURCES} ${MCU_SOURCES} ${MSU_ASM})
