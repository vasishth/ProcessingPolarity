                   Instructions for using the ACT-R code

                 This README was written by Sven Bruessow
                      lightly edited by S. Vasishth
                 For questions, contact: vasishth@acm.org
                 Date of last modification: Jan 11, 2007

INSTALLATION AND BASIC USAGE

These instructions are only for Macs. You are on your own for Unix and
Windows, though it should be possible to run the system on those OSes.

(-1) First you have to install openmcl on a Mac. If you want to build the
     plots you should also install R.

(0) Assuming you are using a Mac, install the ACT-REnhanced directory
    in your /Applications directory (though anywhere is fine), and
    then in your .bashrc file write the line

alias loadactr ='/pathto/openmcl -l "/pathto/ACT-REnhanced/loader.lisp' 

(1) bunzip2 and untar latest9.tar.bz2
 This should extract to

-rw-r--r--   1 vasishth  staff   1681  8 Jul 23:37 chunk-types.actr
-rw-r--r--   1 vasishth  staff   2135  8 Jul 23:39 chunks.actr
-rw-r--r--   1 vasishth  staff   2140  8 Jul 23:43 commands.actr
-rw-r--r--   1 vasishth  staff   2638  8 Jul 23:37 constants.actr
-rw-r--r--   1 vasishth  staff  11688  8 Jul 23:37 interface-code.actr
-rw-r--r--   1 vasishth  staff   7966  8 Jul 23:37 lex-support.actr
-rw-r--r--   1 vasishth  staff   5118  8 Jul 23:37 patches.actr
-rw-r--r--   1 vasishth  staff  31801 14 Jul 20:58 productions.actr
drwxr-xr-x  23 vasishth  staff    782 26 Aug 13:47 scripts
-rw-r--r--   1 vasishth  staff   3509  8 Jul 23:46 sp.actr
-rw-r--r--   1 vasishth  staff   5485  8 Jul 23:37 stuff.lisp
drwxr-xr-x   8 vasishth  staff    272 26 Aug 13:46 traces

(2) start ACT-R (type loadactr and hit enter) and load "sp.actr".
5D
(load "sp.actr")

(3) have a look at "stuff.lisp". If you want to gather the sentences
with the "pirate" sentences, THERE ARE ALREADY 500 RUNS for each condition
with partial matching set to T, activation noise 0.15, 0.30 and 0.45.

You write more trace files for each condition with

> (tof-pirat 50)

You can chose a higher value as 50, BUT REMEMBER the exponential
increase in duration when running the model. I decided to let it run
several times and concatenate the traces to the existing ones
afterwards. 

I'll explain how to do this next.

Call the function and when it is finished QUIT ACT-R.

(4) In the folder "traces" you find the newly created traces and
folders with the already existing traces (those the fresh traces
should be concatenated to)

> ls -l traces/
total 816
-rw-r--r--   1 vasishth  staff  65952 30 Oct 17:10 trace.pirat-a
-rw-r--r--   1 vasishth  staff  66364 30 Oct 17:11 trace.pirat-b
-rw-r--r--   1 vasishth  staff  66404 30 Oct 17:11 trace.pirat-c
-rw-r--r--   1 vasishth  staff  66086 30 Oct 17:11 trace.pirat-d
-rw-r--r--   1 vasishth  staff  66179 30 Oct 17:11 trace.pirat-e
-rw-r--r--   1 vasishth  staff  65909 30 Oct 17:11 trace.pirat-f
drwxr-xr-x  33 vasishth  staff   1122 30 Oct 17:01 traces-pirat-ans015
drwxr-xr-x  19 vasishth  staff    646  2 Jul 23:33 traces-pirat-ans030
drwxr-xr-x  17 vasishth  staff    578  2 Jul 23:33 traces-pirat-ans045

 (5) In the top-level "scripts" folder you find some bash-scripts.

From the traces folder execute

../scripts/conc-traces-pirat-ans015.sh

This concatenate the new traces to the old ones in the corresponding
folder. If not, copy the appropriate concatenation script to the
"traces" folder . WHICH SCRIPT YOU USE DEPENDS ON THE ACTIVATION NOISE
PARAMETER YOU HAVE SET IN "commands.actr"! 

(6) Now you have to repeat the whole procedure, start ACT-R, call the
function....until you have 1000 runs complete.

(7) Then you can change to the folder where you gathered the traces,
i.e. "traces-pirat-ans015". There again are several scripts. Type...

./doit.sh

This invokes the awk-scripts and generates the tables for R (*.completed, *.txt)

(8) There are also several R scripts for plotting the results of the
    simulations.

For questions, contact any of:
sven.bruessow@psychologie.uni-heidelberg.de, vasishth@acm.org