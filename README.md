# mos120

This repo contains fixed copies of the annotated BBC MOS 1.20
disassembly from http://mdfs.net/Docs/Comp/BBC/OS1-20/ as well
as scripts and additional files that permit automated conversion
into ca65 syntax.

Building requires _two_ invocations of `./bin/convert.sh` and
then one of `./bin/compile.sh`.

The two passes of `convert.sh` are necessary to be able to convert
both forward and backwards code references into labels - the first
pass finds the addresses that are targets of references, and the
second writes those labels into the source.

Fixes to the original disassembly files include:

- convert all files to NL terminated
- split FC00 file at FF00 so I can use the real ROM contents in place of JIM/FRED/SHEILA
- ensured all hex constants are prefixed accordingly
- replaced a few addresses with computed offsets from labelled addresses
- removed some duplicate chunks of code left over from the file split
- inserted a couple of missing instructions
- fixed character case errors in some string constants
- resolved various other minor typos
