
# Libok

Checking lib


```c 

@include "ok"

function _ltgt(f) {
  is(f,1, gt(10,8))
  is(f,0, gt(6,8))
  is(f,1, lt(5,10))
  is(f,0, lt(8,6))
}
function _med(f,    x,y,i,w,z,b) {
  for(i=1;i<=10;i++) x[i]=i; is(f, 5.5, median(x))
  for(i=1;i<=8;i++)  b[i]=i; is(f, 4.5, median(b))
  for(i=1;i<=3;i++)  y[i]=i; is(f,   2, median(y))
  for(i=1;i<=7;i++)  w[i]=i; is(f,   4, median(w))
}
BEGIN {
  tests("_ltgt,_med")
}
```
