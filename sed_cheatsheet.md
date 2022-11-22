# sed-cheatsheet

> sed [option] 'command' input_file
## option:
- -n: silence output
- -f: file
- -i: modified on the raw input_file
- -e:
- -r: use the expand regeExpress

## command
> sed '/selected row/command/pattern/' input_file
### command list
- p: print
- d: delete
- i: insert
- a: append
- c: change
- r: append file
- s: substitute
- y: substitute one by one

## regexp
sed use the basic regexp
|  basic regexp   | expend regexp  |
|  ----  | ----  |
|\\?	  | ?   |
|\\+	  | +   |
|\\|	  | \|  |
|\\{ \\}|	{ } |
|\\( \\)|	( ) |

## Examples

### 1.creat example file
```
head -10 /etc/passwd/ > test.txt
awk '{print NR "    " $0 > "test.txt"}' test.txt
cat test.txt
```
### 2.print or delete
```bash
# print (p) ; not print (!p)
sed -n '1p' test.txt
sed -n '1p;3p;5p' test.txt #(no space before or after ;)
sed -n '1!p' test.txt

sed -n '1~2p' test.txt
sed -n '1~5p' test.txt
sed -n '1,$p' test.txt

sed -n '/root/p' test.txt
sed -n '/root/p;/bin/p' test.txt
sed -n '/root/!p' test.txt 
sed -n '/^[0-9].*bash$/p' test.txt #regexp

# delete (d ; !d)
sed -n '1d' test.txt
sed -n '1!d' test.txt
sed -n '1~2d' test.txt
sed -n '1,$d' test.txt
sed '/^$/d' test.txt
```
### 3.insert, append, change
```bash
# insert or append stringr
sed  '1i\       >-< we are inserted' test.txt
sed  '1a\       >-< we are appended' test.txt
sed  '1~2i\     >-< we are changed' test.txt   # odd rows
sed  '2~2i\     >-< we are changed' test.txt   # even Rows
sed  '/.*/i\    >-< we are inserted' test.txt # all rows

# change stringr of entire row
sed  '1c\       >-< we are changed' test.txt
sed  '1~2c\     >-< we are changed' test.txt
sed '/root/c\   >-< we are changed' test.txt
sed  '1,3c\     >-< we are changed' test.txt # change stringr in 1~3 row to 1 row

# insert file
seq 10 > insert.txt
sed '1r insert.txt' test.txt
sed '/root/r insert.txt' test.txt
```

### 4.substitute
>sed '/specific rows/s/matched content/replacement/flags  
sed 's!matched content!replacement!flags # you can replace / with !

flags:
- 1-9
- g: global re
- p: print
- w: write to a new file
- i: ignore case

```bash
# on all row
sed 's/:/---/' test.txt
sed 's/:/---/3' test.txt
sed 's/:/---/g' test.txt
sed 's/:/---/gw test2.txt' test.txt #output the changed rows to new file

# on specific row
sed '1~2 s/:/---/g' test.txt
sed '/root/s/:/---/g' test.txt

# regexp
sed 's![a-z]\+!\U&!g' test.txt # to capitalize all alphabets
sed 's![a-z]\+!\u&!g' test.txt # to capitalize the first alphabet 
sed 's![a-z]\+!\L&!g' test.txt # transfer all alphabets to lower-case

# keep part of the pattern, \1 refer to the content in the first \( \)
sed 's/\([0-9][ ]\+\)\(.*\)/\1/g' test.txt
sed 's!\([0-9][ ]\+\)\(.*\)!\2!g' test.txt
```