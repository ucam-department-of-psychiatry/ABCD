### PostProcessing
Code used for post-processing and extraction of variables from pre-processed data.


#### Site differences
![Site differences](/Figures/ABCD_QC.png)

```{r, echo=FALSE, return='asis'}
library(XML)
tables = as.data.frame(readHTMLTable('/Tables/demotable.html')
print(xtable(tables),type='html',comment=FALSE)
```

```{r echo=FALSE, results='asis'}
tmp <- URLencode(paste(readLines("'/Tables/demotable.html'"), collapse="\n"))

cat('<iframe src="data:text/html;charset=utf-8,', tmp ,
    '" style="border: none; seamless:seamless; width: 800px; height: 200px"></iframe>')
```
