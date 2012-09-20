# Term Search and Binary Logic

## A Composite Case

**Question:** 
"Which plays of Shakespeare contain the words *BRUTUS* AND *CAESAR*, but not *CALPURNIA*?"

cd into "data" and perform the following one line hack. 
```
$echo `date`; ls -1 | xargs -i sh -c "awk '{printf(\"%s\",\$0)}' {}; echo '>>file:{}'" | grep -i "BRUTUS" | grep -i "CAESAR" | grep -v -i "CALPURNIA" | grep -o ">>file:.*$" | cut -d: -f2 ; echo `date`
Thu Sep 20 22:00:39 HKT 2012
play-antonycleo.txt
play-hamlet.txt
play-henry5.txt
play-henry6p2.txt
play-titus.txt
Thu Sep 20 22:00:41 HKT 2012
```

It gives result in a few seconds on my laptop. 

