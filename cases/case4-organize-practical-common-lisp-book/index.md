# Organize Practical Common Lisp Book

## Front Matter

[Practical Common Lisp](http://www.gigamonkeys.com/book/)
(PCL)
is free online. 

I should quote the words from its website before we proceed. 

> Spread the word
> 
> Like what you've read? Then help spread the word. Recommend this book to your friends. Write a review on Amazon. Blog about it. Link to this page from your web site. Whatever. Apress took a chance, publishing this book when other publishers thought there was no market for a Lisp book. While it's unlikely that I'll get rich off my royalties, we don't have to sell all that many copies for Apress to turn a profit and show the naysayers that Lisp has legs yet.

I haven't finished reading the book yet. 
According to the first ten chapters, 
which I have already read, 
it's worth your time. 
We may not have the chance to widely use LISP in our daily life, 
but the PCL do give a feel to those who are doubting. 
You'll either be convinced that LISP is for your task
or have stronger evidence that LISP is outdated. 
LISP lies in between Functional Programming and Imperative Programming. 
Most of us start with imperative languages. 
It's a good idea to have look at the other ends. 
However, the other end (full functional programming)
is not so widely used in industry. 
LISP may be a reasonable milestone towards functional programming. 

## Question

OK, AD time is over. 
As you can see, the website is so clean and well structured. 
I like it very much. 
After reading the first ten chapters, 
I decide to download it for offline reading. 
It's a good idea organize the pages into a single pdf. 

## Tools Used

   * `wget`
   * `htmldoc`, HTML conversion tool, many options to explore .
   * `xargs`, elaboration on with/without `-i`.

## Procedures

First download the homepage and layout the dir:

```
wget http://www.gigamonkeys.com/book/
mkdir html
cp index.html html/
cp index.html chapter-list
```

Here we copied the index file to `chapter-list`. 
Use your favourate editor to make a chapter list like this:

```
$cat chapter-list 
introduction-why-lisp.html	Introduction: Why Lisp?	
lather-rinse-repeat-a-tour-of-the-repl.html	Lather, Rinse, Repeat: A Tour of the REPL
   ... (more omitted) ...
```

The lines are tab separated. 
1st column is html file path and 2nd column is the title of the chapter.
Actually, 2nd column is not used later. 
I initially made the list in this way because I wanted to make TOC out of it. 
However, as you can see, `htmldoc` is so powerful that it 
generates the TOC without user intervention. 

Then we download the chapters:

```
cut -f1 chapter-list | xargs -i wget "http://www.gigamonkeys.com/book/{}" -O html/{}
```

Next is to convert HTML to PDF and combine the documents. 
Conversion can be done using many tools like LibreOffice Writer shipped with Ubuntu by default. 
As to PDF manipulation, I strongly recommend `pdftk`.
In the following, we explore the tool `htmldoc`, 
which is in Ubuntu repository. 

The first trial is like this:

```
htmldoc -t pdf -f common-lisp-book.pdf `ls -1 html/*`
```

A `common-list-book.pdf` is created at the current folder. 
However, chapters do not come in correct order. 
The order is same as `ls -1 html/*`. 

The second version is :

```
cut -f1 chapter-list | xargs -i echo html/{} | xargs htmldoc -t pdf -f common-lisp-book.pdf
```

It's worth to note the two versions of `xargs` style.
It took me quite a while to realize the different use cases after initial trials. 
The above pipline right appears to be a good example for illustration. 

   * With `-i` option, 
   STDIN is embedded into the position marked by `{}`
   on a per line basis. 
   Number of output lines is equivalent to number of input lines. 
   * With out `-i` option, 
   STDIN is squeezed into one blank separated line and appended to the end of supplied command. 

More specifically, the 2nd section is expanded into (equivalent to):

```
echo html/1.html
echo html/2.html
   ... (more) ...
```

The 3rd section is expanded into (equivalent to):

```
xargs htmldoc -t pdf -f common-lisp-book.pdf html/1.html html/2.html ... (more) ...
```

In the first `xargs`, we want to add "html/" prefix 
so that N pieces of `echo` must be executed if there are N documents. 
In the second `xargs`, we simply want to invoke `htmldoc`, 
which takes parameters in the following way:

```
htmldoc [options] html1 [html2 ... htmlN]
```

We don't want to invoke `htmldoc` N times 
(which will convert N times and the last output overrides everything before). 

Now we have the single PDF document `common-lisp-book.pdf`. 
`htmldoc` already generated a TOC so that we don't have to make it manually now. 

## Remarks

Note the following are equivalent
(if not constrained by maximum number of parameters):

```
cat XXX | xargs -i rm -f {}
cat XXX | xargs rm -f
```

This is where the confusion arises. 
It appears that with or without `-i`, 
there is not much difference, 
except that `-i` allows you to control the position to embed the arguments. 
However, as shown above, the use cases are different. 
Flexible use of `xargs` can save one from writing looping scripts. 

## Reminder

   * Fair use for the PDF book.
   * Help spread the word if you find useful.
