# /* vim: set filetype=awk ts=2 sw=2 sts=2 expandtab: */
BEGIN {
  OK["meta"]["author"]  = "Tim Menzies"
  OK["meta"]["email"]   = "tim@menzies.us"
  OK["meta"]["version"] = "0.1"
  OK["meta"]["license"] = "opensource.org/licenses/BSD-3-Clause"
  OK["meta"]["more"]    = "ok2awk.github.io/meta"
}

## 
## 
## ## About Meta
## 


@include "oklib"

function isnum(x) { 
  return x=="" ? 0 : x == (0+strtonum(x)) 
}
function either(x,y) {
  return x=="" ? y : x
}


