CMAKE_MINIMUM_REQUIRED(VERSION 2.8...3.18)
PROJECT(demu C CXX)

find_package(PkgConfig QUIET)
if(PKG_CONFIG_FOUND)
  pkg_check_modules(dpdk IMPORTED_TARGET libdpdk)
endif()

SET(CMAKE_CXX_FLAGS "-Wall -Wextra -Wno-unused-parameter -O3 -march=native -DDPDK_VERSION=22")
SET(CMAKE_C_FLAGS "-Wall -Wextra -Wno-unused-parameter -O3 -march=native -DDPDK_VERSION=22")

INCLUDE_DIRECTORIES(
	${CMAKE_CURRENT_SOURCE_DIR}/dpdk/x86_64-native-linux-gcc/include
)

LINK_DIRECTORIES(
	${dpdk_STATIC_LINK_DIRS}
)

ADD_EXECUTABLE(demu main.c)
TARGET_LINK_LIBRARIES(demu ${ALL_LIBS} -Wl,--start-group ${dpdk_STATIC_LINK_LIBRARIES} ${dpdk_STATIC_LDFLAGS} ${dpdk_STATIC_LDFLAGS_OTHER} numa -Wl,--end-group pthread dl rt)

ADD_EXECUTABLE(demuHairpin main_hairpin.c)
TARGET_LINK_LIBRARIES(demuHairpin ${ALL_LIBS} -Wl,--start-group ${dpdk_STATIC_LINK_LIBRARIES} ${dpdk_STATIC_LDFLAGS} ${dpdk_STATIC_LDFLAGS_OTHER} numa -Wl,--end-group pthread dl rt)