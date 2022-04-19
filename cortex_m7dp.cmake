# Name of the target
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

set(MCPU_FLAGS "-mthumb -mcpu=cortex-m7")
set(VFP_FLAGS "-mfloat-abi=hard -mfpu=fpv5-dp-d16")
set(SPEC_FLAGS "--specs=nano.specs")
set(LD_FLAGS "--specs=nosys.specs")

include(${CMAKE_CURRENT_LIST_DIR}/arm-none-eabi.cmake)
