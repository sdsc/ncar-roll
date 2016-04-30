ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLMPI
  ROLLMPI = rocks-openmpi
endif
MPINAME := $(firstword $(subst /, ,$(ROLLMPI)))

NAME           = sdsc-ncview
VERSION        = 2.1.7
RELEASE        = 1
PKGROOT        = /opt/ncview

SRC_SUBDIR     = ncview

SOURCE_NAME    = ncview
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

UDUNITS_SOURCE_NAME    = udunits
UDUNITS_SOURCE_SUFFIX  = tar.gz
UDUNITS_SOURCE_VERSION = 2.2.20
UDUNITS_SOURCE_PKG     = $(UDUNITS_SOURCE_NAME)-$(UDUNITS_SOURCE_VERSION).$(UDUNITS_SOURCE_SUFFIX)
UDUNITS_SOURCE_DIR     = $(UDUNITS_SOURCE_PKG:%.$(UDUNITS_SOURCE_SUFFIX)=%)

TAR_GZ_PKGS       = $(SOURCE_PKG) $(UDUNITS_SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No
