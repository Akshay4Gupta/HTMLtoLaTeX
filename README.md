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

* HTML Tags that this application work with:
..* head
..* body
..* title
..* a, href
..* font: size
..* center
..* br
..* p
..* h1, h2, h3, h4
..* ul, li, ol, ul, dl, dt, dd
..* div
..* u, b, i, em, tt, strong, small,
..* sub, sup
..* img: src, width, height, figure, figcaption
..* table, caption, th, tr, td

* Can also work with Greek words

* bugs:
..* img src do not parse the path correctly
