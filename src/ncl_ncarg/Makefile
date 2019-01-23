#
# $Id$
#
# @Copyright@
#
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 7.0 (Manzanita)
#
# Copyright (c) 2000 - 2017 The Regents of the University of California.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided
# with the distribution.
#
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement:
#
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
#
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of
# the associated name, interested parties should contact Technology
# Transfer & Intellectual Property Services, University of California,
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910,
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
#
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# @Copyright@

REDHAT.ROOT = $(CURDIR)/../../
NCAR_CACHE = $(REDHAT.ROOT)/cache

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Pull.mk
include $(SDSCDEVEL)/Rules.mk

$(NAME).spec: DESCRIPTION LICENSE

DESCRIPTION:
	$(MODULE_LOAD_CC); \
	( \
	  $(DESCRIBE_PKG); \
	  $(DESCRIBE_CC); \
	  $(DESCRIBE_MPI); \
	  $(DESCRIBE_HDF5); \
	  $(DESCRIBE_NETCDF) \
	) > $@

LICENSE: $(SRC_DIRS)
	$(CHECK_LICENSE_FILES)
	echo NCL > $@

CTOF = -LGCCHOME/gcc/lib64 -lgfortran
CCOPTIONS = -fPIC -fopenmp -I$(NCAR_CACHE)/udunits/include
FCOPTIONS = -fPIC -fno-f2c -fno-second-underscore -fopenmp -fno-range-check
EXTRAEXPORTFLAGS = -rdynamic
ifeq ("$(COMPILERNAME)", "intel")
  CTOF = -lm -lifcore -lsvml -lifport -lirc
  CCOPTIONS = -qopenmp -INCAR_CACHE/udunits/include
  FCOPTIONS = -qopenmp
  EXTRAEXPORTFLAGS =
else ifeq ("$(COMPILERNAME)", "pgi")
  CTOF = -pgf90libs
  CCOPTIONS = -tp k8-64 -O -Msignextend -Mreentrant -fPIC -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -mp -INCAR_CACHE/udunits/include
  FCOPTIONS = -tp k8-64 -O -Msignextend -Mreentrant -fPIC -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -mp
  EXTRAEXPORTFLAGS =  -Wl,--export-dynamic
endif

build: $(SRC_DIRS)
	mkdir -p $(NCAR_CACHE)
	patch $(SOURCE_DIR)/config/LINUX patch-files/LINUX.patch
	patch $(SOURCE_DIR)/ni/src/ncl/subprocess.c patch-files/subprocess.c.patch
	patch $(SOURCE_DIR)/Configure patch-files/Configure.patch
	cp input $(SOURCE_DIR)
	( \
	  $(MODULE_LOAD_CC); \
          $(MODULE_LOAD_MPI); \
	  $(MODULE_LOAD_HDF5); \
	  $(MODULE_LOAD_NETCDF); \
          module load gsl; \
          export CC=$(CC); \
          export CXX=$(CXX); \
          export FC=$(FC); \
          export F77=$(FC); \
          cd $(SOURCE_DIR)/config; \
          $(MAKE) -j 16 -f Makefile.ini; \
          cd ..; \
          perl -pi -e "s!CTOF!$(CTOF)!g" config/LINUX; \
          perl -pi -e "s!CCOPTIONS!$(CCOPTIONS)!g" config/LINUX; \
          perl -pi -e "s!FCOPTIONS!$(FCOPTIONS)!g" config/LINUX; \
          perl -pi -e "s!CCOMPILER!$(CC)!g" config/LINUX; \
          perl -pi -e "s!FCOMPILER!$(FC)!g" config/LINUX; \
          perl -pi -e "s!HDF5HOME!$${HDF5HOME}!g" config/LINUX; \
          perl -pi -e "s!NETCDFHOME!$${NETCDFHOME}!g" config/LINUX; \
          perl -pi -e "s!MPIHOME!$${MPIHOME}!g" config/LINUX; \
          perl -pi -e "s!NCAR_CACHE!$(NCAR_CACHE)!g" config/LINUX; \
          perl -pi -e "s!EXTRAEXPORTFLAGS!$(EXTRAEXPORTFLAGS)!g" config/LINUX; \
          perl -pi -e "s!GCCHOME!$${GCCHOME}!g" config/LINUX; \
          perl -pi -e "s!GSLHOME!$${GSLHOME}!g" config/LINUX; \
          perl -pi -e "s!HOMEROOT!$(PWD)!g" config/LINUX; \
          ./Configure < input \
	)
	@echo "::: Package $(NAME) build complete :::"
	
install::
	mkdir -p $(ROOT)/$(PKGROOT)
	$(PKGROOT_BIND_MOUNT)
	( \
	  $(MODULE_LOAD_CC); \
          $(MODULE_LOAD_MPI); \
	  $(MODULE_LOAD_HDF5); \
	  $(MODULE_LOAD_NETCDF); \
          module load gsl; \
          export CC=$(CC); \
          export CXX=$(CXX); \
	  cd $(SOURCE_DIR); \
          export PATH=`pwd`:$${PATH}; \
          $(MAKE) Everything -j 16; \
          cp -r $(NCAR_CACHE)/szip/lib/* $(ROOT)/$(PKGROOT)/lib; \
          cp -r $(NCAR_CACHE)/udunits/lib/* $(ROOT)/$(PKGROOT)/lib; \
	)
	$(PKGROOT_BIND_UMOUNT)
	$(INSTALL_LICENSE_FILES)
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -rf $(SOURCE_DIR) DESCRIPTION LICENSE
