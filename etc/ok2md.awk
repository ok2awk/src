# /* vim: set filetype=awk ts=2 sw=2 sts=2 expandtab: */

BEGIN {In = 1; Pre=1}
gsub(/^"""/,"") {
    In =  1 - In
    if (Pre)
       Pre=0
    else {
      if (In)  {
        print ""
        print "```c " $0
      } else {
        print "```" $0
        print ""
     }
    }
    next
  }
Pre { next }
    { sub(/^#/,"")
      print }
END { if (In) print "```\n" }

