# HTMLtoLaTeX
* Using this code you will be able to convert the html file into latex file.

| Function | Min. Requirement |
|:--------------- |:-----------------------------:|
| Compatible with | Linux 16.04                         |
| Prerequisites   | flex 2.6.4, bison 3.5.1, gcc 9.3.0|

* The run.sh can be used to run the entire program providing the output file name and the input file.

```
sh run.sh input.html output.tex
```

* To delete all the files created during the execution run(except .tex file)

```
rm lex.yy.c next.output next.tab.* a.out
```
