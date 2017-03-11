
# About Rules

AWK is often used as a language for hacking small scripts, or prototyping
throw away scripts.  But after many years of coding in AWK, I've realized
that the langage can also be used for structuring more complex scripts.

So here I record my "rules for big AWK"; i.e.  my methods for doing
writing  abstract data  type libraries in AWK.

Note that some of these rules need a little scripting support-- which
I've coded up in a script called `ok` (described below).

# Rule: Add Nested Accessors

The `ok` script converts words seperated
by "." into array references. So

     a.b["c"].d 
   
becomes

     a["b"]["c"]["d"]

# Rule: Take Care when Initializing Nested Arrays

AWK's default initialization method is to use
empty strings as the default value for new array entries.
To change that, such that nested arrays can
be initialized, I've written a function called `has `that:

- Initializes nested arrays by add a nested key;
- Then deletes that key;
- Thus leaving behind an empty list.


```c 
function has(lst,key) { 
  lst[key][1]
  delete lst[key][1] }
```


Nested intiailizations use a `fun` function that construct
the recursive contents.  


```c 
function have(lst,key,fun) { 
  has(lst,key)
  @fun(lst[key]) }
```


The `haves` function handles
nested constructors with variable number of arguments:


```c 
function haves(lst,key,fun,a,b,c,d) { 
  has(lst,key)
  if      (a=="") @fun(lst[key]) 
  else if (b=="") @fun(lst[key],a) 
  else if (c=="") @fun(lst[key],a,b) 
  else  @fun(lst[key],a,b,c) 
}
```


The next rule shows examples of using `has, have, haves`.

# Rule: Use Constructors

When reading other people's code, it is useful
to have a data definition syntax. This lets newcomers
get a quick overview of how your code works.

My data definition syntax for AWK uses nested
lists and the `has` function described above. 
My data constructors start with an uppercase letter.
For example, the following `Person` has a
year of birth (`yob`), a `gender`, a `jobHistory`
list (which is initially just an empty list) and
a `name`.


```c 
function Person(i, fname, lname, gender, yob) {
  i.yob   = yob
  i.gender= gender
  has(i,"jobHistory")
  haves(i,"name",    "Name",    fname, lname)
}
function Name(i,fname,lname) {
  i.name=fname
  i.last=lname
}
```


Calling `Person(i,"Omar","Khayyam", "m",1048)`
makes "`i`" 
# Rule: Don't Use /pattern/ {action}

This rule is probably not going to be very popular with
traditional AWKers but the more I code in AWK, the more I use
functions rather than the classic AWK
`/pattern/ {action}' main top-level loop. 

We could argue this, it you want
(my email is tim@menzies.us),
but it axiomatic that if you want to build libraries
of reusable sub-routines, then those sub-routines
cannot all assume that they
control the main top-level routine.

It is simple enough to replace `/pattern/ {action}` with
the generic readloop function shown in the next rule.

# Rule: Use Less  Globals

Most AWK scripts have lots of globals,
which makes it hard to build libraries. 

So use less globals, ac

# Rule2: 

# Rule2: Deprecate /pattern/ {action}

Use more functions

# Rule3: Always build Test Suites


```c 

@include "ok"

```

