library(rvest)
library(dplyr)

#Create a movies data frame that is empty. We will be adding data to this for each web page scraped by the for loop
movies = data.frame()

#Every time you go to the next page of 50 movies, 50 gets added to the 1 in "&start=1" in the web URL
#Therefore, we can use a for loop in R to web scrape multiple web pages at once by adding 50 each time
#We would replace the 1 in the URL with page_result so that it increases by increments of 50 (1, 51, 101, etc)
#paste0() command gets rid of the spaces between the strings and concatenates them

for (page_result in seq(from = 1, to = 101, by = 50)) {
  link = paste0("https://www.imdb.com/search/title/?title_type=feature&num_votes=25000,&genres=adventure&start=",
                page_result,"&ref_=adv_nxt")
  page = read_html(link)
  
  #All of this code is the same as in Part 1
  name = page %>% html_nodes(".lister-item-header a") %>% html_text()
  year = page %>% html_nodes(".text-muted.unbold") %>% html_text()
  rating = page %>% html_nodes(".ratings-imdb-rating strong") %>% html_text()
  metascore = page %>% html_nodes(".metascore") %>% html_text()
  runtime = page %>% html_nodes(".runtime") %>% html_text()
  content = page %>% html_nodes(".certificate") %>% html_text()
  
  #We use rbind (row bind) so that every time the for loop runs, it adds movies from the next page to the data table
  #Without rbind, the View(movies) function would only return the last page of results from the web scrape
  movies = rbind(movies, data.frame(name, year, rating, metascore, runtime, content, stringsAsFactors = FALSE))
  
  #This print statement simply prints out the page numbers run by the for loop so that we can confirm the code is working
  print(paste("Page:", page_result))
}