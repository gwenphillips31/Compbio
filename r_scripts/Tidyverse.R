### Tidyverse and SQL
### 19 Feb 2026
### Gwen Phillips

#############################################################

install.packages(sqldf)
install.packages(tidyverse)

library(sqldf)
library(tidyverse)

### filter(), arrange(), select(), summarize(), group_by(), and mutate()

### start with built in dataset

### to specify what package you're using, you can first call on the package name
dplyr:: filter()

data(starwars)
class(starwars)
str(starwars)
glimpse(starwars)

#### using the complete.cases function it will remove rows with NA
starwarsClean<- starwars[complete.cases(starwars[,1:10]),]

is.na(starwarsClean[,1])
anyNA(starwarsClean[,1:10])

### filter() will subset observations by their values
### uses >, >=, <=, ==, !
### can also use logica; operators like & and |
### automatically ignores NAs

filter(starwarsClean, gender=="masculine" & height < 180 )

filter(starwarsClean, gender=="masculine" , height < 180, height< 100 )

filter(starwars, eye_color %in% c("blue", "brown")) ### %in% filters for multiple conditions

#### arrange() reorder rows
arrange(starwarsClean, by= height)
arrange(starwarsClean, by= desc(height))
arrange (starwarsClean, height, desc(mass))### additonal columns will break ties in preceeding columns

starwarsClean[1:10,]
select(starwarsClean, 1:10)
select(starwarsClean, name:homeworld)
select(starwarsClean, -(films:starships)) ### subsetting everything except

### rearrange columns
select(starwarsClean, homeworld, name, gender, species, everything()) ### everthing is the rest in orig order
select(starwarsClean, contains("color"))

### rename columns
select(starwars, haircolor=hair_color) ## actual name comes after stating the new name

### mutate function creases new variables with functions of existing variables

### create a new column that is height/mass
y<- mutate(starwarsClean, ratio=height/mass)
starwars_lbs <- mutate(starwarsClean, mass_lbs= mass*2.2)

### transmute function

transmute(starwarsClean, mass_lbs=mass*2.2)

### summarize and group_by function collapses many values into a single summary

summarize(starwarsClean, meanHeight=mean(height))

summarize(starwars, meanHeight=mean(height)) ### returns NA if you use NAs
summarize(starwars, meanHeight=mean(height, na.rm=TRUE), TotalNumber=n()) ### Getting around NA issue

### use group_by for additional calcs
starwarsGender<- group_by(starwars, gender)
summarize(starwarsGender, meanHeight=mean(height, na.rm=TRUE),number=n())

### pipe statements - the pipe operator is %>%, or |>

### These are sequences of actions that will change your dataset
### passes intermediate results into the nect function in sequence
### AVOID when tou need to manipulate more than one object or there are meaningful intermediates
### formatting should always have a space before it or an auto indent

starwarsClean%>%
  group_by(gender)%>%
  summarize(meanHeight=mean(height, na.rm=TRUE), number=n())

### case_when function is useful for conditional statements
starwarsClean%>%
  mutate(sp=case_when(species=="Human"~"Human", TRUE ~"Non-human"))%>%
  select(name, sp, everything())
unique(starwarsClean$species)

glimpse(starwarsClean)
### Pivot from long to wide format using pivot_longer and pivot_wider

wideSW<- starwarsClean %>%
  select(name, sex, height)%>%
  pivot_wider(names_from=sex, values_from=height, values_fill=NA)

wideSW
pivotsw<- starwars%>%
  select(name,homeworld)%>%
  group_by(rn=row_number())%>%
  ungroup()%>%
  pivot_wider(names_from=homeworld, values_from=name)

pivotsw

wideSW%>%
  pivot_longer(cols=male:female, names_to="sex", values_to="height",
values_drop_na=TRUE)

############################################################################
############SQL#############################################################

library(tidyverse)
library(sqldf)

### read dataset
species_clean<- read.csv("site_by_species.csv")
var_clean<- read.csv("site_by_variables.csv")

### start with operations/functions on just one file

### subsetting rows
###dplyr:: filter()
species<- filter(species_clean, Site<30)
species

var<- filter(var_clean, Site< 30)
var

query<- "SELECT Site, Sp1, Sp2, Sp3 From species WHERE Site<'30'"
x<- sqldf(query)

edit_species<- species%>%
  select(Site, Sp1, Sp2, Sp3)

edit_species2<- species%>%
  select(1,2,3,4)### calls on positions instead of column names

query<- "SELECT * FROM species"
a<- sqldf(query)

### Renaming columns
### in dplyr you would use rename

species<- rename(species, Long= Longitude.x., Lat= Latitude.y.)
head(species)

### in sql you can use the as command
query<- "SELECT Long AS Longitude FROM species"
sqldf(query)

###Pull numeric columns
num_species<- species%>%
  mutate(letters=rep(letters, length.out=length(species$Site)))

num_species<- select(num_species, Site, Long, Lat, Sp1, letters)

num_species_edit<- select(num_species, where(is.numeric))

# Pivot longer to lengthen the data and reduce num cols but increases rows, you may see gather()/spread() but has sense been replaced
species_long<- pivot_longer(edit_species, cols=c(Sp1, Sp2, Sp3), names_to="ID")

species_wide<- pivot_wider(species_long, names_from=ID)

### SQL
query="SELECT SUM(Sp1+Sp2+Sp3)AS Occurence FROM species_wide GROUP BY SITE"
sqldf(query)

### start with clean versions of variables

edit_species<- species_clean%>%
  filter(Site<30)%>%
  select(Site, Sp1, Sp2, Sp3, Sp4, Longitude.x., Latitude.y.)

edit_var<- var_clean%>%
  filter(Site<30)%>%
  select(Site, BIO1_Annual_mean_temperature, BIO12_Annual_precipitation,
     Longitude.x., Latitude.y.)

### Left join- stitching matching rows from file b to a reqs a matching column to link the two datasets

left<- left_join(edit_species, edit_var, by="Site")

right<- right_join(edit_species, edit_var, by="Site")

inner<- inner_join(edit_species, edit_var, by="Site") ### retains rows that match and losses information that doesn't match
### full joins retain all the information but you end up with NAs
full<- full_join(edit_species, edit_var, by="Site")

### SQL mwthod
query<- "SELECT * FROM edit_var RIGHT JOIN edit_species ON edit_var.Site=edit_species.Site"
x<- sqldf(query)
