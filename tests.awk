# /* vim: set filetype=awk ts=2 sw=2 sts=2 expandtab: */

## 
## 
## ## Testing Tests
## 


@include "oklib"

function tests(fs,   a,f,i,n) {
   n = split(fs,a,",")
   for(i=1;i<=n;i++) {
     f = a[i]
     print " "
     @f(f)
}}
function is(f,want,got,    pre) {
  if (want == got)
    pre="#TEST:\tPASSED"
  else
    pre="#TEST:\tFAILED"
  print pre "\t" f "\t" want "\t" got
}
