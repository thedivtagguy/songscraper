\name{songlist}
\alias{songlist}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
songlist()
}
\description{
View a list of all songs by an artist on AZLyrics.com. Outputs a tibble, which can then be used to decide the range of songs (based on index numbers) that you want to scrape.
}
\usage{

#View Song List

songlist(
    "artistname"
        )

}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{"artistname"}{
Name of artist
}
}
\details{
}

\examples{


songlist("ironwine")

#Output:
# A tibble: 170 x 1
#    Songs
#    <chr>
#  1 Lion's Mane
#  2 Bird Stealing Bread
#  3 Faded From The Winter
#  4 Promising Light
#  5 The Rooster Moans
#  6 Upward Over The Mountain
#  7 Southern Anthem
#  8 An Angry Blade
# ...and so on.
}




% \keyword{ ~song }
% \keyword{ ~textmining }
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
