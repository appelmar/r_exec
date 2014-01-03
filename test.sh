#!/bin/bash
iquery -aq "load_library('r_exec')"
iquery -ocsv -aq "r_exec(build(<z:double>[i=1:100,10,0],0),'expr=x<-runif(1000);y<-runif(1000);list(sum(x^2+y^2<1)/250)')"

echo "See http://goo.gl/zbkj2L  for more examples."
