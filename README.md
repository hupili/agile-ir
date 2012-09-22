agile-ir
========

Principles and Methodology of Agile Personal Information Retrieval

Introduction
----

Information Retrieval (IR) is in our everyday life. 
We are all familiar with Search Engines (SE) now. 
They are very useful in the context of web search. 

Sometimes, we want to search our own documents. 
There are some desktop search software like Google Desktop. 
However, we do not want to install extra softwares on the machine. 
This is especially true if your working environment spans mutiple machines. 

Now the question is: How to perform personal IR in an agile manner?

   * Install extra (probably non-standard, non-open-source) software?? **[NO]**
   * I learned IR before. I'll write my own IR system... **[NO]**
   * Upload everything on my own website and let Google index it... **[NO]**

What agile-ir Is About?
----

   * Principles. e.g. urge you store your materials in plaintext. 
   * Methodologies. e.g. those linux command line hacking (cat, cut, grep, etc). 

What agile-ir Is NOT About?
----

   * Output some off-the-shelf tools. 
   * Create publishable algorithms. 

My Workflow
----

agile-ir will be case-driven.
Anyone can propose "case", which is like a chanllenge:
can you do xxxx?
e.g. "can you compute the number of distinct words in all of Shakespeare's works (poem, sonnet, play)?"
I'll try to handle it using the simplest method I can think of. 

Of course, we assume the raw data is ready. 

Conventions
----

   * I will list the pre-requisite cases and required data sets 
   at the beginning of each case. 
   * Uncompress the referred data set and you will get a 
   directory with the name "data". 
   * We usually assume the current working directory (CWD) is 
   one level up "data". 
   * Else, please follow the command line execution 
   or read context to see the CWD. 
   * I will list the tools used in each case at the beginning of each document. 
   If you are practicing a certain tool, that will be a 
   good source to help you find good use cases. 
   How to find them? 
   Well, after reading several tutorials in agile-ir, 
   you should be able to do that in a few minutes!

FAQ
----

**Q:** 
Your methods are brute force. How to guarantee efficiency? 

**A:** 
I really care little about execution efficiency, 
as long as it is within the human tolerable span. 
For example, you can practice the standard knowledge learned from an IR course for a qurey: 
index, lookup terms, merge term lists, etc. 
How much time does it take you to do so? 
Now think how much time does it take you to write a single line linux command.
For me, I prefer to write something in 30 seconds and let it run in 1 minutes.
It will be a disaster for me to write something in 1 day and let it run in 1 milliseconds.

**Q:**
Do you mean standard IR techniques should be thrown to the trash?

**A:**
NO. 
On the contrary, I cherish them very much. 
If I frequently have certain demand, I will prefer to spend time building the system. 
You may regard agile-ir as the fast prototyping / interactive mining techniques. 
Remember the cases agile-ir is dealing with:

   * You seldom have such demand, 
   so you don't want to waste time building something huge (like a dedicated DB). 
   * Others seldom have such demand, 
   so nobody comes to abstract those operations into a general tool. 
   * You will face different data sets from time to time
   (with different formats). 
   It's very hard to find a universal solution. 

Copy Left
----

Articles, codes, and screenshots under agile-ir is in public domain. 

![copyleft](http://unlicense.org/pd-icon.png)

Data sets are collected from the Internet and redistributed 
with permissions from the author. 
The following list acknowledges the sources:

   * Shakespeare. [http://www.opensourceshakespeare.org/](http://www.opensourceshakespeare.org/)
