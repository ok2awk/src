# /* vim: set filetype=awk ts=2 sw=2 sts=2 expandtab: */
BEGIN {
  OK["strings"]["author"]  = "Tim Menzies"
  OK["strings"]["email"]   = "tim@menzies.us"
  OK["strings"]["version"] = "0.1"
  OK["strings"]["license"] = "opensource.org/licenses/BSD-3-Clause"
  OK["strings"]["more"]    = "ok2awk.github.io/strings"
}

## 
## 
## ## About Strings
## 


@include "oklib"

function chars(n,c,  s) {
  c = c==""? "*" : c
  while(n-- > 0) s = s c
  return s
}

