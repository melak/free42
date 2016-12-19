#!/bin/sh
if [ -f ${CC}libbid.a ]; then exit 0; fi
tar xvfz ../inteldecimal/IntelRDFPMathLib20U1.tar.gz
cd IntelRDFPMathLib20U1
patch -p0 <../intel-lib-linux.patch
if [ "$( uname -s )" = "FreeBSD" ]
then
	patch -p0 <../intel-lib-freebsd.patch
fi
cd LIBRARY
${MAKE} CC=${CC} CALL_BY_REF=1 GLOBAL_RND=1 GLOBAL_FLAGS=1 UNCHANGED_BINARY_FLAGS=0
mv libbid.a ../../${CC}libbid.a
cd ../..
( echo '#ifdef FREE42_FPTEST'; echo 'const char *readtest_lines[] = {'; tr -d '\r' < IntelRDFPMathLib20U1/TESTS/readtest.in | sed 's/^\(.*\)$/"\1",/'; echo '0 };'; echo '#endif' ) > readtest_lines.cc
