# library(caret)
library(tidyverse)
library(dplyr)
# install.packages('stringi')
# install.packages('countrycode')
library(stringi)
library(countrycode)
df_artists_new = read.csv("C:\\Users\\hadik\\Downloads\\Visualization\\my_data\\artist_df_new.csv")

View(df_artists_new)


# Code to add the continents ---------------------------------------------------
df_artists_new$continent <-
  countrycode(sourcevar = df_artists_new[, "location.country"],
              origin = "country.name",
              destination = "continent")

# view(df_artists_new)
# ------------------------------------------------------------------------------

## Add the sub_genres
## rename the genres to sub_genres
names(df_artists_new)[names(df_artists_new) == "genres"] <-
  "sub_genres"

colnames(df_artists_new)
# View(df_artists_new)
# df_artists_new <- head(df_artists_new, 10)

# stri_detect_fixed(df_artists_new$sub_genres[2][1], c("Rock")) == TRUE




for (i in 1:nrow(df_artists_new)) {
  if (stri_detect_fixed(df_artists_new$sub_genres[i], c("Rock")) == TRUE) {
    print(i)
    print(df_artists_new$sub_genres[i])
    df_artists_new$genres[i] = "Rock"
  } else if (df_artists_new$sub_genres[i] == "[]") {
    df_artists_new$genres[i] = "Missing data"
    
  } else if (stri_detect_fixed(df_artists_new$sub_genres[i], c("Electronic")) == TRUE) {
    df_artists_new$genres[i] = "Electronic"
  } else if (stri_detect_fixed(df_artists_new$sub_genres[i], c("Jazz")) == TRUE) {
    df_artists_new$genres[i] = "Jazz"
  } else if (stri_detect_fixed(df_artists_new$sub_genres[i], c("Dubstep")) == TRUE) {
    df_artists_new$genres[i] = "Dubstep"
  } else if (stri_detect_fixed(df_artists_new$sub_genres[i], c("Rhythm")) == TRUE) {
    df_artists_new$genres[i] = "Rhythm"
  } else if (stri_detect_fixed(df_artists_new$sub_genres[i], c("Blues")) == TRUE) {
    df_artists_new$genres[i] = "Blues"
  } else if (stri_detect_fixed(df_artists_new$sub_genres[i], c("Techno")) == TRUE) {
    df_artists_new$genres[i] = "Techno"
  } else if (stri_detect_fixed(df_artists_new$sub_genres[i], c("Pop")) == TRUE) {
    df_artists_new$genres[i] = "Pop"
  } else if (stri_detect_fixed(df_artists_new$sub_genres[i], c("Hop")) == TRUE) {
    df_artists_new$genres[i] = "Hip Hop"
  } else if (stri_detect_fixed(df_artists_new$sub_genres[i], c("Emo")) == TRUE) {
    df_artists_new$genres[i] = "Emo"
  } else if (stri_detect_fixed(df_artists_new$sub_genres[i], c("Comedy")) == TRUE) {
    df_artists_new$genres[i] = "Comedy"
  } else {
    df_artists_new$genres[i] = "Others"
  }
}



#-------------------------------------------------------------------------------
## Get the number
df <- df_artists_new  %>%  group_by(continent) %>% count(genres)

# view(df)
artist_dist_world_df <- aggregate(n ~ genres, data = df, sum)
# View(artist_dist_world_df)

## Add the lng and lat
for (i in 1:nrow(df)) {
  print(i)
  # print(df_artists_new$continent[i])
  if (is.na(df$continent[i])) {
    df$lat[i] = -60.96535
    df$lon[i] = 163.078
  }
  else if (df$continent[i] == "Americas") {
    df$lat[i] = 46.24609
    df$lon[i] = -104.09475
    
  } else if (df$continent[i] == "Europe") {
    df$lat[i] = 49.17557
    df$lon[i] = 13.49344
    
  } else if (df$continent[i] == "Oceania") {
    df$lat[i] = -26.70487
    df$lon[i] = 138.19662
    
  } else if (df$continent[i] == "Africa") {
    df$lat[i] = 13.73973
    df$lon[i] = 20.01333
    
  } else if (df$continent[i] == "Asia") {
    df$lat[i] = 54.67449
    df$lon[i] = 93.61055
  }
  else {
    
  }
}


# Code to save the new dataset -------------------------------------------------
# View(df_artists_new)
write.csv(df, 'artist_df_final.csv')


# Code to delete the [] array NOT APPLIED IN MY VISUALIZATION ------------------
# it was just for testing

# df_artists_new$genres  != "[]"
# df_without_empty_array <- df_artists_new %>% filter(genres != "[]")
# df_without_empty_array$lat <-
#   countrycode(sourcevar = df_artists_new[, "location.country"],
#               origin = "country.name",
#               destination = "continent")
# View((df_without_empty_array))
#-------------------------------------------------------------------------------


# View(df_artists_new)
