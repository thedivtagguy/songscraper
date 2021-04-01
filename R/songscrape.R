#'@title songscrape
#'@description Display a list of all songs by the selected artist
#'
#' @param artistname Artist name as it appears on the AZlyrics url but in double-quotes
#' @return A dataframe of all songs
#' @export

#To use this, input the artist name as it appears on the AZLyrics website url
#For example, for Iron & Wine, the AZlyrics url is https://www.azlyrics.com/i/ironwine.html
#So the input to the function would be "ironwine"

#Input with double quotes!

#Function to Display Song List
songlist <- function(artistname) {
  options('max.print' = 100000)
  url <- paste0("https://www.azlyrics.com/", substring(artistname, 1, 1),"/",artistname, ".html")
  page <- url
  tryCatch( {
  songs <- page %>%
    xml2::read_html() %>%
    rvest::html_nodes(xpath = "/html/body/div[2]/div/div[2]/div[4]/div/a")%>%
    rvest::html_text() %>%
    as.data.frame()

  chart <- cbind(songs)
  names(chart) <- c("Songs")
  chart <- tibble::as_tibble(chart)
  return(chart %>% print(n = Inf))}, error = function(cond){
    message(paste("URL does not seem to exist:", url))
    message("Here's the original error message:")
    message(cond)
  })
}

#Function to Scrape Lyrics
songscraper <- function(artistname, from, to) {

  #If only name is Specified
  if(missing(from) && missing(to)){
    from = FALSE
  }
 #if only one number is given
  if(missing(to)){
    to = FALSE
  }

  if(from == FALSE){

  url <- paste0("https://www.azlyrics.com/", substring(artistname, 1, 1),"/",artistname, ".html")
  artist <- artistname

  SongsListScrapper <- function(artistname) {
    page <- artistname
    songs <- page %>%
      xml2::read_html() %>%
      rvest::html_nodes(xpath = "/html/body/div[2]/div/div[2]/div[4]/div/a") %>%
      rvest::html_text() %>%
      as.data.frame()


    chart <- cbind(songs)
    names(chart) <- c("Songs")
    chart <- tibble::as_tibble(chart)
    return(chart)
  }

  SongsList <- purrr::map_df(url, SongsListScrapper)
  SongsList

  SongsList %<>%
    dplyr::mutate(
      Songs = as.character(Songs)
      ,Songs = gsub("[[:punct:]]", "", Songs)
      ,Songs = tolower(Songs)
      ,Songs = gsub(" ", "", Songs)
    )

  SongsList$Songs

  #Scrape Lyrics

  wipe_html <- function(str_html) {
    gsub("<.*?>", "", str_html)
  }

  lyrics <- c()
  album <- c()
  name <- c()
  year <- c()
  number <- 1

  for(i in seq_along(SongsList$Songs)) {
    for_url_name <- SongsList$Songs[i]


    #clean name
    for_url_name <- tolower(gsub("[[:punct:]]\\s", "", for_url_name))
    #create url
    paste_url <- paste0("https://www.azlyrics.com/lyrics/", artist,"/", for_url_name, ".html")
    tryCatch( {
    #open connection to url
    for_html_code <- xml2::read_html(paste_url)
    for_lyrics <- rvest::html_node(for_html_code, xpath = "/html/body/div[2]/div/div[2]/div[5]")
    for_album <- rvest::html_node(for_html_code, xpath = "//div[@class='songinalbum_title']/b")
    for_song_names <- rvest::html_node(for_html_code, xpath = "/html/body/div[2]/div/div[2]/b")
    for_song_year <- rvest::html_node(for_html_code, xpath = "//div[@class='songinalbum_title']")
    }, error = function(e){NA})
    for_lyrics <- wipe_html(for_lyrics)
    for_album <- wipe_html(for_album)
    for_song_names <- wipe_html(for_song_names)
    for_song_year <- wipe_html(for_song_year)
    for_song_year <-  gsub("[^0-9.]", "",  for_song_year)
    lyrics[number] <- for_lyrics
    album[number] <- for_album
    name[number] <- for_song_names
    year[number] <- for_song_year

    number <- number +1

    show(paste0(for_url_name, " Scrape Complete!", "[",i,"/",nrow(SongsList),"]"))

    Sys.sleep(10)
  }

  songs <- cbind(lyrics, album, name, year) %>% as.data.frame()
  songs$album <-  gsub("[[:punct:]]", "", songs$album)
  songs$name <- gsub('"', "", songs$name)


  return(songs)
  } else if(to == FALSE){

    url <- paste0("https://www.azlyrics.com/", substring(artistname, 1, 1),"/",artistname, ".html")
    artist <- artistname

    SongsListScrapper <- function(artistname) {
      page <- artistname
      songs <- page %>%
        xml2::read_html() %>%
        rvest::html_nodes(xpath = "/html/body/div[2]/div/div[2]/div[4]/div/a") %>%
        rvest::html_text() %>%
        as.data.frame()


      chart <- cbind(songs)
      names(chart) <- c("Songs")
      chart <- tibble::as_tibble(chart)
      return(chart)
    }

    SongsList <- purrr::map_df(url, SongsListScrapper)
    SongsList

    SongsList %<>%
      dplyr::mutate(
        Songs = as.character(Songs)
        ,Songs = gsub("[[:punct:]]", "", Songs)
        ,Songs = tolower(Songs)
        ,Songs = gsub(" ", "", Songs)
      )

    SongsList$Songs

    #Scrape Lyrics

    wipe_html <- function(str_html) {
      gsub("<.*?>", "", str_html)
    }

    lyrics <- c()
    album <- c()
    name <- c()
    year <- c()
    number <- 1

    SongsList <- SongsList %>% dplyr::slice(1:from)

    for(i in seq_along(SongsList$Songs)) {
      for_url_name <- SongsList$Songs[i]


      #clean name
      for_url_name <- tolower(gsub("[[:punct:]]\\s", "", for_url_name))
      #create url
      paste_url <- paste0("https://www.azlyrics.com/lyrics/", artist,"/", for_url_name, ".html")
      tryCatch( {
        #open connection to url
        for_html_code <- xml2::read_html(paste_url)
        for_lyrics <- rvest::html_node(for_html_code, xpath = "/html/body/div[2]/div/div[2]/div[5]")
        for_album <- rvest::html_node(for_html_code, xpath = "/html/body/div[2]/div/div[2]/div[11]/div[1]/b")
        for_song_names <- rvest::html_node(for_html_code, xpath = "/html/body/div[2]/div/div[2]/b")
        for_song_year <- rvest::html_node(for_html_code, xpath = "/html/body/div[2]/div/div[2]/div[11]/div[1]")
      }, error = function(e){NA})
      for_lyrics <- wipe_html(for_lyrics)
      for_album <- wipe_html(for_album)
      for_song_names <- wipe_html(for_song_names)
      for_song_year <- wipe_html(for_song_year)
      for_song_year <-  gsub("[^0-9.]", "",  for_song_year)
      lyrics[number] <- for_lyrics
      album[number] <- for_album
      name[number] <- for_song_names
      year[number] <- for_song_year

      number <- number +1

      show(paste0(for_url_name, " Scrape Complete!", "[",i,"/",nrow(SongsList),"]"))

      Sys.sleep(10)
    }

    songs <- cbind(lyrics, album, name, year) %>% as.data.frame()
    songs$album <-  gsub("[[:punct:]]", "", songs$album)
    songs$name <- gsub('"', "", songs$name)


    return(songs)

  } else {

    url <- paste0("https://www.azlyrics.com/", substring(artistname, 1, 1),"/",artistname, ".html")
    artist <- artistname

    SongsListScrapper <- function(artistname) {
      page <- artistname
      songs <- page %>%
        xml2::read_html() %>%
        rvest::html_nodes(xpath = "/html/body/div[2]/div/div[2]/div[4]/div/a") %>%
        rvest::html_text() %>%
        as.data.frame()


      chart <- cbind(songs)
      names(chart) <- c("Songs")
      chart <- tibble::as_tibble(chart)
      return(chart)
    }

    SongsList <- purrr::map_df(url, SongsListScrapper)
    SongsList

    SongsList %<>%
      dplyr::mutate(
        Songs = as.character(Songs)
        ,Songs = gsub("[[:punct:]]", "", Songs)
        ,Songs = tolower(Songs)
        ,Songs = gsub(" ", "", Songs)
      )

    SongsList$Songs

    #Scrape Lyrics

    wipe_html <- function(str_html) {
      gsub("<.*?>", "", str_html)
    }

    lyrics <- c()
    album <- c()
    name <- c()
    year <- c()
    number <- 1

    SongsList <- SongsList %>% dplyr::slice(from:to)

    for(i in seq_along(SongsList$Songs)) {
      for_url_name <- SongsList$Songs[i]


      #clean name
      for_url_name <- tolower(gsub("[[:punct:]]\\s", "", for_url_name))
      #create url
      paste_url <- paste0("https://www.azlyrics.com/lyrics/", artist,"/", for_url_name, ".html")
      tryCatch( {
        #open connection to url
        for_html_code <- xml2::read_html(paste_url)
        for_lyrics <- rvest::html_node(for_html_code, xpath = "/html/body/div[2]/div/div[2]/div[5]")
        for_album <- rvest::html_node(for_html_code, xpath = "/html/body/div[2]/div/div[2]/div[11]/div[1]/b")
        for_song_names <- rvest::html_node(for_html_code, xpath = "/html/body/div[2]/div/div[2]/b")
        for_song_year <- rvest::html_node(for_html_code, xpath = "/html/body/div[2]/div/div[2]/div[11]/div[1]")
      }, error = function(e){NA})
      for_lyrics <- wipe_html(for_lyrics)
      for_album <- wipe_html(for_album)
      for_song_names <- wipe_html(for_song_names)
      for_song_year <- wipe_html(for_song_year)
      for_song_year <-  gsub("[^0-9.]", "",  for_song_year)
      lyrics[number] <- for_lyrics
      album[number] <- for_album
      name[number] <- for_song_names
      year[number] <- for_song_year

      number <- number +1

      show(paste0(for_url_name, " Scrape Complete!", "[",i,"/",nrow(SongsList),"]"))

      Sys.sleep(10)
    }

    songs <- cbind(lyrics, album, name, year) %>% as.data.frame()
    songs$album <-  gsub("[[:punct:]]", "", songs$album)
    songs$name <- gsub('"', "", songs$name)


    return(songs)

    }
}

#Function to Scrape N Number of
