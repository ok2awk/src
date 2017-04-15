build only the aa_.ok files

pull apart methods names
expand isa 
add call t

pull apary ok2awk as asperate file

fix o. looks like it is leaving in a procsym

## error message

nonexistance functions as error messags

## Config

You config options are stored  in $HOME/.config/ok/config

## Objects

Words are 
`A-Z` or `a-z` or `0-9` or `_`.

Up words are words that start with `A-Z`.

Down words are words that start with `a-z_`.

Single parent inheritance

Classes are GAWK functions whose names are up words with only one upper case letter. For example:

```
function Histogram(i) {
  has(i,"bars")
}

```

Note that classes have at least one argument for the object, typically called `i` (analogous to `self` or `this` in other OO languages).
Classes intialize the contents of the object `i`.

Subclasses include the call `isa(Superclass(i))`. The last argument is optitional. 
To declare a subclass, include the call `isa(Superclass(i))`.

```
function SymbolGram(i) { # histogram for counts of symbols
  isa(Histogram(i))
  has(i,"words")
}
```

Note that the `ok` pre-preporcessor expands `isa(X)` into the function `Classname` to 

```
OK.Oklib.class.parent[Classname]=X; isa(i,"Classname",X)
```

Methods are GAWK functions whose name are two or more upwords where the first up word is the class and the renaming is the  method name.
For example 

Function names are down words.


any combinations of 

Classes are functions with only one upper case leading letter; e.g. `Hist`.

Methods are functions that start with a Class letter Following myNamenuppera


## Files

Awk files end in .awk

Ok files end in .ok

- File names do not use uppercase letters since since commonly used
  operating systems (e.g. Mac) do not distinguish them.
- App filenames end in a `_` character.

Ok files start with a modeline (which you can set to empty string in your `ok/config` file) and a `meta` block eg

```
BEGIN {
  OK.maths.author  = "Tim Menzies"
  OK.maths.email   = "tim@menzies__us"
  OK.maths.version = "0.1"
  OK.maths.license = "opensource__org/licenses/BSD-3-Clause"
  OK.maths.more    = "ok2awk__github__io/maths"
}
```

## Variables

locals

globals

hunt for rogue locals

## Conversions

awk and ok files are converted then placed onto the AWKPATH, in some other directory specified in $HOME/.config/ok/config

To convert library files:
- Change suffix from .ok to .awk
- Then change a.b.c to a["b"]["c"]
- Then change "__" to "."

Apps are scripts placed somewhere on the path.

- When converting apps

Tests files have a numeric suffix 1,2,3,4; e.g. `Hist1.ok`. 
The `ok` test engine runs all the `*1.ok` files before
`*2.ok` tests before `*3ok` tests before `*4ok` tests.
So place quick unit tests in `*1.ok` files and slow system tests
are held in `*4.ok` files (and in between, you can get creative). 

Test files contain test functions. The following rules apply for those files:

- Test function names start with a leading `_` character
- Test functions  have one argument `f`;
- Test functions contain a call to `is(f,want,got)` which, when called, prints FAIL if `want` is not `got`.
- Test functions are listed in a final `BEGIN` block at end of file, e.g

```
BEGIN { tests("_testfun1,_testfun2,etc") }
```



