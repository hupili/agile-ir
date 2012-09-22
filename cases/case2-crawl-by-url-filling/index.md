# Crawl by URL Filling

Tools used:

   * curl
   * wget
   * grep
   * cut 
   * xargs 
   * lynx

## Introduction 

The standard crawler:

   * Get some webpage. 
   * Analyze links in the page. 
   * Follow those links. 
   * Repeat the above. 

In most daily cases, things are much easier than that. 
This tutorial uses 
[http://www.opensourceshakespeare.org/](http://www.opensourceshakespeare.org/)
 (OSS)
as an example to present basic crawling:
crawl by URL filling. 

## Objective 

I want to get all the Shakespeare works to do some IR experiments.
OSS turns out to be a good website which has already done a lot 
of works in parsing, indexing and presenting. 
I searched it for a while but only found the download link for its processed database. 
That's too much for my agile IR experiments. 
I only need the raw texts. 
Nevertheless, the texts can be found on OSS website in HTML format. 
Let's get them and convert to plaintext for future use. 

## Analyze the URL

The URL of play list:

[http://www.opensourceshakespeare.org/views/plays/plays.php](http://www.opensourceshakespeare.org/views/plays/plays.php)

Look into the links of that page. 
They look like:

```
http://www.opensourceshakespeare.org/views/plays/playmenu.php?WorkID=allswell
```

Go deeper and find the link to printing version of the same play. 
The link is:

```
http://www.opensourceshakespeare.org/views/plays/play_view.php?WorkID=allswell&Act=&Scene=&Scope=entire&displaytype=print
```

Look around for several other plays and compare the links. 
One can conclude that `WorkID` is the only different parameter. 
Now the problem boils down to:

   * Get the IDs of plays. 
   * Fill in ID in the template URL and download them. 

## Get the IDs 

```
$curl -s 'http://www.opensourceshakespeare.org/views/plays/plays.php' | grep -oP "WorkID=.*?'" | cut -d= -f2 | cut -d"'" -f1
allswell
asyoulikeit
comedyerrors
loveslabours
measure
   (... more output omitted ...)
```

Let's redirect the outputs to a file called "id" for later use. 

## Get the Plays

For quick demo, I kept only the first three lines of complete "id". 
We can construct the download URLs using `xargs`:

```
$mkdir play

$xargs -a id -i wget 'http://www.opensourceshakespeare.org/views/plays/play_view.php?WorkID={}&Act=&Scene=&Scope=entire&displaytype=print' -O play/{}.html
--2012-09-22 13:12:47--  http://www.opensourceshakespeare.org/views/plays/play_view.php?WorkID=allswell&Act=&Scene=&Scope=entire&displaytype=print
   (... more output omitted ...)

$ls -1 play/
allswell.html
asyoulikeit.html
comedyerrors.html
```

## Convert HTML to Plaintext

`lynx` is a pure text browser in many Linux distributions. 
OSS webpages are very clean and well formatted. 
It is properly rendered in lynx. 
We just use the "dump" function of lynx to 
convert HTML to Plaintext. 

```
$mkdir txt

$ls -1 play/ | sed "s/.html$//g" | xargs -i sh -c 'lynx -dump play/{}.html > txt/{}.txt'

$ll txt
total 444K
-rw-rw-r-- 1 hpl hpl 162K Sep 22 17:59 allswell.txt
-rw-rw-r-- 1 hpl hpl 148K Sep 22 17:59 asyoulikeit.txt
-rw-rw-r-- 1 hpl hpl 105K Sep 22 17:59 comedyerrors.txt
```

Use any text editor to open one of the files, 
you will see plain-text-formatted paragraphs like

```
                           Act I, Scene 1

                           Rousillon. The COUNT’s palace.
   _______________________________________________________________________

   Enter BERTRAM, the COUNTESS of Rousillon, HELENA,] [p]and LAFEU, all in
   black]
     * Countess. In delivering my son from me, I bury a second husband.

     * Bertram. And I in going, madam, weep o'er my father's death
       anew: but I must attend his majesty's command, to 5
       whom I am now in ward, evermore in subjection.
```

OK, that is the raw text we are going to use in other cases of this repo. 

There are many ways to strip HTML off. 
e.g. 
Store the following to "strip.php":

```
#!/usr/bin/env php
<?php
	echo strip_tags( file_get_contents( 'php://stdin' ) );
```

If you have php parser, you can convert HTML to text as follows:

```
$cat play/allswell.html | ./strip.php 
```

You can also use 'sed' to substitute every "<xxx>" with empty. 
Those methods have some caveats but still workable. 
In some scenarios they suffice to get what we want. 

## Remarks

   * wget provide function of recursive download ("-r"). 
   It can be used to fast download the webpages. 
   Our method avoid downloading many pages we don't have interest, 
   thus lowering the burden of target server. 
