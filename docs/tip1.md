
# Tip1: Use ok2awk 

A lot of my tricks are embodied in `ok2awk`, a
pre-processor that adds some useful functionality
to raw AWK.

## Files

`Ok2awk` pulls apart `*.ok` files into

- A documentation file `*.md`.
This documentation is pulled from  markdown
comments found in multi-line strings
that start and end with triple double-quotes `===`.
- A code file *.awk`.
For these code files,
`Ok` comments out those multi-line strings (by prefixing
all those lines with `#`).

The command line for calling `ok` on `xx.ok` is

``
./ok xx

```

## Configuration

Optionally, `ok` is configured by an `ok.rc` file that
defines where all these files are written to:

```
Awk=_var/awk # where to keep the generated awk files
Tmp=_var/tmp # where to write temporaroes
Docs=docs    # where to write the generated markdown files

MyName="'Tim Menzies'"
MyEmail="'tim@menzies.us'"

```

```c 


```
