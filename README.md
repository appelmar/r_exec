r_exec
======

Run R programs within SciDB queries

See 
http://goo.gl/zbkj2L  for more examples.


More soon...

This is being revised a lot. The current version uses Rserve and requires that package is installed for R.

This version has a known bug. If you restart SCiDB, you must manually kill the Rserve process on all nodes before restarting SciDB.
