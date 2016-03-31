NAME           = sdsc-ncl_ncarg
VERSION        = 6.2.1
RELEASE        = 0
PKGROOT        = /opt/ncl_ncarg

SRC_SUBDIR     = ncl_ncarg

SOURCE_NAME    = ncl_ncarg
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION).Linux_RHEL6.4_x86_64_nodap_gcc447
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_NAME)-$(VERSION)

TAR_GZ_PKGS       = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
