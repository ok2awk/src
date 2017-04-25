{ n = split($0,a," ")
  for(i=1; i<=n; i++) {
	  split(a[i],b,"/")
	  last[b[1]] = a[i]
  }
  for(i in last) {
	  pat1="/^@include[ \t]+\\\"LAST\\/"i  "/"
	  pat2="@include \\\"" Awk"/"last[i]
	  print "{sub("pat1",\""pat2"\")}"
  }
  print "1"
}
