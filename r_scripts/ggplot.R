### GGPlot
### 19 Feb 2026
### Gwen Phillips

#############################################################

### necessary packages
library(ggplot2)
library(ggthemes)
library(patchwork)

#p1<- ggplot(data=<DATA>)+
 #<GEOM_FUNCTION>(aes(<MAPPING>),
  #  stat=<STAT>,
   # position=<POSITION>)+
    #<COORDINATE_FUNCTION>+
    #<FACET_FUNCTION>

### load in dataset
d<- mpg

### our first call to ggplot: histogram
ggplot(data=d) +
  aes(x= hwy) +
  geom_histogram()

ggplot(data=d) +
  aes(x= hwy) +
  geom_histogram(fill= "blue", color="black")

### density plot
ggplot(data= d)+
  aes(x=hwy)+
  geom_density(fill= "mintcream")

### scatterplot
ggplot(data=d)+
  aes(x=displ, y= hwy)+
  geom_point() +
  geom_smooth() +
  geom_smooth(method = "lm", col= "red")

### boxplot
ggplot(data= d)+
  aes(x= fl, y= cty)+
  geom_boxplot(fill= "thistle", color="blue")

### barplot
ggplot(data=d)+
  aes(x=fl)+
  geom_bar()

### barplot with a y response
x_treatment <- c("control", "low", "high")
y_response <- c(12, 2.5, 22)
summary_data<- data.frame(x_treatment, y_response)

ggplot(data=summary_data)+
  aes(x= x_treatment, y= y_response)+
  geom_col(fill=c("gray50", "goldenrod", "goldenrod"), color="black")

### plotting curves
my_vec <- seq(1,100, by= 0.1)

### plot a simple function
d_frame<- data.frame(x=my_vec, y= sin(my_vec))

### plot lines
ggplot(data=d_frame)+
  aes(x=x, y=y)+
  geom_line()

d_frame<- data.frame(x=my_vec, y=dgamma(my_vec, shape= 5, scale= 3))

ggplot(data=d_frame)+
  aes(x=x, y=y)+
  geom_line()

### themes and fonts
p1<- ggplot(data=d, mapping= aes(x = displ, y=cty))+
  geom_point() + theme_classic()

print(p1)

p1+ theme_minimal()
p1+ theme_linedraw()
p1+ theme_dark()
p1+ theme_base()
p1+ theme_void()
p1+ theme_par()

### font size and font type
p1 + theme_classic(base_size=30, base_family="serif")

install.packages("extrafont")
library(extrafont)
font_import() ### imports all system fonts

### coordinate flipping in ggplot
p2<- ggplot(data=d, mapping= aes(x = fl, fill=fl))+
  geom_bar()

print(p2)
p2 + coord_flip() + 
  theme_grey(base_size=20, base_family="sans")

### setting x and y limits
p1<- ggplot(data=d, mapping= aes(x = displ, y=cty))+
  geom_point() + theme_bw()+
  xlim(0,8)+
  ylim(0,50)
