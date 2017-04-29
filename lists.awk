# /* vim: set filetype=awk ts=2 sw=2 sts=2 expandtab: */
BEGIN {
  OK["Lists"]["author"]  = "Tim Menzies"
  OK["Lists"]["email"]   = "tim@menzies.us"
  OK["Lists"]["version"] = "0.1"
  OK["Lists"]["license"] = "opensource.org/licenses/BSD-3-Clause"
  OK["Lists"]["more"]    = "ok2awk.github.io/Lists"
}

## 
## 
## ## About Lists
## 


@include "oklib"

function empty(a) { 
  split("",a,"") 
}
function copy(a1,a2,  i) {
  for(i in a1)
    a2[i] = a1[i]
}
function push(i,v) { 
  i[length(i) + 1] = v 
}
function pushes(i,j) { 
  for(k =1; k<= length(j); k++)
    push(i, j[k])
}
function nums(s,a,    i) {
  split(s,a,",")
  for(i in a) a[i] += 0
}
function bsearch(lst,x,approx,lt,gt,
                 lo,mid,hi,val) {
  lo = 1
  hi = length(lst)
  lt = either(lt,"lt")
  gt = either(gt,"gt")
  while (lo <= hi) {
    mid = int(lo + (hi - lo) / 2)
    val = lst[mid]
    if     (@gt(val,x)) hi = mid - 1
    else if(@lt(val,x)) lo = mid + 1  
    else return mid
  }
  return approx ? mid : notFound()
}
function o(l,prefix,order,
           indent,
           old,i) {
  prefix=either(prefix,"o")
  if(! isarray(l)) {
    print "not array",prefix,l
    return 0}
  if(!order)
    for(i in l) { 
      if (isnum(i))
        order = "@ind_num_asc" 
      else 
        order = "@ind_str_asc"
      break
    }     
   old = PROCINFO["sorted_in"] 
   PROCINFO["sorted_in"]= order
   for(i in l) 
     if (isarray(l[i])) {
       print indent prefix "[" i "]"
       o(l[i],"",order, indent "|   ")
     } else
       print indent prefix "["i"] = (" l[i] ")"
   PROCINFO["sorted_in"]  = old 
}

