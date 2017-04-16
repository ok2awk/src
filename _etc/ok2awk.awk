# /* vim: set filetype=awk ts=2 sw=2 sts=2 expandtab: */


BEGIN {In = 1}
gsub(/^"""/,"") { In =  1 - In }

methodp($0) {
  $0= defMethod(txt)  $0                 
}
{ pre = In ? "" : "## "
  txt = dashes2Dots( dots2NestedLists($0) )
  print pre txt
} 
    
function methodp(txt) {
  return txt ~ /^function[ \t]*[A-Z].*\(/
}
function defMethod(txt) {
  return gensub(/(^function[ \t]+)([A-Z][0-9a-z_]+)([A-Z][A-Za-z_0-9]+)\(.*/,
           "BEGIN { defMethod(\"\\2\",\"\\3\")} ",
           "g",
     txt)
}
function dots2NestedLists(txt) {
  return gensub(/\.([a-zA-Z_])([a-zA-Z0-9_]*)/,
           "[\"\\1\\2\"]",
           "g",
           txt)
}
function dashes2Dots(txt) {
    gsub(/__/,".",txt)
    return txt
}



