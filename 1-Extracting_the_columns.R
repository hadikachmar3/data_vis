library(dplyr)

# Albums
df_albums = read.csv("C:\\Users\\hadik\\Downloads\\Visualization\\wasabi_albums.csv")
df_albums
View(df_albums)

# Artists
## Fetching the data
df_artists = read.csv("C:\\Users\\hadik\\Downloads\\Visualization\\wasabi_artists.csv")
View(df_artists)
artists_col_names <- colnames(df_artists, prefix='col')
artists_col_names


## Extract the useful comments for my visualization.

artist_df_new <- select(df_artists, c('genres', 'location.country','locationInfo', 
                                      'lifeSpan.begin','lifeSpan.end','lifeSpan.ended',
                                      'deezerFans', 'id_artist_deezer', 'urlDeezer',
                                      'endArea','endArea.disambiguation', 'endArea.id', 
                                      'endArea.name', 'dbp_genre','type', 
                                      'id_artist_musicbrainz', 'name','disambiguation','gender'))
View(artist_df_new)

## Saving the the artist_df_new offline
# write.csv(artist_df_new,'artist_df_new.csv')

## SONGS
df_songs = read.csv("C:/Users/hadik/Downloads/Visualization/wasabi_songs.csv", head = TRUE, dec=".", quote = ".", sep='.')
df_songs
View(df_songs)

# col_names <- colnames(df_songs, prefix='col')
# # sapply(df_songs, class)
# col_names_splited <- strsplit(as.character(col_names),'.',fixed=TRUE)
# col_names_splited
# 
# 
# 
# 
#  
# 
# 
# 
# 
# songs_df_new <- select(df_songs, c('albumTitle','album_genre', 'title','releaseDate', 
#                                       'rank','genre','begin',
#                                       'artist',  'publicationDate',
#                                       'publicationDateAlbum'))
# 
# 
# 
# 








