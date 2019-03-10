library(dplyr)
library(magrittr)

ds.in <- read.csv(file="C:/RFiles/DataVizContest/2019-03/wind_set.csv")

state.mean.med <- ds.in %>%
                    group_by(State) %>%
                    summarise(n=n(),
                              mean.ws=mean(windspeed),
                              med.ws=median(windspeed))

write.csv(state.mean.med,
          file="C:/RFiles/DataVizContest/2019-03/wind_mean_med_state.csv",
          row.names=FALSE)