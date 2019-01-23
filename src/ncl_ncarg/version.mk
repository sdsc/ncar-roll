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
RELEASE        = 0
PKGROOT        = /opt/ncl_ncarg

SRC_SUBDIR     = ncl_ncarg

SOURCE_NAME    = ncl_ncarg
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_NAME)-$(VERSION)

TAR_GZ_PKGS          = $(SOURCE_PKG)

RPM.EXTRAS           = AutoReq:No\nAutoProv:No
RPM.PREFIX           = $(PKGROOT)
