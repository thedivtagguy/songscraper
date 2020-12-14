<!-- ABOUT THE PROJECT -->
## Songscraper()


Songscraper is an easy-to-use R package for scraping song lyrics and information for a specific artist from AZLyrics.com
Just input the name, songscraper() does the rest.

<!-- GETTING STARTED -->
## Installation

To get a local copy up and running follow these simple steps.

   ```sh
library(devtools)
install_github("thedivtagguy/songscraper")   

```
## Documentation and Examples 
```
?songscraper
```

<!-- USAGE EXAMPLES -->
## Usage


``` 
#View Song List

songlist(
    "artistname"
)


#Scrape Songs

songscraper(
    "artistname",
    from,
    to
)
```

## Examples

```
## Scrape songs by Iron and Wine
#URL: https://www.azlyrics.com/i/ironwine.html
#Artist Name: ironwine

songscraper("ironwine")

#Remember to put double quotes, otherwise it may be considered an object.

##Scrape top 5 songs based on tibble output of songlist() by Harry Styles
#URL: https://www.azlyrics.com/h/harrystyles.html
#Artist Name: harrystyles

songscraper("harrystyles", 5)


##Scrape songs between song 50 to song 100 by Iron & Wine
#URL: https://www.azlyrics.com/i/ironwine.html
#Artist Name: ironwine

songscraper("ironwine", 50, 100)


#View list of all songs (helpful in determining numbers if you need to choose specific songs)

songlist("ironwine")
```

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)

Currently, I'm looking to add: 

1. Download songs from select albums only.
2. Download songs from select years.
3. Fetch Spotify track ID based on title.


<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

Aman Bhargava - [@thedivtagguy](https://twitter.com/thedivtagguy) - amanbhargava2001@gmail.com

Project Link: [https://github.com/thedivtagguy/songscraper](https://github.com/thedivtagguy/songscraper)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* [Matt M's Rvest scraping tutorial](https://rpubs.com/mattEJ/nickelback)





