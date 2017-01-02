# Getting-and-Clean-Data-Project
## Steps for running the script
First of all, the script reads the final result into a variable called "review". The following are two ways of running the script. 

1. It is recommended to open the script in R Studio because the View ()function makes it easier to look at the data set. 
2. Alternatively, if you use R Console, it can be ran by using the Source () function, where arguement for the source function is the address of where the script is located plus the file name ("run_analysis.R"). For example: source("/Users/sam/Downloads/run_analysis.R")

## Analysis
The major steps are Merge Datasets, Extraction of Mean and Standard Deviation Columns, Apply Descriptive Names, and Compute Averages.

<b>Merge</b>: applied rbind() to merge datasets.  
<b>Extraction</b>: used grep() and regular expression to search for measurements on mean and standard deviation.  
<b>Descriptive Names</b>: applied gsub() and regular expression to replace abbreviations with more descriptive names. 
<b>Comupate Averages</b>: used aggregate() to compute average for each variable, group by activity and subject.
 
