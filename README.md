# hw08-BC Liquor App 

### BCL Liquor App Purpose
This App allows users to sort alcoholic beverages sold at BC Liquor stores in order to download, and view options for gifts, dinner parties, or tasting. 


Links: 
URL for the shiny app: [BCL app](https://jasminelib.shinyapps.io/BCL-Data-hw08/)  
The app file is found [here](https://github.com/STAT545-UBC-students/hw08-JasmineLib/blob/master/bcl/app.R)


### Features:

Changes made to the original shiny app:  
- added an option to sort results table by price, also used the DT package to turn the results table interactive, which allows for more options than just sorting table by price.  
- added images of the BC Liquor Store to the UI  
- used tabsetPanel() to create separate tabs, in order to have less visual clutter on the page
- used new packages like shinythemes
- allow user to download results as a .csv file
- allow users to search for multiple alcohol types simultaneously
- app doesn't behave strangely when user selects filters that return 0 anymore
- add a histogram of price, so users can visually look at price ranges for their selection
- render text option
- modify aes features of ggplots, make graphs more detailed (add titles, labels, etc). 


### Credits: 
This repo initially contained the BC Liquor app as a boilerplate for students to add to in Homework 08.

The code and data are from [Dean Attali's tutorial](https://deanattali.com/blog/building-shiny-apps-tutorial). The code can specifically be found [here](https://deanattali.com/blog/building-shiny-apps-tutorial/#12-final-shiny-app-code).


