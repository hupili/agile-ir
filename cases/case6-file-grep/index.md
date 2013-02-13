# File Grep

## Tools

   * `grep`. esp "-l" option. 
   * `xargs`.
   * `cut`. 
   * `uniq`.

## Problem

Sometimes, we want to grep text by file not by line. 
e.g. I have downloaded all my previous blogs post into 
current folder and want to find the file that has the 
keyword "switch" and "case". 

This is quite normal demand. 

## Trials

### grep by line

This is not what we need but we can try it first to see the difference:

```
$grep switch * | grep case | cut -f1 -d: | uniq
5b7afc03e4f3f77e3812bb16.html
63e406f30f5723c20b46e0f5.html
68db0055fd7f77ccb645ae3d.html
b0aea7345c08eabed1a2d319.html
```

We'll see later that there are less results returned. 
This is understandable. 
A file containing both "switch" and "case" may not contain them 
at the same line.

### Auxiliary Script v1

Note in the line grep mode, we input lines of texts from STDIN 
and output lines of texts to STDOUT. 
In this way, it is very easy to pipline multiple greps. 
We want to reach a similar effect that:

   * STDIN: a list of filenames to grep. 
   * STDOUT: the list of grepped filenames. 

Put the following script in your PATH,
e.g. named as `file-grep.sh`:

```
#!/bin/bash
cat | xargs grep $@ | cut -f1 -d: | uniq | sort -u
```

The use case is:

```
$ls -1 | file-grep.sh switch | file-grep.sh case
39d2153073c0c892a8018ebe.html
4a5fc3ea9cb588dbd439c90a.html
4d8a3ea83232adb9ca130cbb.html
5b7afc03e4f3f77e3812bb16.html
63e406f30f5723c20b46e0f5.html
68db0055fd7f77ccb645ae3d.html
71b32f2d3679773d359bf723.html
7333f8d36415f2d4a8ec9a4b.html
8d68db581b68ad89810a18ae.html
a2f68d01653db8de267fb5cd.html
a311491609378c4221a4e96c.html
b0aea7345c08eabed1a2d319.html
bd4524dd46d4fed08c102968.html
ea07a164b3474cfbf7365499.html
```

The operation looks smooth. 

### Auxiliary Script v2

The above auxiliary script has one drawback. 
It may not execute well on systems that do not support 
more than 256 options from command line. 

The fix is straightforward bash loops:

```
#!/bin/bash
while read line; do
    #echo $line
    re=`grep $@ $line | wc -l`
    #echo $re
    if [[ $re > 0  ]]; then
        echo $line
    fi
done
```

It works but does not look elegant. 

### "-l" option of grep

The following single line hack works perfect for this purpose: 

```
$grep -l switch * | xargs grep -l case
39d2153073c0c892a8018ebe.html
4a5fc3ea9cb588dbd439c90a.html
4d8a3ea83232adb9ca130cbb.html
5b7afc03e4f3f77e3812bb16.html
63e406f30f5723c20b46e0f5.html
68db0055fd7f77ccb645ae3d.html
71b32f2d3679773d359bf723.html
7333f8d36415f2d4a8ec9a4b.html
8d68db581b68ad89810a18ae.html
a2f68d01653db8de267fb5cd.html
a311491609378c4221a4e96c.html
b0aea7345c08eabed1a2d319.html
bd4524dd46d4fed08c102968.html
ea07a164b3474cfbf7365499.html
```

Pros:

   * Faster. "-l" option make grep terminate at first match. 
   * No auxiliary scripts. 
   This makes it easier to invoke everywhere. 

Cons:

   * Similar to our auxiliary script v1, 
   it suffers the number of option limit. 
   * The style is not unified. 
   Compare the command line to the invokation of `file-grep`. 
   The style of file-grep is better. 

Nevertheless, the 2nd drawback is easy to fix:

```
$ls -1 | xargs grep -l switch | xargs grep -l case
```

Now the style is unified. 

### Bash Alias

Note the last example repeat a pattern. 
We can define it as an alias in bash

```
$alias file-grep='xargs grep -l'
```

We invoke it as:

```
$ls -1 | file-grep switch | file-grep case
39d2153073c0c892a8018ebe.html
4a5fc3ea9cb588dbd439c90a.html
4d8a3ea83232adb9ca130cbb.html
5b7afc03e4f3f77e3812bb16.html
63e406f30f5723c20b46e0f5.html
68db0055fd7f77ccb645ae3d.html
71b32f2d3679773d359bf723.html
7333f8d36415f2d4a8ec9a4b.html
8d68db581b68ad89810a18ae.html
a2f68d01653db8de267fb5cd.html
a311491609378c4221a4e96c.html
b0aea7345c08eabed1a2d319.html
bd4524dd46d4fed08c102968.html
ea07a164b3474cfbf7365499.html
```

Looks much better!

## Remarks

   * We can solve the command line option limitation
   if `grep` can take the files to grep from command line itself. 
   If you know better ways, please kindly tell me.
