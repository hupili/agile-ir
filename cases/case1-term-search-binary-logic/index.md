# Term Search and Binary Logic

## A Composite Case

**Question:** 
"Which plays of Shakespeare contain the words *BRUTUS* AND *CAESAR*, but not *CALPURNIA*?"

cd into "data" and perform the following one line hack. 
```
$echo `date`; ls -1 | xargs -i sh -c "cat {} | tr '\n' ' '; echo '>>file:{}'" | grep -i "BRUTUS" | grep -i "CAESAR" | grep -v -i "CALPURNIA" | grep -o ">>file:.*$" | cut -d: -f2 ; echo `date`
Sat Sep 22 18:36:51 HKT 2012
play-antonycleo.txt
play-hamlet.txt
play-henry5.txt
play-henry6p2.txt
play-titus.txt
Sat Sep 22 18:36:52 HKT 2012
```

It gives result in a few seconds on my laptop. 

## Remarks

### awk v.s. tr

Note in the first version, 
I wrote 

```
xargs -i sh -c "awk '{printf(\"%s\",\$0)}' {}; echo '>>file:{}'"
```

instead of 

```
xargs -i sh -c "cat {} | tr '\n' ' '; echo '>>file:{}'" 
```

The former one is twice slower. 
That's because "awk" is more powerful than "tr". 
"awk" is itself a table based scripting language. 
However, "tr" is dedicated to character substitution jobs. 

**Principle**:
Whenever possible use simpler tools. 

## References

   * [http://stackoverflow.com/questions/3936738/bash-cat-multiple-files-content-in-to-single-string-without-newlines](http://stackoverflow.com/questions/3936738/bash-cat-multiple-files-content-in-to-single-string-without-newlines)
