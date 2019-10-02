ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = rocks-openmpi
endif
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

NAME           = sdsc-ncl_ncarg
VERSION        = 6.5.0
RELEASE        = 3
PKGROOT        = /opt/ncl_ncarg

SRC_SUBDIR     = ncl_ncarg

SOURCE_NAME    = ncl_ncarg
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_NAME)-$(VERSION)

SZIP_SOURCE_NAME    = szip
SZIP_SOURCE_SUFFIX  = tar.gz
SZIP_SOURCE_VERSION = 2.1
SZIP_SOURCE_PKG     = $(SZIP_SOURCE_NAME)-$(SZIP_SOURCE_VERSION).$(SZIP_SOURCE_SUFFIX)
SZIP_SOURCE_DIR     = $(SZIP_SOURCE_NAME)-$(SZIP_SOURCE_VERSION)


TAR_GZ_PKGS          = $(SOURCE_PKG) $(SZIP_SOURCE_PKG)

RPM.EXTRAS           = AutoReq:No\nAutoProv:No
RPM.PREFIX           = $(PKGROOT)
