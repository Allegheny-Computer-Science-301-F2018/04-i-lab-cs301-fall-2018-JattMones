View# Name:
# Date:

# Run the below only if the library is not already installed.
# install.packages(dslabs)

library(dslabs)
library(dplyr)
library(tidyverse)
data(us_contagious_diseases)

#Question 1.
dat = filter(us_contagious_diseases, state != "Hawaii", state != "Alaska", disease == "Measles")
dat = mutate(dat, per_100s = (count*weeks_reporting*100000)/(population*52))

#Question 2.
ggplot(data=dat,mapping=aes(x=year, y = per_100s))+geom_point()+geom_vline(xintercept = 1965)

#Question 3.?? Can see 0, 100, 200. Unsure about binwidths relation to y axis?
dat_caliFocus= filter(dat, state == "California", between(year,1950,1989))
dat_caliFocus = mutate(dat_caliFocus, count2 = sqrt(count))

ggplot(data=dat_caliFocus,mapping=aes(x= year))+geom_bar()
ggplot(data=dat_caliFocus,mapping=aes(x= year, y = count2))+geom_bar(stat = "identity")
#Facet-Version:
ggplot(data=dat_caliFocus,mapping=aes(x= state))+geom_bar()+facet_wrap("year")
ggplot(data=dat_caliFocus,mapping=aes(x= state, y = count2))+geom_bar(stat = "identity")+ facet_wrap("year")
#view-histogram:
hist(dat_caliFocus$count)
hist(dat_caliFocus$count2)

#Question 4.
dat = filter(dat, state == "California", between(year,1950,1989))
dat = mutate(dat, count2 = sqrt(count))
ggplot(data=dat,mapping=aes(x= year))+geom_bar()#original, can also use stat = "identity" to manually map count (as below)
ggplot(data=dat,mapping=aes(x= year, y = count2))+geom_bar(stat = "identity")
#View-histogram:
hist(dat$count)
hist(dat$count2)
#Question 5.
# This really is not the best answer in my mind, because the graph is harder to read than one would like.  Maybe another time we can try to create different panes, and seperate the data a little bit to understand the data a little better.
ggplot(data = dat, mapping=aes(x = year, y = state, color = per_100s)) + geom_tile()

#Question 6.
#N/A
#Question 7.

# uses the data provided from the website cited in the writeup
niaidDataOnEffectivenessOfVaccines <- data.frame(
  disease = c("Measels", "Diphteria", "Mumps", "Pertussis", "Smallpox", "Rubella", "Haemophilus Influenzae", "Polio", "Tetanus"),
  PreVaccineAnnualCases = c(505282, 175885, 152209, 147271, 48164, 47745, 20000, 16316, 1314),
  CasesIn2009 = c(71, 0, 1991, 13214, 0, 3, 35, 0, 18),
  PercentDecrease = c(99.9, 100, 98.7, 91.0, 100, 99.9, 99.8, 100, 98.6)
)
# blue is the annual cases before the vaccine, red is the number of cases in 2009, when the article was written.
ggplot(data = niaidDataOnEffectivenessOfVaccines) + geom_point(mapping=aes(x = disease, y = PreVaccineAnnualCases), color = "blue") + geom_point(mapping=aes(x = disease, y = CasesIn2009), color = "red")
