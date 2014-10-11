---
title: "Some notes on this assignment"
author: "milindaj"
date: "October 10, 2014"
output: html_document
---

I am making notes on some observations related different options for reading data. Although I ended up using standard *read.table()* I feel other options, particularly *fread()* under data.table packge is better suited for reading large amount of data. I made some test/comparisions between *fread()* and *read.table()*. I have found *fread()* to be much much faster than *read.table()* or other similar methods. But currently there is an open issue related to *fread()* wherein *na.strings* argument is not handled properly. Thus for this assignment I falling back to *read.table()* to read and process data. 

On my machine (Mac, OX 10.10 with 4 GB ram) here are the observations related to reading data.

**Using data.table - **

```r
system.time ( 
    hpcDF <- read.table("household_power_consumption.txt", sep=";", header = TRUE, colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings='?')
)
```

```
##    user  system elapsed 
##  24.018   0.683  26.160
```

**Using fread() -** 
*fread()* has same syntax as read.table but it returns *data.table* instead of dataframe. 


```r
library(data.table)
system.time ( 
    hpcDT <- fread("household_power_consumption.txt", sep=";", header =       TRUE, colClasses=c("character", "character",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings='?')
)
```

```
## Warning: Bumped column 3 to type character on data row 6840, field contains '?'. Coercing previously read values in this column from logical, integer or numeric back to character which may not be lossless; e.g., if '00' and '000' occurred before they will now be just '0', and there may be inconsistencies with treatment of ',,' and ',NA,' too (if they occurred in this column before the bump). If this matters please rerun and set 'colClasses' to 'character' for this column. Please note that column type detection uses the first 5 rows, the middle 5 rows and the last 5 rows, so hopefully this message should be very rare. If reporting to datatable-help, please rerun and include the output from verbose=TRUE.
## Warning: Bumped column 4 to type character on data row 6840, field contains '?'. Coercing previously read values in this column from logical, integer or numeric back to character which may not be lossless; e.g., if '00' and '000' occurred before they will now be just '0', and there may be inconsistencies with treatment of ',,' and ',NA,' too (if they occurred in this column before the bump). If this matters please rerun and set 'colClasses' to 'character' for this column. Please note that column type detection uses the first 5 rows, the middle 5 rows and the last 5 rows, so hopefully this message should be very rare. If reporting to datatable-help, please rerun and include the output from verbose=TRUE.
## Warning: Bumped column 5 to type character on data row 6840, field contains '?'. Coercing previously read values in this column from logical, integer or numeric back to character which may not be lossless; e.g., if '00' and '000' occurred before they will now be just '0', and there may be inconsistencies with treatment of ',,' and ',NA,' too (if they occurred in this column before the bump). If this matters please rerun and set 'colClasses' to 'character' for this column. Please note that column type detection uses the first 5 rows, the middle 5 rows and the last 5 rows, so hopefully this message should be very rare. If reporting to datatable-help, please rerun and include the output from verbose=TRUE.
## Warning: Bumped column 6 to type character on data row 6840, field contains '?'. Coercing previously read values in this column from logical, integer or numeric back to character which may not be lossless; e.g., if '00' and '000' occurred before they will now be just '0', and there may be inconsistencies with treatment of ',,' and ',NA,' too (if they occurred in this column before the bump). If this matters please rerun and set 'colClasses' to 'character' for this column. Please note that column type detection uses the first 5 rows, the middle 5 rows and the last 5 rows, so hopefully this message should be very rare. If reporting to datatable-help, please rerun and include the output from verbose=TRUE.
## Warning: Bumped column 7 to type character on data row 6840, field contains '?'. Coercing previously read values in this column from logical, integer or numeric back to character which may not be lossless; e.g., if '00' and '000' occurred before they will now be just '0', and there may be inconsistencies with treatment of ',,' and ',NA,' too (if they occurred in this column before the bump). If this matters please rerun and set 'colClasses' to 'character' for this column. Please note that column type detection uses the first 5 rows, the middle 5 rows and the last 5 rows, so hopefully this message should be very rare. If reporting to datatable-help, please rerun and include the output from verbose=TRUE.
## Warning: Bumped column 8 to type character on data row 6840, field contains '?'. Coercing previously read values in this column from logical, integer or numeric back to character which may not be lossless; e.g., if '00' and '000' occurred before they will now be just '0', and there may be inconsistencies with treatment of ',,' and ',NA,' too (if they occurred in this column before the bump). If this matters please rerun and set 'colClasses' to 'character' for this column. Please note that column type detection uses the first 5 rows, the middle 5 rows and the last 5 rows, so hopefully this message should be very rare. If reporting to datatable-help, please rerun and include the output from verbose=TRUE.
```

```
## Read 76.1% of 2075259 rowsRead 2075259 rows and 9 (of 9) columns from 0.124 GB file in 00:00:03
```

```
##    user  system elapsed 
##   2.108   0.261  10.571
```

As mentioned above, although *fread()* is much faster I have not used it for this assignment because the *na.strings* handling is not done properly. In household_power_consumption dataset, NAs are represented as "?". Although *na.strings* argument with value "?" is passed to *fread()* its only applied once the read is completed. Thus when "?" characters are encountered while reading data the corresponding column is coered to character. Which is why we can see bunch of warning messages. After the read all the data needs to be converted back to numeric using *as.numeric()* method. 

In *plot1.R*, I have put the code for reading this text file using fread() and doing subsequent processing on the data.table retured from *fread()*. This code is commented as I am using *read.table()* for this assignment.

Other than *fread()* there can be few other options such as using sqldf package or reading the file as text strem and extracting the required data.
