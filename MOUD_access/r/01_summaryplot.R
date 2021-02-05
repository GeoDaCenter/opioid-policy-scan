library(psych)

minDisData <- data_final %>% 
  select(starts_with("min"), "rurality") %>%  
  gather(medication, minDis, minDisBup:minDisNalV) %>% 
  filter(!is.na(rurality))

minDisData$medication <- ifelse(minDisData$medication == "minDisNalV", "Naltrexone/Vivitrol", minDisData$medication)
minDisData$medication <- ifelse(minDisData$medication == "minDisMet", "Methadone", minDisData$medication)
minDisData$medication <- ifelse(minDisData$medication == "minDisBup", "Buprenorphine", minDisData$medication)

ggplot(minDisData, aes(x = medication, y = minDis)) + 
  geom_bar(aes(medication, minDis), 
           position = "dodge", stat = "summary", fun = "median") + 
  coord_flip()+
  facet_grid(rurality ~ .)+
  labs(title="Median Distance to Nearest Resource")+
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        plot.title = element_text(hjust = 0.5),
        text = element_text(size=20))


###########count
countData <- data_final %>% 
  select(starts_with("count"), "rurality") %>%  
  gather(medication, count, "count_in_range_naltrexone/vivitrol":"count_in_range_methadone") %>% 
  filter(!is.na(rurality))

ggplot(countData, aes(x = medication, y = count)) + 
  geom_bar(aes(medication, count), 
           position = "dodge", stat = "summary", fun = "median") + 
  coord_flip()+
  facet_grid(rurality ~ .)+
  labs(title="Count in range")+
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        plot.title = element_text(hjust = 0.5),
        text = element_text(size=20))
## ** rural areas - median is zero

###########score
scoreData <- data_final %>% 
  select(ends_with("score"), "rurality") %>%  
  gather(medication, score, "naltrexone/vivitrol_score":"methadone_score") %>% 
  filter(!is.na(rurality))

ggplot(scoreData, aes(x = medication, y = count)) + 
  geom_bar(aes(medication, score), 
           position = "dodge", stat = "summary", fun = "median") + 
  coord_flip()+
  facet_grid(rurality ~ .)+
  labs(title="Score")+
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        plot.title = element_text(hjust = 0.5),
        text = element_text(size=20))




ggplot(minDisData, aes(x = medication, y = minDis)) + 
  geom_bar(aes(medication, minDis), 
           position = "dodge", stat = "summary", fun = "median") + 
  coord_flip()+
  facet_grid(rurality ~ .)+
  labs(title="Median Distance to Nearest Resource")+
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        plot.title = element_text(hjust = 0.5),
        text = element_text(size=20))


psych::describeBy(data, data$rurality)
psych::describeBy(data, data$rurality, mat = T)


ggplot(data) + 
  geom_bar(aes(rurality, minDisBup, fill = as.factor(rurality)), 
               position = "dodge", stat = "summary", fun.y = "median") + 
             coord_flip()











ggplot(data, aes(x = rurality, y = median)) +
  geom_bar(stat = "identity") +
  coord_flip() # Horizontal bar plot









library(gtools)
data$theme1_qr <- quantcut(data$RPL_THEME1, q = 4, na.rm = T)          
data$theme2_qr <- quantcut(data$RPL_THEME2, q = 4, na.rm = T)          
data$theme3_qr <- quantcut(data$RPL_THEME3, q = 4, na.rm = T)          
data$theme4_qr <- quantcut(data$RPL_THEME4, q = 4, na.rm = T)          
data$themes_qr <- quantcut(data$RPL_THEMES, q = 4, na.rm = T)  
  
data %>% 
  filter(!is.na(RPL_THEME1)) %>% 
  ggplot(aes(x=rurality, y=minDisBup, fill=theme1_qr)) + 
  geom_boxplot() +
  facet_wrap(~rurality, scale="free")

  