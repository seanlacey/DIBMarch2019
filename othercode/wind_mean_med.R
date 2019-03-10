library(dplyr)

data.file <- "C:/RFiles/DataVizContest/2019-03/alltmy3a.zip" ###Point to location of your zip file

file.list <- unzip(data.file,list=TRUE)

for(i in 1:nrow(file.list)){
  file.name <- file.list[i,"Name"]
  
  loc.info <- read.csv(unz(data.file,file.name),
                       header=FALSE,
                       nrows=1)
  
  wind.in <- read.csv(unz(data.file,file.name),
                      header=TRUE,
                      skip=1) %>%
              mutate(fnum = loc.info[,1],
                     windspeed=Wspd..m.s.) %>%
              select(fnum,windspeed)
  
  if(i==1){
    ds.out <- wind.in
  } else{
    ds.out <- rbind(ds.out,wind.in)
  }
}

meta.ds <- read.csv("C:/RFiles/DataVizContest/2019-03/TMY3_StationsMeta.csv") %>%
           select(USAF,Site.Name,State)

ds.out <- inner_join(ds.out,meta.ds,by=c("fnum"="USAF"))

write.csv(ds.out,
          file="C:/RFiles/DataVizContest/2019-03/wind_set.csv",
          row.names=FALSE)