MY = your dir

THIS
THE
e.g. @include THE/xx -- the = path root
e.g. @include LAST/yy/xxx -- latest version of yy
e.g. @include THIS/xxx -- this package

add a single use ok that compiles the input file
and loads it

add front of line space to by leftover macros

need pathname tricks
- repeated items on a path name (not necessatiyl and error)

path written to magic local file

add a cdpath to find most recent dirs

-slow and fast stuff must be seperated 
- okay sloe
- ok fast
- makefile trick  

ok is a bashrc 
build to different dirs

add awkprof and profile to .gitignore

if ok1 lives in a directory, run its awkpath

install to /usr/share/ok

read the awkpath for the main and check it for repeated files

where to stick the awkpath var?

no need for prefix shared with package.

follow lightwieght deb conventions

t

build only the aa_.ok files

pull apart methods names
expand isa 
add call t

pull apary ok2awk as asperate file

fix o. looks like it is leaving in a procsym

## packages

packages live in a directory `xx`.

files with that directory  have a _prefix convention_:
are all called `xx/xxone.ok, xx/xxtwo.ok`.

for convenience, there should also a main file xx/xx.ok that loads
all the other files:

```
@include "xxone"
@include "xxwo"
etc
```

## directories

any directory names `_*` is part of the ok package mangement system... don't got there

all other directories are packages

## files

across all packages, all files must have unique names since they will
all be copied into one flat directory `$AWKLIB` (hence the  above prefix 
covention).

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

Note that classes have at least one argument for the object, which must be called `i` (analogous to `self` or `this` in other OO languages).
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


_X_ is a system function. programers should never reimplement _such_ functions


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

Test files always start by loading in `oklib` and the file they wwish to test. So the test for `oklibtests`
is in the file `ok/oklibtests1` which starts with:

```
@include "oklib"
@include "oklibtests"
```

Test files contain test functions. The following rules apply for those files:

- Test function names start with a leading `_` character
- Test functions  have one argument `f`;
- Test functions contain a call to `is(f,want,got)` which, when called, prints FAIL if `want` is not `got`.
- Test functions are listed in a final `BEGIN` block at end of file, e.g

```
BEGIN { tests("_testfun1,_testfun2,etc") }
```


Default arguments for functions. seperate creation for use.

Closures(ish). Build a visitor pattern that carries round an oject
