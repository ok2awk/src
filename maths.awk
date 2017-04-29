# /* vim: set filetype=awk ts=2 sw=2 sts=2 expandtab: */
BEGIN {
  OK["Maths"]["author"]  = "Tim Menzies"
  OK["Maths"]["email"]   = "tim@menzies.us"
  OK["Maths"]["version"] = "0.1"
  OK["Maths"]["license"] = "opensource.org/licenses/BSD-3-Clause"
  OK["Maths"]["more"]    = "ok2awk.github.io/Maths"
}

## 
## 
## ## About Maths
## 


@include "oklib"

function lt(x,y) { return x < y }
function gt(x,y) { return x > y }

function abs(x)  { 
  return x < 0 ? -1*x : x 
}
function median(lst,
                n,p,q) {
  n = asort(lst)
  p = q = int(n/2+0.5)
  if (n <= 3) { 
    p = 1; q = n
  } else 
    if (!(n % 2) )
      q = p + 1;
  return p==q ? lst[p] : (lst[p]+lst[q])/2
}

function medianSortUp(i,x,j,y) { return x["median"] < y["median"] } 
function medianSortDown(i,x,j,y) { return x["median"] > y["median"] } 

