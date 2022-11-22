## Types of grep 
- grep: basic regexp
- egrep: expand regexp (grep -E)
- fgrep: don't support regexp (grep -F)

## Options
- -v
- -n
- -c
- -A/-B/-C
- -i
- -l/-L
- -w
- -r search current directory and subdirectories

## Examples
```bash
# basic use
grep nologin /etc/passwd
# show row 
grep -n nologin /etc/passwd
# reverse selection
grep -v nologin /etc/passwd 
# total row number
grep -c nologin /etc/passwd
# exact selection
grep '\<bin\>' /etc/passwd
grep -w sbin /etc/passwd
# print the row before and/or after interest part
grep -A 1 '^root' /etc/passwd
grep -B 1 '^root' /etc/passwd
grep -C 1 '^root' /etc/passwd
# print the name of file containing interest part
grep -l "root" *.txt
grep -L "root" *.txt #revert selection
# egrep
egrep '^root|bash$' /etec/passwd
# fgrep
grep '^root' /etc/passwd
```