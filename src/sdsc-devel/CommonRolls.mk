ifndef __SDSCDEVEL_COMMONROLLS_MK
__SDSCDEVEL_COMMONROLLS_MK = yes

# Makes ROLLDEF calls (see RollStack.mk) for all SDSC rolls that aren't
# specific to a particular cluster.  include this file after including
# RollStack.mk and after defining these make vars:
#
# * MULTI_COMPILER - list of compiler modules to be loaded by rolls that can be
#     built and rolled with more than one compiler
# * MULTI_MPI - list of mpi modules to be loaded by rolls that can be built and
#     rolled with more than one mpi flavor
# * %-ROLLOPTS - optional package-specific ROLLOPTS values

# Implicit roll prereqs, not derived from ROLL{COMPILER,MPI,PY}
abyss_PREREQS = boost
beast_PREREQS = beagle
biotools_PREREQS = boost cmake fftw gnucompiler hdf math scipy
cern_PREREQS = cmake gnucompiler
chemistry_PREREQS = cmake fftw netcdf
cilk_PREREQS = gnucompiler
cpmd_PREREQS = fftw
gaussian_PREREQS = pgi
geo_PREREQS = R
grace_PREREQS = fftw netcdf
gnutools_PREREQS = gnucompiler
guile_PREREQS = gnucompiler gnutools
jags_PREREQS = math R
llvm_PREREQS = gnucompiler python
math_PREREQS = cmake fftw gnucompiler hdf
mpi_PREREQS = gnutools
mrbayes_PREREQS = beagle
ncl_PREREQS = hdf netcdf
netcdf_PREREQS = hdf
octave_PREREQS = fftw hdf
openbabel_PREREQS = cmake
p3dfft_PREREQS = fftw
polymake_PREREQS = boost gnucompiler
r-modules_PREREQS = netcdf R
siesta_PREREQS = hdf netcdf
scipy_PREREQS = llvm
trilinos_PREREQS = cmake
vasp_PREREQS = fftw
vmd_PREREQS = cmake netcdf
vtk_PREREQS = cmake

# Complete roll set categorized by ROLLCOMPILER value...
DEFAULT_COMPILER_ROLLS = \
  abyss amber beagle beast biotools chemistry cipres cpmd dppdiv gamess geo \
  grace jags migrate mpi4py mpiblast mrbayes ncl neuron nwchem octave \
  performance phylobayes polymake python qe R raxml scipy siesta upc vasp vmd \
  vtk
MULTI_COMPILER_ROLLS = \
  atlas boost fftw fpmpi hdf math mpi netcdf p3dfft trilinos
NO_COMPILER_ROLLS = \
  beast2 blcr cern cilk cmake data-transfer ddt fsa gaussian gnucompiler \
  gnutools guile hadoop idl intel julia knime llvm molden mono nagios \
  openbabel pgi r-modules rapidminer stata weka

# ... and again by ROLLMPI value.
DEFAULT_MPI_ROLLS = \
  abyss amber biotools chemistry cpmd dppdiv gamess grace migrate mpi4py \
  mpiblast mrbayes ncl neuron nwchem performance phylobayes qe r-modules \
  raxml siesta upc vasp vmd vtk
MULTI_MPI_ROLLS = \
  boost fftw hdf math fpmpi netcdf p3dfft trilinos
NO_MPI_ROLLS = \
  atlas beagle beast beast2 blcr cern cilk cipres cmake data-transfer ddt fsa \
  gaussian geo gnucompiler gnutools guile hadoop idl intel jags julia knime \
  llvm molden mono mpi nagios octave openbabel polymake pgi python R \
  rapidminer scipy stata weka

# Rolls that support ROLLPY make var
PYTHON_ROLLS = hdf math mpi4py neuron openbabel scipy trilinos vmd

ALL_ROLLS = $(sort $(DEFAULT_COMPILER_ROLLS) $(MULTI_COMPILER_ROLLS) $(NO_COMPILER_ROLLS))

# Single-compiler rolls known to have problems w/intel.
# Intel 2013 gdal compilation aborts w/an internal compiler error.
# Intel 2013-compiled R seems to have memory problems, failing this test:
#    tp<-svd(matrix(rnorm(250*250),250,250))
# Intel-compiled siesta segfaults
NO_INTEL_ROLLS = geo R siesta

# Multi-compiler rolls known to have build failures w/the pgi compilers.
NO_PGI_ROLLS = atlas boost p3dfft trilinos

# Rolls not available from github, generally because of a paid license
RESTRICTED_ROLLS = amber ddt gaussian idl intel pgi stata vasp

# gmake's handling of line continuations makes it difficult to format call
# invocations readably.  Placing the call into a variable to be passed to eval
# is at least better than squishing everything onto a single line.
DEFINE_ALL_ROLLS = \
$$(foreach roll,$$(ALL_ROLLS), \
  $$(call ROLLDEF, \
          $$(roll), \
          $$(if $$(filter $$(roll),$$(MULTI_COMPILER_ROLLS)),ROLLCOMPILER=$$(MULTI_COMPILER)), \
          $$(if $$(filter $$(roll),$$(NO_INTEL_ROLLS)),ROLLCOMPILER=gnu), \
          $$(if $$(filter $$(roll),$$(NO_PGI_ROLLS)),ROLLCOMPILER=$$(MULTI_COMPILER:pgi=)), \
          $$(if $$(filter $$(roll),$$(NO_COMPILER_ROLLS)),ROLLCOMPILER=), \
          $$(if $$(filter $$(roll),$$(MULTI_MPI_ROLLS)),ROLLMPI=$$(MULTI_MPI)), \
          $$(if $$(filter $$(roll),$$(NO_MPI_ROLLS)),ROLLMPI=), \
          $$(if $$(filter $$(roll),$$(PYTHON_ROLLS)),ROLLPY=python), \
          PREREQS=$$($$(roll)_PREREQS), \
          $$(if $$($$(roll)_ROLLOPTS),ROLLOPTS=$$($$(roll)_ROLLOPTS)), \
  ) \
)
comma := ,
empty :=
space := $(empty) $(empty)
$(eval $(subst $(comma)$(space),$(comma),$(DEFINE_ALL_ROLLS)))

# Comet-only
# - qchem
# + slurm
# + matlab
# + mlnx-ofed
# + xsede-stats

# TSCC-only
# + gold
# - tscc-config
# - tscc-private

# Under development
# + cuda - under devel
# + rabbitmq - under devel

# TODO: orphaned?
# - gordon-test-apps
# - lfs
# - lustre
# + perftest - ask Trevor
# - sdsc-sec
# - triton-base - idea became sdsc-roll
# + usetrax - abandoned
# - xsede-common
 
# Rolls marked as deprecated in README.md
# D boltztrap - abandoned
# D dataform - renamed netcdf
# D db2 - abandoned
# D fsl - abandoned
# D garli - merged into raxml
# D gdal - merged into geo
# D geos - merged into geo
# D mkl - merged into intel
# D moab - abandoned
# D mopac - 100-day license
# D papi - merged into performance
# D paraview - installation too complex
# D plink - merged into biotools
# D proj - merged into geo
# D tecplot - abandoned
# D visit - installation too complex

endif # __SDSCDEVEL_COMMONROLLS_MK
