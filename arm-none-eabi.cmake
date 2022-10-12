# Append current directory to CMAKE_MODULE_PATH for making device specific cmake modules visible
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

# Perform compiler test with static library
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(BUILD_SHARED_LIBS FALSE CACHE "disable build shared libs")

set(CMAKE_C_FLAGS   "${MCPU_FLAGS} ${VFP_FLAGS} ${SPEC_FLAGS} -fdata-sections -ffunction-sections -mlong-calls" CACHE INTERNAL "c compiler flags")
set(CMAKE_CXX_FLAGS "${MCPU_FLAGS} ${VFP_FLAGS} ${SPEC_FLAGS} -fdata-sections -ffunction-sections -fno-rtti -fno-exceptions -mlong-calls" CACHE INTERNAL "cxx compiler flags")
set(CMAKE_ASM_FLAGS "${MCPU_FLAGS} ${VFP_FLAGS} ${SPEC_FLAGS} -x assembler-with-cpp" CACHE INTERNAL "asm compiler flags")
set(CMAKE_EXE_LINKER_FLAGS "${MCPU_FLAGS} ${LD_FLAGS} -Wl,--gc-sections,--print-memory-usage" CACHE INTERNAL "exe link flags")
