\name{songscrape}
\alias{songscrape}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
songscrape()
}
\description{
By inputting the artist's name as it appears on AZLyrics.com, songscrape() allows you to scrape all lyrics and album, song name, year details into a dataframe. This can be used for text mining or whatever you wish.

There is also an option scrape specific song lyrics and information based on a range that you specify.
}
\usage{

#View Song List

songlist(
    "artistname"
)


#Scrape Songs

songscrape(
    "artistname",
    from,
    to
)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{"x"}{
Name of artist
}
  \item{from}{
  The song number you want to start from (based on the tibble output of songlist())
  If not specified, the 'to' argument is used.
  }
  \item{to}{
  The song number you want to scrape till.
  If both from and to are not specified, scraper will scrape all songs by artist.
  }
}
\details{
}

\examples{
## Scrape songs by Iron and Wine
#URL: https://www.azlyrics.com/i/ironwine.html
#Artist Name: ironwine

songscrape("ironwine")

#Remember to put double quotes, otherwise it may be considered an object.

##Scrape top 5 songs based on tibble output of songlist() by Harry Styles
#URL: https://www.azlyrics.com/h/harrystyles.html
#Artist Name: harrystyles

songscrape("harrystyles", 5)


##Scrape songs between song 50 to song 100 by Iron & Wine
#URL: https://www.azlyrics.com/i/ironwine.html
#Artist Name: ironwine

songscrape("ironwine", 50, 100)


#View list of all songs (helpful in determining numbers if you need to choose specific songs)

songlist("ironwine")

#assign function to a new object where you want to store the data
df <- songscrape("ironwine")

#scrape only 20 songs
df <- songscrape("ironwine", 20)

#scrape between songs 40 to 60
df <- songscrape("ironwine", 40, 60)
}




% \keyword{ ~song }
% \keyword{ ~textmining }
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
