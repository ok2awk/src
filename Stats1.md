# /* vim: set filetype=awk ts=2 sw=2 sts=2  : */

"""

## Testing Stats

"""

@include "oklib"
@include "stats"

function _norm(f, n,r,h) {
	print("")
	Normal(n,10,1)
	Hist(h,5,15,10)
	r=1000
	while(r-- > 0)
		Hist1(h, Normal1(n))	
	Histshow(h)
}
function _beta1(f,  r,h) {
	print("")
	Hist(h,0,1,10)
	r=1000
	while(r-- > 0)
		Hist1(h, beta80())
	Histshow(h)
}
function _dist3(f,  r,h,lst) {
	print("")
	Hist(h,0,16,8)
	r=10000
	split("1,1,1,2,4,8,8,8,8,16",lst,",")
	while(r-- > 0)
		Hist1(h, any2(lst))
	Histshow(h)
}
function _tri(f,  r,h,lst) {
	print("")
	Hist(h,0,100,20)
	r = 10000
	while(r-- > 0)
		Hist1(h,  triangle(20,30,70))
	Histshow(h)
}
function _cliffs(f,   d,r,lst1,lst2,i,j,v1,v2) {
	for(d=0.1; d<=1.5; d += 0.4) {
		r= 1000
	  while(r-- > 0) {
		  lst1[r] = int(100*normal(1,d))
		  lst2[r] = int(100*normal(2,d))
    }
		Cliffs(i)
		Cliffs(j)
		j.how="CliffSlow"
    v1= Cliffs1(i,lst1,lst2)
    v2= Cliffs1(j,lst1,lst2)
		is(f"lt",i.lt,j.lt)
		is(f"gt",i.gt,j.gt)
		is(f"n" ,i.n,j.n)
		is(f"v" ,v1,v2)
}}
BEGIN {
	srand(1)
  tests("_norm,_beta1,_dist3,_tri,_cliffs")
}