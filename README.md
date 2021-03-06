# SDSC "ncar" roll

## Overview

This roll bundles ncl-ncarg,ncview  and jasper


For more information about the various packages included in the ncar roll please visit their official web pages:

- <a href="http://www.ncl.ucar.edu" target="_blank">ncl</a> is an interpreted language designed specifically for scientific data analysis and visualization
- <a href="http://http://meteora.ucsd.edu/~pierce/ncview_home_page.html" target="_blank">ncview</a> Ncview is a visual browser for netCDF format files.
- <a href="http://www.ece.uvic.ca/~frodo/jasper" target="_blank">jasper</a> is an open-source initiative to provide a free software-based reference implementation of the codec specified in the JPEG-2000 Part-1 standard

## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate ncar source file(s) using a machine that does
have Internet access and copy them into the `src/<package>` directories on your
Rocks development machine.


## Dependencies


The build process requires the netcdf and hdf5 libraries and assumes that the netcdf
modulefile provided by the SDSC netcdf-roll is available (the netcdf module provides paths
to the hdf5 libraries).  The glut library and include files are required as well.
(CENTOS freeglut-devel.x86_64).
It will build without the modulefile as long as the environment
variables it provides are otherwise defined.


## Building

To build the ncar-roll, execute this on a Rocks development
machine (e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
```

A successful build will create the file `ncar-*.disk1.iso`.  If you built
the roll on a Rocks frontend, proceed to the installation step. If you built the
roll on a Rocks development appliance, you need to copy the roll to your Rocks
frontend before continuing with installation.

This roll source supports building with different compilers and for different
MPI flavors.  The `ROLLCOMPILER` and `ROLLMPI` make variables can be used to
specify the names of compiler and MPI modulefiles to use for building the
software, e.g.,

```shell
make ROLLCOMPILER=intel ROLLMPI=mvapich2_ib 2>&1 | tee build.log
```

The build process recognizes "gnu", "intel" or "pgi" as the value for the
`ROLLCOMPILER` variable; any MPI modulefile name may be used as the value of
the `ROLLMPI` variable.  The default values are "gnu" and "rocks-openmpi".
<ENDIF>

## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll ncar
% cd /export/rocks/install
% rocks create distro
```

Subsequent installs of compute and login nodes will then include the contents
of the ncar-roll.  To avoid cluttering the cluster frontend with unused
software, the ncar-roll is configured to install only on compute and
login nodes. To force installation on your frontend, run this command after
adding the ncar-roll to your distro

```shell
% rocks run roll ncar host=NAME | bash
```

where NAME is the DNS name of a compute or login node in your cluster.

In addition to the software itself, the roll installs ncar environment
module files in:

```shell
/opt/modulefiles/applications/ncar
```


## Testing

The ncar-roll includes a test script which can be run to verify proper
installation of the roll documentation, binaries and module files. To
run the test scripts execute the following command(s):

```shell
% /root/rolltests/ncar.t 
```

