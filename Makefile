##
# BEGIN_COPYRIGHT
#
# This file is part of SciDB.
# Copyright (C) 2008-2013 SciDB, Inc.
#
# SciDB is free software: you can redistribute it and/or modify
# it under the terms of the AFFERO GNU General Public License as published by
# the Free Software Foundation.
#
# SciDB is distributed "AS-IS" AND WITHOUT ANY WARRANTY OF ANY KIND,
# INCLUDING ANY IMPLIED WARRANTY OF MERCHANTABILITY,
# NON-INFRINGEMENT, OR FITNESS FOR A PARTICULAR PURPOSE. See
# the AFFERO GNU General Public License for the complete license terms.
#
# You should have received a copy of the AFFERO GNU General Public License
# along with SciDB.  If not, see <http://www.gnu.org/licenses/agpl-3.0.html>
#
# END_COPYRIGHT
##

# You'll need SciDB installed with its development packages.
# Example: make SCIDB=/opt/scidb/13.12

CFLAGS=-pedantic -W -Wextra -Wall -Wno-strict-aliasing -Wno-long-long -Wno-unused-parameter -fPIC -D__STDC_FORMAT_MACROS -Wno-system-headers -isystem -O2 -g -DNDEBUG -ggdb3  -D__STDC_LIMIT_MACROS

INC=-I. -DPROJECT_ROOT="\"$(SCIDB)\"" -I"$(SCIDB)/include" -I./extern
LIBS=-shared -Wl,-soname,libr_exec.so -L. -lm -lcrypt -ldl

#INC=-I. -DPROJECT_ROOT="\"$(SCIDB)\"" -I"$(SCIDB)/include" -I"$(BOOST_LOCATION)" -I/usr/include/R -I/home/apoliakov/R/x86_64-redhat-linux-gnu-library/3.0/Rcpp/include -I/home/apoliakov/R/x86_64-redhat-linux-gnu-library/3.0/RInside/include
#LIBS=-shared -Wl,-soname,libr_exec.so,-rpath,/home/apoliakov/R/x86_64-redhat-linux-gnu-library/3.0/RInside/lib -L. -lm -L/usr/lib64/R/lib -lR  -L/usr/lib64/R/lib -lRblas -L/usr/lib64/R/lib -lRlapack -L/home/apoliakov/R/x86_64-redhat-linux-gnu-library/3.0/Rcpp/lib -lRcpp -Wl,-rpath,/home/apoliakov/R/x86_64-redhat-linux-gnu-library/3.0/Rcpp/lib -L/home/apoliakov/R/x86_64-redhat-linux-gnu-library/3.0/RInside/lib -lRInside  

all: Rcon
	@if test ! -d "$(SCIDB)"; then echo  "Error. Try:\n\nmake SCIDB=<PATH TO SCIDB INSTALLATION>\n\nBe sure to have the SciDB development packages installed on your system."; exit 1; fi 
	$(CXX) $(CFLAGS) $(INC) -o plugin.cpp.o -c plugin.cpp

	$(CXX) $(CFLAGS) $(INC) -o LogicalRExec.cpp.o -c LogicalRExec.cpp
	$(CXX) $(CFLAGS) $(INC) -o PhysicalRExec.cpp.o -c PhysicalRExec.cpp

	$(CXX) $(CFLAGS) $(INC) -o libr_exec.so \
	                           plugin.cpp.o \
	                           LogicalRExec.cpp.o \
	                           PhysicalRExec.cpp.o \
	                           Rconnection.cpp.o \
	                           $(LIBS)

Rcon:
	$(CXX) $(CFLAGS) $(INC) -o Rconnection.cpp.o -c Rconnection.cpp

clean:
	rm -f *.o *.so

install:
	cp libr_exec.so "$(SCIDB)/lib/scidb/plugins"

uninstall:
	rm -f "$(SCIDB)/lib/scidb/plugins/libr_exec.so"
