# Add sdsc libraries to search paths
if (-d /opt/sdsc/lib) then
  if (! $?PYTHONPATH) then
    setenv PYTHONPATH /opt/sdsc/lib
  else if ( "$PYTHONPATH" !~ */opt/sdsc/lib* ) then
    setenv PYTHONPATH ${PYTHONPATH}:/opt/sdsc/lib
  endif
  if (-d /opt/sdsc/lib/lib/python2.6/site-packages) then
    setenv PYTHONPATH ${PYTHONPATH}:/opt/sdsc/lib/python2.6/site-packages
  endif
  if (! $?LD_LIBRARY_PATH) then
    setenv LD_LIBRARY_PATH /opt/sdsc/lib
  else if ( "$LD_LIBRARY_PATH" !~ */opt/sdsc/lib* ) then
    setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/opt/sdsc/lib
  endif
endif

# Add sdsc scripts to path
if (-d /opt/sdsc/bin) then
  if (! $?path ) then
    set path = ( /opt/sdsc/bin )
  else if ( "$path" !~ */opt/sdsc/bin* ) then
    set path = ( $path /opt/sdsc/bin )
  endif
endif
if (-d /opt/sdsc/sbin) then
  if (! $?path ) then
    set path = ( /opt/sdsc/sbin )
  else if ( "$path" !~ */opt/sdsc/sbin* ) then
    set path = ( $path /opt/sdsc/sbin )
  endif
endif

# Env vars to locate SDSC resources
setenv SDSCHOME /opt/sdsc
setenv SDSCDEVEL /opt/sdsc/devel
