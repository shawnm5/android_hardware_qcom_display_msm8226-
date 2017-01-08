LOCAL_PATH := $(call my-dir)
include $(LOCAL_PATH)/../common.mk
include $(CLEAR_VARS)

# hwc.cpp uses GNU old-style field designator extension.
LOCAL_CLANG_CFLAGS            += -Wno-gnu-designator
LOCAL_MODULE                  := hwcomposer.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_PATH             := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS             := optional
LOCAL_C_INCLUDES              := $(common_includes) $(kernel_includes)
LOCAL_SHARED_LIBRARIES        := $(common_libs) libEGL liboverlay \
                                 libexternal libqdutils libhardware_legacy \
                                 libdl libmemalloc libqservice libsync \
                                 libbinder libmedia libvirtual

ifeq ($(TARGET_USES_QCOM_BSP),true)
LOCAL_SHARED_LIBRARIES += libskia
endif #TARGET_USES_QCOM_BSP

LOCAL_CFLAGS                  := $(common_flags) -DLOG_TAG=\"qdhwcomposer\"
LOCAL_ADDITIONAL_DEPENDENCIES := $(common_deps)
LOCAL_SRC_FILES               := hwc.cpp          \
                                 hwc_utils.cpp    \
                                 hwc_uevents.cpp  \
                                 hwc_vsync.cpp    \
                                 hwc_fbupdate.cpp \
                                 hwc_mdpcomp.cpp  \
                                 hwc_copybit.cpp  \
                                 hwc_qclient.cpp  \
                                 hwc_dump_layers.cpp \
                                 hwc_ad.cpp \
                                 hwc_virtual.cpp

#unneeded below ???
ifeq ($(TARGET_USES_DELTA_PANEL),true)
LOCAL_CFLAGS                  += -O3 -march=armv7-a -mfloat-abi=softfp -mfpu=neon
LOCAL_CFLAGS                  += -DDELTA_PANEL
LOCAL_CFLAGS                  += $(DELTA_PANEL_CFLAGS)
LOCAL_LDLIBS                  := -llog -ldl
LOCAL_ARM_MODE                := arm
LOCAL_SRC_FILES               += hwc_delta_panel.cpp
endif #TARGET_USES_DELTA_PANEL
#unneeded above ???

include $(BUILD_SHARED_LIBRARY)