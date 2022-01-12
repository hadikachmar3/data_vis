###### The Project is based on the Wassabi dataset. There will be 2 types of visualization, The first one is a bubble map that will show the distribution of the artists according to their genre, while the second one is a funnel chart that will show the number of artists belong to a specific genre in order for a chosen country.
###### In order to implement the visualization, we need to go through few steps to deal with the data then implement the visualization. The data processing part is purely done using Rstudio.
###### In the Pre-processing, after fetching the dataset, only few columns will be considered to work with, The columns are [genres, location.country, id_artist_deezer]. The genres column is important for both visualizations, but this column contain some missing data, and some genres names are confusing, so to deal with, the best thing is to create a new column to create sub-classes for the genre, and fill the missing value with a string “Missing value” to be shown in the visualization later on. Next, “location.country” column is important for the bubble map visualization, this visualization will be based on the continent, not per country. To deal with that a new column for the continents can be added based on the “location.country” column. The column called “id_artist_deezer” will be used to identify each artist, then count the artist number for each genre. The last step in the processing part is to add 2 more columns “lat” and ”lng” based on the “continent” column, these 2 columns will be helpful to identify each continent location to show the bubbles correctly on the map. 
###### Once the processing part is done, now comes the implementation of the visualization.
###### The visualization dashboard will look like this: 
![image](https://user-images.githubusercontent.com/38382273/149219924-76d7f8c2-4ab2-4502-808a-3bede3d34b3e.png)
###### Figure 1: shows the visualization dashboard.
###### The 3 containers in the top are used to make it more user friendly, and make it easier to spot the changes. 
          1.	The first container is to show the highest artists number belong to the chosen genre per continent
          2.	The second container is to show the total artists number belong to the chosen genre
          3.	The third container is to show the lowest artists number belong to the Blues genre per continent

