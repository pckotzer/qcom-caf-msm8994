LOCAL_PATH := $(call my-dir)
include $(LOCAL_PATH)/../common.mk
include $(CLEAR_VARS)

LOCAL_MODULE                  := hwcomposer.$(TARGET_BOARD_PLATFORM)
LOCAL_VENDOR_MODULE           := true
LOCAL_MODULE_RELATIVE_PATH    := hw
LOCAL_MODULE_TAGS             := optional
LOCAL_SHARED_LIBRARIES        := $(common_libs) libEGL liboverlay \
                                 libhdmi libqdutils libhardware_legacy \
                                 libdl libmemalloc libqservice libsync \
                                 libbinder libui.vendor

LOCAL_CFLAGS                  := $(common_flags) -DLOG_TAG=\"qdhwcomposer\" -Wno-absolute-value \
                                 -Wno-float-conversion -Wno-unused-parameter
#Enable Dynamic FPS if PHASE_OFFSET is not set
ifeq ($(VSYNC_EVENT_PHASE_OFFSET_NS),)
    LOCAL_CFLAGS += -DDYNAMIC_FPS
endif

LOCAL_HEADER_LIBRARIES        := display_headers generated_kernel_headers
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
include $(BUILD_SHARED_LIBRARY)
