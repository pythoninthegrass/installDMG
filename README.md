# installDMG
Install a bunch of DMGs from a directory.

##CREDIT:##
* Silent install DMG snippet @ http://stackoverflow.com/a/21428907
* Error logging @ http://unix.stackexchange.com/a/145654
* Set $IFS to eliminate whitespace in pathnames. @ http://tldp.org/LDP/abs/html/internalvariables.html
* Quotation marks for variable expansion @ http://unix.stackexchange.com/a/131767
* Find syntax @ http://unix.stackexchange.com/a/153863
* AppleScript @ http://superuser.com/a/526626
* Code output redirected into array @ http://stackoverflow.com/a/9449633
* Array loop and syntax @ http://unix.stackexchange.com/a/34012
* Nesting if/then in for loop @ http://stackoverflow.com/questions/12030316/bash-nesting-if-in-a-for-loop
* Find syntax @ http://serverfault.com/questions/354403/remove-path-from-find-command-output/598631#598631

##Notes##
* Find Syntax
    * "find ." returns './file'
    * "find *" strips filepath
    * "find "$scriptDir"" solves returning top level directory files
    * Removed "-type f" as PKGs are treated as dirs
