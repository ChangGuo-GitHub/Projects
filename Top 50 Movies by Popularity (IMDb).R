#Install these two packages if you haven't already. rvest helps with web scraping, dplyr enables piping
#install.packages("rvest")
#install.packages("dplyr")

#Load in the rvest and dplyr libraries
library(rvest)
library(dplyr)

#Create a variable for our link and a variable for our page
#read_html() is an rvest command that creates an html document from a URL consisting of its source code
link = "https://www.imdb.com/search/title/?title_type=feature&num_votes=25000,&genres=adventure&start=1&ref_=adv_nxt"
page = read_html(link)

#Create variables we will scrape from the webpage: the name, year, rating, metascore, runtime and content (rating)
#Download the SelectorGadget extension on Chrome to grab the CSS tag of text on webpages to scrape specific elements
#html_nodes() is an rvest command that selects parts of a document using CSS selectors
#html_text() is an rvest command that extracts text from selected html_nodes()
#The pipe operator %>% is part of the dplyr library and expresses a sequence of multiple operations
name = page %>% html_nodes(".lister-item-header a") %>% html_text()
year = page %>% html_nodes(".text-muted.unbold") %>% html_text()
rating = page %>% html_nodes(".ratings-imdb-rating strong") %>% html_text()
metascore = page %>% html_nodes(".metascore") %>% html_text()
runtime = page %>% html_nodes(".runtime") %>% html_text()
content = page %>% html_nodes(".certificate") %>% html_text()

#Turns our web scraped data into a data frame, which you can view in RStudio using View(movies)
#stringAsFactors = FALSE helps to prevent re-encoding strings and ensures we get text outputs
movies = data.frame(name, year, rating, metascore, runtime, content, stringsAsFactors = FALSE)

#To save this as an Excel file, go to Session->Set Working Directory->To Source File Location and run write.csv()
write.csv(movies, "movies.csv")