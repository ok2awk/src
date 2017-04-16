# /* vim: set filetype=awk ts=2 sw=2 sts=2 expandtab: */


BEGIN {In = 1}
gsub(/^"""/,"") { In =  1 - In }


method($0) {
  $0= defMethod($0)  $0                 
}

/^function/ {
  LastFunction=$0
  gsub(/^function[ \t]+/,"",LastFunction)
  gsub(/\(.*/,"",LastFunction)
}

{ pre = In ? "" : "## "
  if (In)  {
    $0 = defParent(LastFunction, $0)
    $0 = defMethodCall($0)
  }
  txt = dashes2Dots( dots2NestedLists($0) )
  print pre txt
} 

#indirect functions

########################################################################
# support code

function defMethodCall(line) {
  return gensub(/\@([A-Z][^\(]*)\(([^,]),/,
                "__message(\\2,\"\\1\",",
                "g",
                line)
}
function defParent(kid,line) {
  return gensub(/__isa\(([^\(]+)\(/,
           "isa(i,\"" kid "\",\"\\1\",\\1(",
           "g",
           line)
}
function method(txt) {
  return txt ~ /^function[ \t]*[A-Z].+[A-Z].*\(/
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

# dots to nested lists
# double dashes to dots
# add defmethod
# exapnd isa
