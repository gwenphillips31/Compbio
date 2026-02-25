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
