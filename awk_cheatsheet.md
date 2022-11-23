## awk
>awk [option] 'BEGIN{} /specific rows/{command} END{}' file

option:
- -F: the separator of field
- -f: script
- -v: define variables

parameters:
- $0: entire row
- $1: the first part of each row
- NF: the number of fields
- NR: the row number, start from 1 for the first file
- FNR: the row number, start from 1 for each files
- FS: define the separator of field in BEGIN
- RS: the row separator, default \n 
- ~: fuzzy matching
- ==: exact matching
- &&: and
- ||: or
- OFS: the separator of field of output results, default space
- ORS: the separator of row of output results, default \n

## Examples
### 1.print
```bash
# print single field
awk '{print $0}' /etc/passwd
awk '{print "a"}' /etc/passwd | wc # print a with the same number of rows

# print multiple fields
awk -F: '{print $1,$3}'  /etc/passwd # the separtor of field1 and field3 is space
awk -F: '{print $1 $3}'  /etc/passwd # no separator between field1 and field3
awk -F: '{print $1,$3,$6}' OFS="\t" /etc/
passwd # use OFS assign separator = "\t"
awk -F: '{print $1,"\t",$3,"\t",$5}'  /etc/passwd # manually add separtor

# print NR and NF
awk '{print NR,$0}' /etc/passwd
awk -F: 'NR%2==1{print NR," ",$0}' /etc/passwd # print odd rows
awk -F: 'NR==5 || NR==6{print}'  /etc/passwd  
awk -F: '{print NF}' /etc/passwd # the number of fields
awk -F: '{print $NF}' /etc/passwd # print the last field
awk -F: 'NF==4{print }' /etc/passwd # print rows with only 4 fields, != print $4

# print to file
awk -F: '{print $1  > "./test.txt"}' /etc/passwd

# format output
 awk -F: '{printf ("%-20s %2s %.2f \n",$1,$2,$3)}' /etc/passwd

```

### 2.Matching
```bash
# stringr matching
awk '!/root/' /etc/passwd
awk '/root|mail/ {print}' /etc/passwd # matching the row including root or mail
awk '/root/,/mail/ {print}' /etc/passwd # matching all rows between root row and mail row
awk -F: '$1=="root" {print $0}' /etc/passwd
awk -F: '$1=="root"||$1=="mail" {print $0}' /etc/passwd
awk -F: '$1~/root/ {print $0}' /etc/passwd # matching the rows with the first field is similar to root
awk -F: '$1~/root|mail/ {print $0}' /etc/passwd
```

### 3.Cycle
```bash
# If else
awk -F: '{if($1~/root/) print $0}' /etc/passwd 
awk -F: '{if($1~/root/) {print $0} else {print NR}}' /etc/passwd
awk -F: '{if($3>100) print "large"; else print "small"}' /etc/passwd
awk -F: '{if($3<100) next; else print $3}' /etc/passwd
awk -F: '{print (NR,"==",$3>100 ? "yes":"no")}' /etc/passwd
awk -F: '{print ($3>100 ? "yes":"no")}' /etc/passwd
awk -F: 'BEGIN{i=0} {if(i<NF) print NR,NF,i++}' /etc/passwd
awk -F: 'BEGIN{i=1} {if(i<NF) {print NR,NF,i} i++ }' /etc/passwd

# while
awk -F: 'BEGIN{i=1} {while(i<NF) print NF,$i,i++}' /etc/passwd

# for
ls -l|awk 'NR!=1 && !/^d/{sum[$6]++} END{for (i in sum) printf "%-4s %-5s %d\n",i," ",sum[i]}'
ls -l|awk 'NR!=1 && !/^d/{sum[$6]+=$5/1024} END{for (i in sum) printf "%-4s %-2s %8.2f %2s\n",i," ",sum[i],"KB"}'
```

### 4.&& and ||
```bash
awk -F: '$1~/mail/ && $3>8 {print }' /etc/passwd
awk -F: '{if($1~/mail/ && $3>8) print }' /etc/passwd
awk -F: '$1~/mail/ || $3>1000 {print }' /etc/passwd
awk -F: '{if($1~/mail/ || $3>1000) print }' /etc/passwd 
```
### 5.calculation
```bash
awk -F: '$3+$4 > 200' /etc/passwd
awk -F: '{print int($3/10)}' /etc/passwd
awk 'BEGIN{X=1} /^$/{X+=1} END{print "I find",X,"blank lines."}' /etc/passwd
awk -F: 'BEGIN{SUM=0;print "$3","$4","$3+$4"} {SUM=$3+$4;print 
$3,$4,SUM}' /etc/passwd

# the output difference between the postion of "print"
ls -l | awk 'BEGIN{SUM=0} !/^$/{SUM+=$5;print SUM}'
ls -l | awk 'BEGIN{SUM=0} !/^$/{SUM+=$5} END{print SUM}'
```
