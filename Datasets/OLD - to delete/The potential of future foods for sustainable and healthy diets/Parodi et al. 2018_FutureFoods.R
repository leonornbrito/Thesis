#R script
#Parodi A., Leip A., De Boer I.J.M., Puylaert-Slegers P.M., Ziegler F., Temme E.H.H., Herrero M., Tuomisto H., Valin H., Van Middelaar C.E., Van Loon J. and Van Zanten H.H.E
#The potential of future foods for sustainable and healthy diets. Nature Sustainability, volume 1, pages782-789 (2018).

#Paper available:
url("https://www.nature.com/articles/s41893-018-0189-7")

#SharedIT URL (free access):
url("https://rdcu.be/bdq1i") 


#Structure of this script:

#Install packages needed

#1.     Nutritional composition.
#1.1    Nutritional composition future foods (Lines 53-56).
#1.2    Nutritional composition animal and plant-source foods (Lines 59 - 1332).
#1.3    Merge of two datasets and calculations to express nutrient content per gram of protein (Suplementary Table 1) (Lines 1340 -1392).
#1.4    Supplementary Table 5, Figure 2 and Supplementary Figure 1 (Lines 1395 - 1876)


#2.     Environmental impacts
#2.1.   Environmental impact of future foods, tilapia and tuna (Lines 1880 - 1886)
#2.2.   Environmental impact of animal and plant-source foods (Lines 1888 - 2020)
#2.3.   Combination of nutritional and environmental data (Lines 2023 - 2123)
#2.4    Figures 3 and 4. Supplementary Figures 2-5 (Lines 2126 - xxx)


#Datasets needed:

# Nutritional_ff.csv -> Contains the nutritional composition of future foods.
# Envimpactsff -> Contains the land use, energy use and global warming potential of future foods.
# requirements -> Contains the daily nutrient requirements.



#Install packages
#devtools
if(!require(devtools)){
  install.packages("devtools")
  library(devtools)}

#usdanutrients
if(!require(usdanutrients)){
  install_github("hadley/usdanutrients")
  library(usdanutrients)}

#tidyverse
if(!require(tidyverse)){
  install.packages('tidyverse')
  library(tidyverse)}

#tidyr
if(!require(tidyr)){
  install.packages('tidyr')
  library(tidyr)}

#plyr
#tidyverse
if(!require(plyr)){
  install.packages('plyr')
  library(plyr)}

#ggplot2
if(!require(ggplot2)){
  install.packages('ggplot2')
  library(ggplot2)}

if(!require(plotrix)){
  install.packages('plotrix')
  library(plotrix)}

if(!require(reshape2)){
  install.packages('reshape2')
  library(reshape2)}

if(!require(dplyr)){
  install.packages('dplyr')
  library(dplyr)}

if(!require(gridExtra)){
  install.packages('gridExtra')
  library(gridExtra)}

#Set working directory
setwd('/Users/lupuna/OneDrive - Wageningen University & Research/PhD/Future foods/Dataset for paper')
getwd()

#1. NUTRITIONAL COMPOSITION 
#1.1. Nutritional composition future foods 

#This dataset was built using literature data. All authors are mentioned in the dataset. The original values were converted to express the nutrient concentraions in the units specified in the dataset.
#It contains the nutritional composition expressed in dry and fresh weight of all future foods. It also contains additional nutrients that are not explored in the paper (e.g., ALA, iodine)
Nutritional_ff <- read.csv("Nutritional_ff.csv")

#Columns name
#[1] Component - Name of the component or nutrient
#[2] Units - Units in which the value is shown
#[3] Author - Last name and year of the source revised to extract the value
#[4] Species - Type of food
#[5] Weight - Dry weight or fresh weight
#[6] Feed - Additional information about the value extracted including type of diet, treatment, source.
#[7] Typefood - Future foods or animal source foods
#[8] Value - Nutrient value for component specified in column [1] in units specified in column [2]. Some nutrients contain NA values because data was not available for those nutrients in the cited studies.
#[9] concatenate - concatenate of Author_Species_Weight_Typefood


#1.2. Nutritional composition of animal and plant-source foods 

#The nutritional composition of the animal-source foods and plant-source foods were obtained from the USDA nutrient database using the package "usdanutrients".
#For beef, chicken and pork, a special procedure was applied in order to obtain the nutritional composition of a whole edible animal, accounting for the different 
#nutrional composition of different parts of the animals (e.g., the nutritional composition of a loin is different to the one from a chunk). This procedure is explained 
#in the "methods" section of the paper. The percentages of edible parts of the animals are presented in the Supplementary Table 3.

#All food ID are listed in the Supplementary Table 2. 


#Complete USDA DATASET

Main_dataset <- if (require("dplyr") && require("tidyr")) {
  nutr_info <- food %>%
    select(food_id, food) %>%
    inner_join(nutrient %>% select(food_id, nutr_id, value, se, num_studies, num_points, min, max, lwr, upr)) %>% #Here the numbers associated to the nutrient values
    inner_join(nutrient_def %>% select(nutr_id, nutr_abbr, unit, nutr))} #labels related to the nutrient id


#Select specific nutrients using the nutrient_id
#All id_ are in this document: https://www.ars.usda.gov/ARSUserFiles/80400525/Data/SR/sr28/sr28_doc.pdf

Selected_nutrients <- Main_dataset[
  Main_dataset$nutr_id == "203"| #protein
    Main_dataset$nutr_id == "301"| #calcium
    Main_dataset$nutr_id == "303"| #iron
    Main_dataset$nutr_id == "309"| #zinc
    Main_dataset$nutr_id == "418"| #vitb12
    Main_dataset$nutr_id == "629"| #epa
    Main_dataset$nutr_id == "621"| #dha
    Main_dataset$nutr_id == "501"| #tryptophan
    Main_dataset$nutr_id == "502"| #threonine
    Main_dataset$nutr_id == "505"| #lysine
    Main_dataset$nutr_id == "506"| #methionine
    Main_dataset$nutr_id == "320", ] #vitA

#to make sure all the desired were selected:
unique(Selected_nutrients$nutr)


##########################################For beef###################################################
#The strategy is as follows:
# Create different dataframes for the different parts: chuck ,loin, rib, round, thin cuts

#Each food id corresponds to the different items under the label "chunk"
Beef_chunk <- Selected_nutrients[Selected_nutrients$food_id =="13786"|
                                   Selected_nutrients$food_id =="23137"|
                                   Selected_nutrients$food_id =="23143"|
                                   Selected_nutrients$food_id =="23093"|
                                   Selected_nutrients$food_id =="13809"|
                                   Selected_nutrients$food_id =="13815"|
                                   Selected_nutrients$food_id =="23122"|
                                   Selected_nutrients$food_id =="23128"|
                                   Selected_nutrients$food_id =="23053"|
                                   Selected_nutrients$food_id =="23057"|
                                   Selected_nutrients$food_id =="23059"|
                                   Selected_nutrients$food_id =="23108"|
                                   Selected_nutrients$food_id =="23102", ]

#calculate average per nutrient for CHUNK

chunk_average <- ddply(Beef_chunk, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                       mean_se= mean (se, na.rm=TRUE), 
                       sd= std.error(value, na.rm=TRUE))

#Create new column to register it as chunk (then I will marge data sets)
chunk_average["Part"] <- "Chunk"

#mean + sd and mean - sd
chunk_average["meanminussd"] <- chunk_average$mean - chunk_average$mean_se
chunk_average["meanplusd"] <- chunk_average$mean + chunk_average$mean_se


#Each food id corresponds to the different items under the label "loin"
Beef_loin <- Selected_nutrients[Selected_nutrients$food_id =="23336"|
                                  Selected_nutrients$food_id =="23342"|
                                  Selected_nutrients$food_id =="23388"|
                                  Selected_nutrients$food_id =="23281"|
                                  Selected_nutrients$food_id =="23001"|
                                  Selected_nutrients$food_id =="23005"|
                                  Selected_nutrients$food_id =="13909"|
                                  Selected_nutrients$food_id =="23290", ]

#calculate average per nutrient for loin

loin_average <- ddply(Beef_loin, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                      mean_se= mean (se, na.rm=TRUE), 
                      sd= std.error(value, na.rm=TRUE))

#Create new column to register it as loin (then I will marge data sets)
loin_average["Part"] <- "loin"

#mean + sd and mean - sd
loin_average["meanminussd"] <- loin_average$mean - loin_average$mean_se
loin_average["meanplusd"] <- loin_average$mean + loin_average$mean_se


#Each food id corresponds to the different items under the label "rib"
Beef_rib <- Selected_nutrients[Selected_nutrients$food_id =="23192"|
                                 Selected_nutrients$food_id =="23236"|
                                 Selected_nutrients$food_id =="13838"|
                                 Selected_nutrients$food_id =="13147"|
                                 Selected_nutrients$food_id =="13850"|
                                 Selected_nutrients$food_id =="13824", ]

#calculate average per nutrient for rib

rib_average <- ddply(Beef_rib, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                     mean_se= mean (se, na.rm=TRUE), 
                     sd= std.error(value, na.rm=TRUE))

#Create new column to register it as rib (then I will marge data sets)
rib_average["Part"] <- "rib"

#mean + sd and mean - sd
rib_average["meanminussd"] <- rib_average$mean - rib_average$mean_se
rib_average["meanplusd"] <- rib_average$mean + rib_average$mean_se


#Each food id corresponds to the different items under the label "round"
Beef_round <- Selected_nutrients[Selected_nutrients$food_id =="13868"|
                                   Selected_nutrients$food_id =="23330"|
                                   Selected_nutrients$food_id =="23061"|
                                   Selected_nutrients$food_id =="23055"|
                                   Selected_nutrients$food_id =="23063"|
                                   Selected_nutrients$food_id =="13883"|
                                   Selected_nutrients$food_id =="13891", ]

#calculate average per nutrient for round

round_average <- ddply(Beef_round, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                       mean_se= mean (se, na.rm=TRUE), 
                       sd= std.error(value, na.rm=TRUE))

#Create new column to register it as round (then I will marge data sets)
round_average["Part"] <- "round"

#mean + sd and mean - sd
round_average["meanminussd"] <- round_average$mean - round_average$mean_se
round_average["meanplusd"] <- round_average$mean + round_average$mean_se

#Each food id corresponds to the different items under the label "thin_cuts"
Beef_thin_cuts <- Selected_nutrients[Selected_nutrients$food_id =="13803"|
                                       Selected_nutrients$food_id =="13970"|
                                       Selected_nutrients$food_id =="23217"|
                                       Selected_nutrients$food_id =="23224", ]

#calculate average per nutrient for thin_cuts

thin_cuts_average <- ddply(Beef_thin_cuts, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                           mean_se= mean (se, na.rm=TRUE), 
                           sd= std.error(value, na.rm=TRUE))

#Create new column to register it as thin_cuts (then I will marge data sets)
thin_cuts_average["Part"] <- "thincuts"

#mean + sd and mean - sd
thin_cuts_average["meanminussd"] <- thin_cuts_average$mean - thin_cuts_average$mean_se
thin_cuts_average["meanplusd"] <- thin_cuts_average$mean + thin_cuts_average$mean_se

Beef <- rbind(chunk_average, loin_average, rib_average, round_average, thin_cuts_average)

# Proportion of different parts:
#Chuck	0.29
#Loin	0.16
#Rib	0.09
#Round	0.22
#Thin cuts	0.19

Beef$edible_portion <- ifelse(Beef$Part=="Chunk", "0.29", 
                              ifelse (Beef$Part=="loin", "0.16", 
                                      ifelse(Beef$Part=="rib", "0.09",
                                             ifelse(Beef$Part=="round", "0.22",
                                                    ifelse(Beef$Part=="thincuts", "0.19","0")))))

Beef$edible_portion <- as.numeric(as.character(Beef$edible_portion))

Beef$mean1 <- Beef$mean * Beef$edible_portion
Beef$mean1minusd <- Beef$meanminussd * Beef$edible_portion
Beef$mean1plussd <- Beef$meanplusd * Beef$edible_portion



Beef$mean1minusd <- ifelse(is.nan(Beef$mean1minusd),Beef$mean1 , Beef$mean1minusd)
Beef$mean1plussd <- ifelse(is.nan(Beef$mean1plussd),Beef$mean1 , Beef$mean1plussd)



Beef_final <- ddply(Beef, .(nutr, unit), summarize, mean = sum (mean1, na.rm=TRUE), 
                    meanminusd= sum (mean1minusd, na.rm=TRUE), 
                    meanplusd= sum(mean1plussd, na.rm=TRUE))
#HAVE OMEGA 3 AND 6 IN ONE


beef_epaydha <- subset(Beef_final, (nutr=="20:5 n-3 (EPA)" | nutr=="22:6 n-3 (DHA)")) 
beef_epaydha <- rbind(beef_epaydha, c("EPA+DHA", "g",(colSums(beef_epaydha[3:5]))))
beef_epaydha <- beef_epaydha[-c(1, 2), ]

Beef_final <- subset(Beef_final, (nutr!="20:5 n-3 (EPA)") & (nutr!= "22:6 n-3 (DHA)"))
Beef_final <- rbind(Beef_final, beef_epaydha)
Beef_final$dm_factor <- 2.728782942
Beef_final$dm_factor <- as.numeric(as.character(Beef_final$dm_factor))
Beef_final$mean <- as.numeric(as.character(Beef_final$mean))
Beef_final$meanminusd <- as.numeric(as.character(Beef_final$meanminusd))
Beef_final$meanplusd <- as.numeric(as.character(Beef_final$meanplusd))



#TRANSFORM ALL TO DRY WEIGHT (FACTOR)
Beef_final$dm_mean <- (Beef_final$mean * Beef_final$dm_factor)
Beef_final$dm_sdminus <- Beef_final$meanminusd * Beef_final$dm_factor
Beef_final$dm_sdplus <- Beef_final$meanplusd * Beef_final$dm_factor


Beef_final$dm_sdminus <- ifelse(Beef_final$dm_sdminus==Beef_final$dm_mean, NA, Beef_final$dm_sdminus)
Beef_final$dm_sdplus <- ifelse(Beef_final$dm_sdplus==Beef_final$dm_mean, NA, Beef_final$dm_sdplus)




Beef_final <- Beef_final[,-(3:6),drop=FALSE]

Beef_final2 <- melt(Beef_final, id=c("nutr","unit"))
Beef_final2$Species <- "Beef" 

#Beef_final2 <- ddply(Beef_final2, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE),
#sderror= std.error(value, na.rm=TRUE))


#Beef_final2$sderror <- ifelse(Beef_final2$sderror==0, NA, Beef_final2$sderror)







##############################################   CHICKEN    ##########################################################

Chicken_leg <- Selected_nutrients [Selected_nutrients$food_id =="5075", ] # leg
Chicken_breast <- Selected_nutrients [Selected_nutrients$food_id =="5057", ] # breast
Chicken_back <- Selected_nutrients [Selected_nutrients$food_id =="5048", ] # back                    
Chicken_wing <- Selected_nutrients [Selected_nutrients$food_id =="5100", ] # wing
Chicken_fat <- Selected_nutrients [Selected_nutrients$food_id =="5047", ] #fat





#calculate average per nutrient for all chicken parts


Chicken_leg_average <- ddply(Chicken_leg, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                             mean_se= mean (se, na.rm=TRUE), 
                             sd= std.error(value, na.rm=TRUE))

#Create new column to register it as chunk (then I will marge data sets)
Chicken_leg_average["Part"] <- "Leg"

#mean + sd and mean - sd
Chicken_leg_average["meanminussd"] <- Chicken_leg_average$mean - Chicken_leg_average$mean_se
Chicken_leg_average["meanplusd"] <- Chicken_leg_average$mean + Chicken_leg_average$mean_se

#breast
Chicken_breast_average <- ddply(Chicken_breast, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                                mean_se= mean (se, na.rm=TRUE), 
                                sd= std.error(value, na.rm=TRUE))

#Create new column to register it as chunk (then I will marge data sets)
Chicken_breast_average["Part"] <- "breast"

#mean + sd and mean - sd
Chicken_breast_average["meanminussd"] <- Chicken_breast_average$mean - Chicken_breast_average$mean_se
Chicken_breast_average["meanplusd"] <- Chicken_breast_average$mean + Chicken_breast_average$mean_se

#back
Chicken_back_average <- ddply(Chicken_back, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                              mean_se= mean (se, na.rm=TRUE), 
                              sd= std.error(value, na.rm=TRUE))

#Create new column to register it as chunk (then I will marge data sets)
Chicken_back_average["Part"] <- "back"

#mean + sd and mean - sd
Chicken_back_average["meanminussd"] <- Chicken_back_average$mean - Chicken_back_average$mean_se
Chicken_back_average["meanplusd"] <- Chicken_back_average$mean + Chicken_back_average$mean_se

#wing
Chicken_wing_average <- ddply(Chicken_wing, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                              mean_se= mean (se, na.rm=TRUE), 
                              sd= std.error(value, na.rm=TRUE))

#Create new column to register it as chunk (then I will marge data sets)
Chicken_wing_average["Part"] <- "wing"

#mean + sd and mean - sd
Chicken_wing_average["meanminussd"] <- Chicken_wing_average$mean - Chicken_wing_average$mean_se
Chicken_wing_average["meanplusd"] <- Chicken_wing_average$mean + Chicken_wing_average$mean_se

#fat
Chicken_fat_average <- ddply(Chicken_fat, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                             mean_se= mean (se, na.rm=TRUE), 
                             sd= std.error(value, na.rm=TRUE))

#Create new column to register it as chunk (then I will marge data sets)
Chicken_fat_average["Part"] <- "fat"

#mean + sd and mean - sd
Chicken_fat_average["meanminussd"] <- Chicken_fat_average$mean - Chicken_fat_average$mean_se
Chicken_fat_average["meanplusd"] <- Chicken_fat_average$mean + Chicken_fat_average$mean_se


#join them
Chicken <- rbind(Chicken_leg_average, Chicken_back_average, Chicken_breast_average, Chicken_fat_average, Chicken_wing_average)

# Proportion of different parts:
#Legs	32.97	0.3297
#Breast	34.81	0.3481
#Back	19.85	0.1985
#Wings	11.19	0.1119
#Fat	1.18	0.0118

Chicken$edible_portion <- ifelse(Chicken$Part=="Leg", "0.3297", 
                                 ifelse (Chicken$Part=="breast", "0.3481", 
                                         ifelse(Chicken$Part=="back", "0.1985",
                                                ifelse(Chicken$Part=="wing", "0.1119",
                                                       ifelse(Chicken$Part=="fat", "0.0118","0")))))

Chicken$edible_portion <- as.numeric(as.character(Chicken$edible_portion))

Chicken$mean1 <- Chicken$mean * Chicken$edible_portion
Chicken$mean1minusd <- Chicken$meanminussd * Chicken$edible_portion
Chicken$mean1plussd <- Chicken$meanplusd * Chicken$edible_portion


Chicken$mean1minusd <- ifelse(is.nan(Chicken$mean1minusd),Chicken$mean1 , Chicken$mean1minusd)
Chicken$mean1plussd <- ifelse(is.nan(Chicken$mean1plussd),Chicken$mean1 , Chicken$mean1plussd)



Chicken_final <- ddply(Chicken, .(nutr, unit), summarize, mean = sum (mean1, na.rm=TRUE), 
                       meanminusd= sum (mean1minusd, na.rm=TRUE), 
                       meanplusd= sum(mean1plussd, na.rm=TRUE))


#HAVE OMEGA 3 AND 6 IN ONE


Chicken_epaydha <- subset(Chicken_final, (nutr=="20:5 n-3 (EPA)" | nutr=="22:6 n-3 (DHA)")) 
Chicken_epaydha <- rbind(Chicken_epaydha, c("EPA+DHA", "g",(colSums(Chicken_epaydha[3:5]))))
Chicken_epaydha <- Chicken_epaydha[-c(1, 2), ]

Chicken_final <- subset(Chicken_final, (nutr!="20:5 n-3 (EPA)") & (nutr!= "22:6 n-3 (DHA)"))
Chicken_final <- rbind(Chicken_final, Chicken_epaydha)
Chicken_final$dm_factor <- 2.940311673
Chicken_final$dm_factor <- as.numeric(as.character(Chicken_final$dm_factor))
Chicken_final$mean <- as.numeric(as.character(Chicken_final$mean))
Chicken_final$meanminusd <- as.numeric(as.character(Chicken_final$meanminusd))
Chicken_final$meanplusd <- as.numeric(as.character(Chicken_final$meanplusd))



#TRANSFORM ALL TO DRY WEIGHT (FACTOR)
Chicken_final$dm_mean <- (Chicken_final$mean * Chicken_final$dm_factor)
Chicken_final$dm_sdminus <- Chicken_final$meanminusd * Chicken_final$dm_factor
Chicken_final$dm_sdplus <- Chicken_final$meanplusd * Chicken_final$dm_factor

Chicken_final$dm_sdminus <- ifelse(Chicken_final$dm_sdminus==Chicken_final$dm_mean, NA, Chicken_final$dm_sdminus)
Chicken_final$dm_sdplus <- ifelse(Chicken_final$dm_sdplus==Chicken_final$dm_mean, NA, Chicken_final$dm_sdplus)



Chicken_final <- Chicken_final[,-(3:6),drop=FALSE]

Chicken_final2 <- melt(Chicken_final, id=c("nutr","unit"))

Chicken_final2$Species <- "Chicken" 

#Chicken_final2 <- ddply(Chicken_final2, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE),
#                     sderror= std.error(value, na.rm=TRUE))

#Chicken_final2$sderror <- ifelse(Chicken_final2$sderror==0, NA, Chicken_final2$sderror)

##############################################    PORK      ###########################################################





Pork_belly <-Selected_nutrients [Selected_nutrients$food_id =="10005", ]#belly
Pork_spare_ribs <-Selected_nutrients [Selected_nutrients$food_id =="10088", ]#spareribs
Pork_loin <-Selected_nutrients [Selected_nutrients$food_id =="10020", ]#loim
Pork_leg <-Selected_nutrients [Selected_nutrients$food_id =="10008", ]#leg(ham)
Pork_picnic <-Selected_nutrients [Selected_nutrients$food_id =="10074", ]#picnic(ham)
Pork_shoulder <-Selected_nutrients [Selected_nutrients$food_id =="10080",] #shoulder






#calculate average per nutrient for all Pork parts


Pork_belly_average <- ddply(Pork_belly, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                            mean_se= mean (se, na.rm=TRUE), 
                            sd= std.error(value, na.rm=TRUE))

#Create new column to register it as chunk (then I will marge data sets)
Pork_belly_average["Part"] <- "belly"

#mean + sd and mean - sd
Pork_belly_average["meanminussd"] <- Pork_belly_average$mean - Pork_belly_average$mean_se
Pork_belly_average["meanplusd"] <- Pork_belly_average$mean + Pork_belly_average$mean_se


Pork_spare_ribs_average <- ddply(Pork_spare_ribs, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                                 mean_se= mean (se, na.rm=TRUE), 
                                 sd= std.error(value, na.rm=TRUE))

#Create new column to register it as chunk (then I will marge data sets)
Pork_spare_ribs_average["Part"] <- "spare_ribs"

#mean + sd and mean - sd
Pork_spare_ribs_average["meanminussd"] <- Pork_spare_ribs_average$mean - Pork_spare_ribs_average$mean_se
Pork_spare_ribs_average["meanplusd"] <- Pork_spare_ribs_average$mean + Pork_spare_ribs_average$mean_se



Pork_loin_average <- ddply(Pork_loin, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                           mean_se= mean (se, na.rm=TRUE), 
                           sd= std.error(value, na.rm=TRUE))

#Create new column to register it as chunk (then I will marge data sets)
Pork_loin_average["Part"] <- "loin"

#mean + sd and mean - sd
Pork_loin_average["meanminussd"] <- Pork_loin_average$mean - Pork_loin_average$mean_se
Pork_loin_average["meanplusd"] <- Pork_loin_average$mean + Pork_loin_average$mean_se

Pork_leg_average <- ddply(Pork_leg, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                          mean_se= mean (se, na.rm=TRUE), 
                          sd= std.error(value, na.rm=TRUE))

#Create new column to register it as chunk (then I will marge data sets)
Pork_leg_average["Part"] <- "leg"

#mean + sd and mean - sd
Pork_leg_average["meanminussd"] <- Pork_leg_average$mean - Pork_leg_average$mean_se
Pork_leg_average["meanplusd"] <- Pork_leg_average$mean + Pork_leg_average$mean_se


Pork_picnic_average <- ddply(Pork_picnic, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                             mean_se= mean (se, na.rm=TRUE), 
                             sd= std.error(value, na.rm=TRUE))

#Create new column to register it as chunk (then I will marge data sets)
Pork_picnic_average["Part"] <- "picnic"

#mean + sd and mean - sd
Pork_picnic_average["meanminussd"] <- Pork_picnic_average$mean - Pork_picnic_average$mean_se
Pork_picnic_average["meanplusd"] <- Pork_picnic_average$mean + Pork_picnic_average$mean_se


Pork_shoulder_average <- ddply(Pork_shoulder, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                               mean_se= mean (se, na.rm=TRUE), 
                               sd= std.error(value, na.rm=TRUE))

#Create new column to register it as chunk (then I will marge data sets)
Pork_shoulder_average["Part"] <- "shoulder"

#mean + sd and mean - sd
Pork_shoulder_average["meanminussd"] <- Pork_shoulder_average$mean - Pork_shoulder_average$mean_se
Pork_shoulder_average["meanplusd"] <- Pork_shoulder_average$mean + Pork_shoulder_average$mean_se

#join them


Pork <- rbind(Pork_belly_average, Pork_spare_ribs_average, Pork_loin_average, Pork_leg_average, Pork_picnic_average, Pork_shoulder_average)

##Belly	
#Spareribs	
#Loin	
#Ham	
#Picnic	
#Shoulder (boston)	

Pork$edible_portion <- ifelse(Pork$Part=="belly", "0.20877632", 
                              ifelse (Pork$Part=="spare_ribs", "0.063731719", 
                                      ifelse(Pork$Part=="loin", "0.24437299",
                                             ifelse(Pork$Part=="leg", "0.270096463",
                                                    ifelse(Pork$Part=="picnic", "0.101286174",
                                                           ifelse(Pork$Part=="shoulder", "0.111736334","0"))))))

Pork$edible_portion <- as.numeric(as.character(Pork$edible_portion))

Pork$mean1 <- Pork$mean * Pork$edible_portion
Pork$mean1minusd <- Pork$meanminussd * Pork$edible_portion
Pork$mean1plussd <- Pork$meanplusd * Pork$edible_portion


Pork$mean1minusd <- ifelse(is.nan(Pork$mean1minusd),Pork$mean1 , Pork$mean1minusd)
Pork$mean1plussd <- ifelse(is.nan(Pork$mean1plussd),Pork$mean1 , Pork$mean1plussd)



Pork_final <- ddply(Pork, .(nutr, unit), summarize, mean = sum (mean1, na.rm=TRUE), 
                    meanminusd= sum (mean1minusd, na.rm=TRUE), 
                    meanplusd= sum(mean1plussd, na.rm=TRUE))

#omega3

#HAVE OMEGA 3 AND 6 IN ONE


Pork_epaydha <- subset(Pork_final, (nutr=="20:5 n-3 (EPA)" | nutr=="22:6 n-3 (DHA)")) 
Pork_epaydha <- rbind(Pork_epaydha, c("EPA+DHA", "g",(colSums(Pork_epaydha[3:5]))))
Pork_epaydha <- Pork_epaydha[-c(1, 2), ]

Pork_final <- subset(Pork_final, (nutr!="20:5 n-3 (EPA)") & (nutr!= "22:6 n-3 (DHA)"))
Pork_final <- rbind(Pork_final, Pork_epaydha)
Pork_final$dm_factor <- 2.497936034
Pork_final$dm_factor <- as.numeric(as.character(Pork_final$dm_factor))
Pork_final$mean <- as.numeric(as.character(Pork_final$mean))
Pork_final$meanminusd <- as.numeric(as.character(Pork_final$meanminusd))
Pork_final$meanplusd <- as.numeric(as.character(Pork_final$meanplusd))



#TRANSFORM ALL TO DRY WEIGHT (FACTOR)
Pork_final$dm_mean <- (Pork_final$mean * Pork_final$dm_factor)
Pork_final$dm_sdminus <- Pork_final$meanminusd * Pork_final$dm_factor
Pork_final$dm_sdplus <- Pork_final$meanplusd * Pork_final$dm_factor

Pork_final$dm_sdminus <- ifelse(Pork_final$dm_sdminus==Pork_final$dm_mean, NA, Pork_final$dm_sdminus)
Pork_final$dm_sdplus <- ifelse(Pork_final$dm_sdplus==Pork_final$dm_mean, NA, Pork_final$dm_sdplus)

Pork_final <- Pork_final[,-(3:6),drop=FALSE]

Pork_final2 <- melt(Pork_final, id=c("nutr","unit"))  #formato correcto para meterlo a la base 

Pork_final2$Species <- "Pork" 


#Pork_final2 <- ddply(Pork_final2, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE),
#                       sderror= std.error(value, na.rm=TRUE))

#Pork_final2$sderror <- ifelse(Pork_final2$sderror==0, NA, Pork_final2$sderror)


######################################### EGGS ############################################

Eggs <- Selected_nutrients [Selected_nutrients$food_id =="1123", ] # egg


Eggs <- ddply(Eggs, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
              mean_se= mean (se, na.rm=TRUE), 
              sd= std.error(value, na.rm=TRUE))


#mean + sd and mean - sd
Eggs["meanminussd"] <- Eggs$mean - Eggs$mean_se
Eggs["meanplusd"] <- Eggs$mean + Eggs$mean_se



Eggs$edible_portion <- "1"

Eggs$edible_portion <- as.numeric(as.character(Eggs$edible_portion))

Eggs$mean1 <- Eggs$mean * Eggs$edible_portion
Eggs$mean1minusd <- Eggs$meanminussd * Eggs$edible_portion
Eggs$mean1plussd <- Eggs$meanplusd * Eggs$edible_portion


Eggs$mean1minusd <- ifelse(is.nan(Eggs$mean1minusd),NA , Eggs$mean1minusd)
Eggs$mean1plussd <- ifelse(is.nan(Eggs$mean1plussd),NA , Eggs$mean1plussd)



#omega3

#HAVE OMEGA 3 AND 6 IN ONE


Eggs_epaydha <- subset(Eggs, (nutr=="20:5 n-3 (EPA)" | nutr=="22:6 n-3 (DHA)")) 
Eggs_epaydha <- Eggs_epaydha[,-(3:8),drop=FALSE]
Eggs_epaydha <- rbind(Eggs_epaydha, c("EPA+DHA", "g",(colSums(Eggs_epaydha[3:5]))))
Eggs_epaydha <- Eggs_epaydha[-c(1, 2), ]

Eggs <- Eggs [, -(3:8)]
Eggs_final <- subset(Eggs, (nutr!="20:5 n-3 (EPA)") & (nutr!= "22:6 n-3 (DHA)"))
Eggs_final <- rbind(Eggs_final, Eggs_epaydha)
Eggs_final$dm_factor <- 4.1928
Eggs_final$dm_factor <- as.numeric(as.character(Eggs_final$dm_factor))
Eggs_final$mean1 <- as.numeric(as.character(Eggs_final$mean1))
Eggs_final$mean1minusd <- as.numeric(as.character(Eggs_final$mean1minusd))
Eggs_final$mean1plussd <- as.numeric(as.character(Eggs_final$mean1plussd))



#TRANSFORM ALL TO DRY WEIGHT (FACTOR)
Eggs_final$dm_mean <- (Eggs_final$mean1 * Eggs_final$dm_factor)
Eggs_final$dm_sdminus <- Eggs_final$mean1minusd * Eggs_final$dm_factor
Eggs_final$dm_sdplus <- Eggs_final$mean1plussd * Eggs_final$dm_factor

Eggs_final$dm_sdminus <- ifelse(Eggs_final$dm_sdminus==Eggs_final$dm_mean, NA, Eggs_final$dm_sdminus)
Eggs_final$dm_sdplus <- ifelse(Eggs_final$dm_sdplus==Eggs_final$dm_mean, NA, Eggs_final$dm_sdplus)

Eggs_final <- Eggs_final[,-(3:6),drop=FALSE]

Eggs_final2 <- melt(Eggs_final, id=c("nutr","unit"))  #formato correcto para meterlo a la base 

Eggs_final2$Species <- "Egg" 




######################################### MILK ############################################

Milk <- Selected_nutrients [Selected_nutrients$food_id =="1211", ] # milk


Milk <- ddply(Milk, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
              mean_se= mean (se, na.rm=TRUE), 
              sd= std.error(value, na.rm=TRUE))


#mean + sd and mean - sd
Milk["meanminussd"] <- Milk$mean - Milk$mean_se
Milk["meanplusd"] <- Milk$mean + Milk$mean_se



Milk$edible_portion <- "1"

Milk$edible_portion <- as.numeric(as.character(Milk$edible_portion))

Milk$mean1 <- Milk$mean * Milk$edible_portion
Milk$mean1minusd <- Milk$meanminussd * Milk$edible_portion
Milk$mean1plussd <- Milk$meanplusd * Milk$edible_portion


Milk$mean1minusd <- ifelse(is.nan(Milk$mean1minusd),NA , Milk$mean1minusd)
Milk$mean1plussd <- ifelse(is.nan(Milk$mean1plussd),NA , Milk$mean1plussd)



#omega3

#HAVE OMEGA 3 AND 6 IN ONE


Milk_epaydha <- subset(Milk, (nutr=="20:5 n-3 (EPA)" | nutr=="22:6 n-3 (DHA)")) 
Milk_epaydha <- Milk_epaydha[,-(3:8),drop=FALSE]
Milk_epaydha <- rbind(Milk_epaydha, c("EPA+DHA", "g",(colSums(Milk_epaydha[3:5]))))
Milk_epaydha <- Milk_epaydha[-c(1, 2), ]

Milk <- Milk [, -(3:8)]
Milk_final <- subset(Milk, (nutr!="20:5 n-3 (EPA)") & (nutr!= "22:6 n-3 (DHA)"))
Milk_final <- rbind(Milk_final, Milk_epaydha)
Milk_final$dm_factor <- 8.4245
Milk_final$dm_factor <- as.numeric(as.character(Milk_final$dm_factor))
Milk_final$mean1 <- as.numeric(as.character(Milk_final$mean1))
Milk_final$mean1minusd <- as.numeric(as.character(Milk_final$mean1minusd))
Milk_final$mean1plussd <- as.numeric(as.character(Milk_final$mean1plussd))



#TRANSFORM ALL TO DRY WEIGHT (FACTOR)
Milk_final$dm_mean <- (Milk_final$mean1 * Milk_final$dm_factor)
Milk_final$dm_sdminus <- Milk_final$mean1minusd * Milk_final$dm_factor
Milk_final$dm_sdplus <- Milk_final$mean1plussd * Milk_final$dm_factor

Milk_final$dm_sdminus <- ifelse(Milk_final$dm_sdminus==Milk_final$dm_mean, NA, Milk_final$dm_sdminus)
Milk_final$dm_sdplus <- ifelse(Milk_final$dm_sdplus==Milk_final$dm_mean, NA, Milk_final$dm_sdplus)

Milk_final <- Milk_final[,-(3:6),drop=FALSE]

Milk_final2 <- melt(Milk_final, id=c("nutr","unit"))  #formato correcto para meterlo a la base 

Milk_final2$Species <- "Milk" 







############################################ JOIN BEEF, CHICKEN AND PORK IN THE SAME DATASET##################

Meat <- rbind(Beef_final2, Chicken_final2, Pork_final2, Eggs_final2, Milk_final2)

#create a dataset with the same name of columns and data

colnames(Meat)[which(names(Meat) == "nutr")] <- "Component"
colnames(Meat)[which(names(Meat) == "unit")] <- "Units"
colnames(Meat)[which(names(Meat) == "variable")] <- "Feed"
colnames(Meat)[which(names(Meat) == "value")] <- "Value"

Meat$Author <- "USDA, 2018"
Meat$Weight <- "Dry weight"
Meat$Typefood <- "Animal source foods"


Meat <- Meat[c("Component", "Units", "Author", "Species", "Weight", "Feed", "Typefood", "Value")]

Meat$concatenate<- with(Meat, paste0(Author, "_", Species, "_", Weight, "_", Feed, "_",Typefood))

Meat$Component <- ifelse(Meat$Component=="Calcium, Ca", "Ca (mg)", 
                         ifelse (Meat$Component=="Iron, Fe", "Fe (mg)", 
                                 ifelse(Meat$Component=="Lysine", "Lysine (g)",
                                        ifelse(Meat$Component=="Methionine", "Methionine (g)",
                                               ifelse(Meat$Component=="Protein", "Protein (g)",
                                                      ifelse(Meat$Component=="Threonine", "Threonine (g)",
                                                             ifelse(Meat$Component=="Tryptophan", "Tryptophan (g)", 
                                                                    ifelse (Meat$Component=="Vitamin A, RAE", "Vit. A (ug)", 
                                                                            ifelse(Meat$Component=="Vitamin B-12", "Vit. B12 (ug)",
                                                                                   ifelse(Meat$Component=="Vitamin D", "Vit. D (IU)",
                                                                                          ifelse(Meat$Component=="Zinc, Zn", "Zn (mg)",
                                                                                                 ifelse(Meat$Component=="EPA+DHA", "EPA + DHA (g)", "0"))))))))))))


Meat$Units <- ifelse(Meat$Units=="mg", "mg/100g",
                     ifelse(Meat$Units=="g", "g/100g", 
                            ifelse(Meat$Units=="?g", "ug/100g", 
                                   ifelse(Meat$Units=="IU", "IU/100g", "0"))))  




############################################# S E A F O O D  #####################################

############### TUNA ###############


Tuna <- Selected_nutrients [Selected_nutrients$food_id =="15123", ] # Tuna


Tuna <- ddply(Tuna, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
              mean_se= mean (se, na.rm=TRUE), 
              sd= std.error(value, na.rm=TRUE))


#mean + sd and mean - sd
Tuna["meanminussd"] <- Tuna$mean - Tuna$mean_se
Tuna["meanplusd"] <- Tuna$mean + Tuna$mean_se



Tuna$edible_portion <- "1"

Tuna$edible_portion <- as.numeric(as.character(Tuna$edible_portion))

Tuna$mean1 <- Tuna$mean * Tuna$edible_portion
Tuna$mean1minusd <- Tuna$meanminussd * Tuna$edible_portion
Tuna$mean1plussd <- Tuna$meanplusd * Tuna$edible_portion


Tuna$mean1minusd <- ifelse(is.nan(Tuna$mean1minusd),NA , Tuna$mean1minusd)
Tuna$mean1plussd <- ifelse(is.nan(Tuna$mean1plussd),NA , Tuna$mean1plussd)



#omega3

#HAVE OMEGA 3 AND 6 IN ONE


Tuna_epaydha <- subset(Tuna, (nutr=="20:5 n-3 (EPA)" | nutr=="22:6 n-3 (DHA)")) 
Tuna_epaydha <- Tuna_epaydha[,-(3:8),drop=FALSE]
Tuna_epaydha <- rbind(Tuna_epaydha, c("EPA+DHA", "g",(colSums(Tuna_epaydha[3:5]))))
Tuna_epaydha <- Tuna_epaydha[-c(1, 2), ]

Tuna <- Tuna [, -(3:8)]
Tuna_final <- subset(Tuna, (nutr!="20:5 n-3 (EPA)") & (nutr!= "22:6 n-3 (DHA)"))
Tuna_final <- rbind(Tuna_final, Tuna_epaydha)
Tuna_final$dm_factor <- 3.399048266
Tuna_final$dm_factor <- as.numeric(as.character(Tuna_final$dm_factor))
Tuna_final$mean1 <- as.numeric(as.character(Tuna_final$mean1))
Tuna_final$mean1minusd <- as.numeric(as.character(Tuna_final$mean1minusd))
Tuna_final$mean1plussd <- as.numeric(as.character(Tuna_final$mean1plussd))



#TRANSFORM ALL TO DRY WEIGHT (FACTOR)
Tuna_final$dm_mean <- (Tuna_final$mean1 * Tuna_final$dm_factor)
Tuna_final$dm_sdminus <- Tuna_final$mean1minusd * Tuna_final$dm_factor
Tuna_final$dm_sdplus <- Tuna_final$mean1plussd * Tuna_final$dm_factor

Tuna_final$dm_sdminus <- ifelse(Tuna_final$dm_sdminus==Tuna_final$dm_mean, NA, Tuna_final$dm_sdminus)
Tuna_final$dm_sdplus <- ifelse(Tuna_final$dm_sdplus==Tuna_final$dm_mean, NA, Tuna_final$dm_sdplus)

Tuna_final <- Tuna_final[,-(3:6),drop=FALSE]

Tuna_final2 <- melt(Tuna_final, id=c("nutr","unit"))  #formato correcto para meterlo a la base 

Tuna_final2$Species <- "Tuna"


#######TILAPIA ######################


Tilapia <- Selected_nutrients [Selected_nutrients$food_id =="15261", ] # Tilapia


Tilapia <- ddply(Tilapia, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                 mean_se= mean (se, na.rm=TRUE), 
                 sd= std.error(value, na.rm=TRUE))


#mean + sd and mean - sd
Tilapia["meanminussd"] <- Tilapia$mean - Tilapia$mean_se
Tilapia["meanplusd"] <- Tilapia$mean + Tilapia$mean_se



Tilapia$edible_portion <- "1"

Tilapia$edible_portion <- as.numeric(as.character(Tilapia$edible_portion))

Tilapia$mean1 <- Tilapia$mean * Tilapia$edible_portion
Tilapia$mean1minusd <- Tilapia$meanminussd * Tilapia$edible_portion
Tilapia$mean1plussd <- Tilapia$meanplusd * Tilapia$edible_portion


Tilapia$mean1minusd <- ifelse(is.nan(Tilapia$mean1minusd),NA , Tilapia$mean1minusd)
Tilapia$mean1plussd <- ifelse(is.nan(Tilapia$mean1plussd),NA , Tilapia$mean1plussd)



#omega3

#HAVE OMEGA 3 AND 6 IN ONE


Tilapia_epaydha <- subset(Tilapia, (nutr=="20:5 n-3 (EPA)" | nutr=="22:6 n-3 (DHA)")) 
Tilapia_epaydha <- Tilapia_epaydha[,-(3:8),drop=FALSE]
Tilapia_epaydha <- rbind(Tilapia_epaydha, c("EPA+DHA", "g",(colSums(Tilapia_epaydha[3:5]))))
Tilapia_epaydha <- Tilapia_epaydha[-c(1, 2), ]

Tilapia <- Tilapia [, -(3:8)]
Tilapia_final <- subset(Tilapia, (nutr!="20:5 n-3 (EPA)") & (nutr!= "22:6 n-3 (DHA)"))
Tilapia_final <- rbind(Tilapia_final, Tilapia_epaydha)
Tilapia_final$dm_factor <- 4.562043796
Tilapia_final$dm_factor <- as.numeric(as.character(Tilapia_final$dm_factor))
Tilapia_final$mean1 <- as.numeric(as.character(Tilapia_final$mean1))
Tilapia_final$mean1minusd <- as.numeric(as.character(Tilapia_final$mean1minusd))
Tilapia_final$mean1plussd <- as.numeric(as.character(Tilapia_final$mean1plussd))



#TRANSFORM ALL TO DRY WEIGHT (FACTOR)
Tilapia_final$dm_mean <- (Tilapia_final$mean1 * Tilapia_final$dm_factor)
Tilapia_final$dm_sdminus <- Tilapia_final$mean1minusd * Tilapia_final$dm_factor
Tilapia_final$dm_sdplus <- Tilapia_final$mean1plussd * Tilapia_final$dm_factor

Tilapia_final$dm_sdminus <- ifelse(Tilapia_final$dm_sdminus==Tilapia_final$dm_mean, NA, Tilapia_final$dm_sdminus)
Tilapia_final$dm_sdplus <- ifelse(Tilapia_final$dm_sdplus==Tilapia_final$dm_mean, NA, Tilapia_final$dm_sdplus)

Tilapia_final <- Tilapia_final[,-(3:6),drop=FALSE]

Tilapia_final2 <- melt(Tilapia_final, id=c("nutr","unit"))  #formato correcto para meterlo a la base 

Tilapia_final2$Species <- "Tilapia"


####put together all seafood


Seafood <- rbind(Tuna_final2, Tilapia_final2)

#create a dataset with the same name of columns and data

colnames(Seafood)[which(names(Seafood) == "nutr")] <- "Component"
colnames(Seafood)[which(names(Seafood) == "unit")] <- "Units"
colnames(Seafood)[which(names(Seafood) == "variable")] <- "Feed"
colnames(Seafood)[which(names(Seafood) == "value")] <- "Value"

Seafood$Author <- "USDA, 2018"
Seafood$Weight <- "Dry weight"
Seafood$Typefood <- "Seafood"


Seafood <- Seafood[c("Component", "Units", "Author", "Species", "Weight", "Feed", "Typefood", "Value")]

Seafood$concatenate<- with(Seafood, paste0(Author, "_", Species, "_", Weight, "_", Feed, "_",Typefood))

Seafood$Component <- ifelse(Seafood$Component=="Calcium, Ca", "Ca (mg)", 
                            ifelse (Seafood$Component=="Iron, Fe", "Fe (mg)", 
                                    ifelse(Seafood$Component=="Lysine", "Lysine (g)",
                                           ifelse(Seafood$Component=="Methionine", "Methionine (g)",
                                                  ifelse(Seafood$Component=="Protein", "Protein (g)",
                                                         ifelse(Seafood$Component=="Threonine", "Threonine (g)",
                                                                ifelse(Seafood$Component=="Tryptophan", "Tryptophan (g)", 
                                                                       ifelse (Seafood$Component=="Vitamin A, RAE", "Vit. A (ug)", 
                                                                               ifelse(Seafood$Component=="Vitamin B-12", "Vit. B12 (ug)",
                                                                                      ifelse(Seafood$Component=="Vitamin D", "Vit. D (IU)",
                                                                                             ifelse(Seafood$Component=="Zinc, Zn", "Zn (mg)",
                                                                                                    ifelse(Seafood$Component=="EPA+DHA", "EPA + DHA (g)", "0"))))))))))))


Seafood$Units <- ifelse(Seafood$Units=="mg", "mg/100g",
                        ifelse(Seafood$Units=="g", "g/100g", 
                               ifelse(Seafood$Units=="?g", "ug/100g", 
                                      ifelse(Seafood$Units=="IU", "IU/100g", "0")))) 



##################### RICE   ###############################################################################

Rice <- Selected_nutrients[Selected_nutrients$food_id =="20450"|
                             Selected_nutrients$food_id =="20452"|
                             Selected_nutrients$food_id =="20444", ]




Rice_final <- ddply(Rice, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                    mean_se= mean (se, na.rm=TRUE), 
                    sd= std.error(value, na.rm=TRUE))

Rice_final["meanminussd"] <- Rice_final$mean - Rice_final$mean_se
Rice_final["meanplusd"] <- Rice_final$mean + Rice_final$mean_se


Rice_final$meanminussd <- ifelse(is.nan(Rice_final$meanminussd),NA, Rice_final$meanminussd)
Rice_final$meanplusd <- ifelse(is.nan(Rice_final$meanplusd),NA, Rice_final$meanplusd)

Rice_epaydha <- subset(Rice_final, (nutr=="20:5 n-3 (EPA)" | nutr=="22:6 n-3 (DHA)")) 
Rice_epaydha <- rbind(Rice_epaydha, c("EPA+DHA", "g",(colSums(Rice_epaydha[3:5]))))
Rice_epaydha <- Rice_epaydha[-c(1, 2), ]

Rice_final <- subset(Rice_final, (nutr!="20:5 n-3 (EPA)") & (nutr!= "22:6 n-3 (DHA)"))
Rice_final <- rbind(Rice_final, Rice_epaydha)
Rice_final$dm_factor <- 1.14416476
Rice_final$dm_factor <- as.numeric(as.character(Rice_final$dm_factor))
Rice_final$mean <- as.numeric(as.character(Rice_final$mean))
Rice_final$meanminussd <- as.numeric(as.character(Rice_final$meanminussd))
Rice_final$meanplusd <- as.numeric(as.character(Rice_final$meanplusd))

#TRANSFORM ALL TO DRY WEIGHT (FACTOR)
Rice_final$dm_mean <- (Rice_final$mean * Rice_final$dm_factor)
Rice_final$dm_sdminus <- Rice_final$meanminussd * Rice_final$dm_factor
Rice_final$dm_sdplus <- Rice_final$meanplusd * Rice_final$dm_factor

Rice_final$dm_sdminus <- ifelse(Rice_final$dm_sdminus==Rice_final$dm_mean, NA, Rice_final$dm_sdminus)
Rice_final$dm_sdplus <- ifelse(Rice_final$dm_sdplus==Rice_final$dm_mean, NA, Rice_final$dm_sdplus)



Rice_final <- Rice_final[,-(3:8),drop=FALSE]

Rice_final2 <- melt(Rice_final, id=c("nutr","unit"))

Rice_final2$Species <- "Rice"

#Rice_final2 <- ddply(Rice_final2, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE),
#sderror= std.error(value, na.rm=TRUE))


######################################################### MAIZE ####################

Maize <- Selected_nutrients[Selected_nutrients$food_id =="11167"|
                              Selected_nutrients$food_id =="11900", ]



Maize_final <- ddply(Maize, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                     mean_se= mean (se, na.rm=TRUE), 
                     sd= std.error(value, na.rm=TRUE))

Maize_final["meanminussd"] <- Maize_final$mean - Maize_final$mean_se
Maize_final["meanplusd"] <- Maize_final$mean + Maize_final$mean_se


Maize_final$meanminussd <- ifelse(is.nan(Maize_final$meanminussd),NA, Maize_final$meanminussd)
Maize_final$meanplusd <- ifelse(is.nan(Maize_final$meanplusd),NA, Maize_final$meanplusd)


Maize_epaydha <- subset(Maize_final, (nutr=="20:5 n-3 (EPA)" | nutr=="22:6 n-3 (DHA)")) 
Maize_epaydha <- rbind(Maize_epaydha, c("EPA+DHA", "g",(colSums(Maize_epaydha[3:5]))))
Maize_epaydha <- Maize_epaydha[-c(1, 2), ]

Maize_final <- subset(Maize_final, (nutr!="20:5 n-3 (EPA)") & (nutr!= "22:6 n-3 (DHA)"))
Maize_final <- rbind(Maize_final, Maize_epaydha)
Maize_final$dm_factor <- 4.167534903
Maize_final$dm_factor <- as.numeric(as.character(Maize_final$dm_factor))
Maize_final$mean <- as.numeric(as.character(Maize_final$mean))
Maize_final$meanminussd <- as.numeric(as.character(Maize_final$meanminussd))
Maize_final$meanplusd <- as.numeric(as.character(Maize_final$meanplusd))

#TRANSFORM ALL TO DRY WEIGHT (FACTOR)
Maize_final$dm_mean <- (Maize_final$mean * Maize_final$dm_factor)
Maize_final$dm_sdminus <- Maize_final$meanminussd * Maize_final$dm_factor
Maize_final$dm_sdplus <- Maize_final$meanplusd * Maize_final$dm_factor



Maize_final <- Maize_final[,-(3:8),drop=FALSE]

Maize_final2 <- melt(Maize_final, id=c("nutr","unit"))

Maize_final2$Species <- "Maize"


############################################## WHEAT ###################################

Wheat <- Selected_nutrients[Selected_nutrients$food_id =="20076"|
                              Selected_nutrients$food_id =="20075", ]



Wheat_final <- ddply(Wheat, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                     mean_se= mean (se, na.rm=TRUE), 
                     sd= std.error(value, na.rm=TRUE))

Wheat_final["meanminussd"] <- Wheat_final$mean - Wheat_final$mean_se
Wheat_final["meanplusd"] <- Wheat_final$mean + Wheat_final$mean_se


Wheat_final$meanminussd <- ifelse(is.nan(Wheat_final$meanminussd),NA, Wheat_final$meanminussd)
Wheat_final$meanplusd <- ifelse(is.nan(Wheat_final$meanplusd),NA, Wheat_final$meanplusd)


Wheat_epaydha <- subset(Wheat_final, (nutr=="20:5 n-3 (EPA)" | nutr=="22:6 n-3 (DHA)")) 
Wheat_epaydha <- rbind(Wheat_epaydha, c("EPA+DHA", "g",(colSums(Wheat_epaydha[3:5]))))
Wheat_epaydha <- Wheat_epaydha[-c(1, 2), ]

Wheat_final <- subset(Wheat_final, (nutr!="20:5 n-3 (EPA)") & (nutr!= "22:6 n-3 (DHA)"))
Wheat_final <- rbind(Wheat_final, Wheat_epaydha)
Wheat_final$dm_factor <- 1.119570085
Wheat_final$dm_factor <- as.numeric(as.character(Wheat_final$dm_factor))
Wheat_final$mean <- as.numeric(as.character(Wheat_final$mean))
Wheat_final$meanminussd <- as.numeric(as.character(Wheat_final$meanminussd))
Wheat_final$meanplusd <- as.numeric(as.character(Wheat_final$meanplusd))

#TRANSFORM ALL TO DRY WEIGHT (FACTOR)
Wheat_final$dm_mean <- (Wheat_final$mean * Wheat_final$dm_factor)
Wheat_final$dm_sdminus <- Wheat_final$meanminussd * Wheat_final$dm_factor
Wheat_final$dm_sdplus <- Wheat_final$meanplusd * Wheat_final$dm_factor



Wheat_final <- Wheat_final[,-(3:8),drop=FALSE]

Wheat_final2 <- melt(Wheat_final, id=c("nutr","unit"))

Wheat_final2$Species <- "Wheat"


############################################## SOYBEAN ###################################

Soybean <- Selected_nutrients[Selected_nutrients$food_id =="16108", ]



Soybean_final <- ddply(Soybean, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                       mean_se= mean (se, na.rm=TRUE), 
                       sd= std.error(value, na.rm=TRUE))




Soybean_final <- rbind(Soybean_final, c("EPA+DHA","g", NA, NA, NA))

Soybean_final$mean <- as.numeric(as.character(Soybean_final$mean))
Soybean_final$mean_se <- as.numeric(as.character(Soybean_final$mean_se))




Soybean_final["meanminussd"] <- Soybean_final$mean - Soybean_final$mean_se
Soybean_final["meanplusd"] <- Soybean_final$mean + Soybean_final$mean_se


Soybean_final$meanminussd <- ifelse(is.nan(Soybean_final$meanminussd),NA, Soybean_final$meanminussd)
Soybean_final$meanplusd <- ifelse(is.nan(Soybean_final$meanplusd),NA, Soybean_final$meanplusd)


Soybean_epaydha <- subset(Soybean_final, (nutr=="20:5 n-3 (EPA)" | nutr=="22:6 n-3 (DHA)")) 
Soybean_epaydha <- rbind(Soybean_epaydha, c("EPA+DHA", "g",(colSums(Soybean_epaydha[3:5]))))
Soybean_epaydha <- Soybean_epaydha[-c(1, 2), ]

Soybean_final <- subset(Soybean_final, (nutr!="20:5 n-3 (EPA)") & (nutr!= "22:6 n-3 (DHA)"))
Soybean_final <- rbind(Soybean_final, Soybean_epaydha)
Soybean_final$dm_factor <- 1.093374153
Soybean_final$dm_factor <- as.numeric(as.character(Soybean_final$dm_factor))
Soybean_final$mean <- as.numeric(as.character(Soybean_final$mean))
Soybean_final$meanminussd <- as.numeric(as.character(Soybean_final$meanminussd))
Soybean_final$meanplusd <- as.numeric(as.character(Soybean_final$meanplusd))

#TRANSFORM ALL TO DRY WEIGHT (FACTOR)
Soybean_final$dm_mean <- (Soybean_final$mean * Soybean_final$dm_factor)
Soybean_final$dm_sdminus <- Soybean_final$meanminussd * Soybean_final$dm_factor
Soybean_final$dm_sdplus <- Soybean_final$meanplusd * Soybean_final$dm_factor



Soybean_final <- Soybean_final[,-(3:8),drop=FALSE]

Soybean_final2 <- melt(Soybean_final, id=c("nutr","unit"))

Soybean_final2$Species <- "Soybean"

############################################## BEANS ###################################

Beans <- Selected_nutrients[Selected_nutrients$food_id =="16027", ]



Beans_final <- ddply(Beans, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                     mean_se= mean (se, na.rm=TRUE), 
                     sd= std.error(value, na.rm=TRUE))

Beans_final["meanminussd"] <- Beans_final$mean - Beans_final$mean_se
Beans_final["meanplusd"] <- Beans_final$mean + Beans_final$mean_se


Beans_final$meanminussd <- ifelse(is.nan(Beans_final$meanminussd),NA, Beans_final$meanminussd)
Beans_final$meanplusd <- ifelse(is.nan(Beans_final$meanplusd),NA, Beans_final$meanplusd)


Beans_epaydha <- subset(Beans_final, (nutr=="20:5 n-3 (EPA)" | nutr=="22:6 n-3 (DHA)")) 
Beans_epaydha <- rbind(Beans_epaydha, c("EPA+DHA", "g",(colSums(Beans_epaydha[3:5]))))
Beans_epaydha <- Beans_epaydha[-c(1, 2), ]

Beans_final <- subset(Beans_final, (nutr!="20:5 n-3 (EPA)") & (nutr!= "22:6 n-3 (DHA)"))
Beans_final <- rbind(Beans_final, Beans_epaydha)
Beans_final$dm_factor <- 1.133144476
Beans_final$dm_factor <- as.numeric(as.character(Beans_final$dm_factor))
Beans_final$mean <- as.numeric(as.character(Beans_final$mean))
Beans_final$meanminussd <- as.numeric(as.character(Beans_final$meanminussd))
Beans_final$meanplusd <- as.numeric(as.character(Beans_final$meanplusd))

#TRANSFORM ALL TO DRY WEIGHT (FACTOR)
Beans_final$dm_mean <- (Beans_final$mean * Beans_final$dm_factor)
Beans_final$dm_sdminus <- Beans_final$meanminussd * Beans_final$dm_factor
Beans_final$dm_sdplus <- Beans_final$meanplusd * Beans_final$dm_factor



Beans_final <- Beans_final[,-(3:8),drop=FALSE]

Beans_final2 <- melt(Beans_final, id=c("nutr","unit"))

Beans_final2$Species <- "Bean"


####################################### JOIN MAIZE AND RICE IN ONE DATAFRAME AND CHANGE COLUMN NAMES #############


Plants <- rbind(Rice_final2, Maize_final2, Wheat_final2, Soybean_final2, Beans_final2)

colnames(Plants)[which(names(Plants) == "nutr")] <- "Component"
colnames(Plants)[which(names(Plants) == "unit")] <- "Units"
colnames(Plants)[which(names(Plants) == "variable")] <- "Feed"
colnames(Plants)[which(names(Plants) == "value")] <- "Value"

Plants$Author <- "USDA, 2018"
Plants$Weight <- "Dry weight"
Plants$Typefood <- "Plant source foods"


Plants <- Plants[c("Component", "Units", "Author", "Species", "Weight", "Feed", "Typefood", "Value")]

Plants$concatenate<- with(Plants, paste0(Author, "_", Species, "_", Weight, "_", Feed, "_",Typefood))

Plants$Component <- ifelse(Plants$Component=="Calcium, Ca", "Ca (mg)", 
                           ifelse (Plants$Component=="Iron, Fe", "Fe (mg)", 
                                   ifelse(Plants$Component=="Lysine", "Lysine (g)",
                                          ifelse(Plants$Component=="Methionine", "Methionine (g)",
                                                 ifelse(Plants$Component=="Protein", "Protein (g)",
                                                        ifelse(Plants$Component=="Threonine", "Threonine (g)",
                                                               ifelse(Plants$Component=="Tryptophan", "Tryptophan (g)", 
                                                                      ifelse (Plants$Component=="Vitamin A, RAE", "Vit. A (ug)", 
                                                                              ifelse(Plants$Component=="Vitamin B-12", "Vit. B12 (ug)",
                                                                                     ifelse(Plants$Component=="Vitamin D", "Vit. D (IU)",
                                                                                            ifelse(Plants$Component=="Zinc, Zn", "Zn (mg)",
                                                                                                   ifelse(Plants$Component=="EPA+DHA", "EPA + DHA (g)", "0"))))))))))))


Plants$Units <- ifelse(Plants$Units=="mg", "mg/100g",
                       ifelse(Plants$Units=="g", "g/100g", 
                              ifelse(Plants$Units=="?g", "ug/100g", 
                                     ifelse(Plants$Units=="IU", "IU/100g", "0"))))  



############################ MUSSELS ###############################

Mussel <- Selected_nutrients[Selected_nutrients$food_id =="15164", ]



Mussel_final <- ddply(Mussel, .(nutr, unit), summarize, mean = mean (value, na.rm=TRUE), 
                      mean_se= mean (se, na.rm=TRUE), 
                      sd= std.error(value, na.rm=TRUE))

Mussel_final["meanminussd"] <- Mussel_final$mean - Mussel_final$mean_se
Mussel_final["meanplusd"] <- Mussel_final$mean + Mussel_final$mean_se


Mussel_final$meanminussd <- ifelse(is.nan(Mussel_final$meanminussd),NA, Mussel_final$meanminussd)
Mussel_final$meanplusd <- ifelse(is.nan(Mussel_final$meanplusd),NA, Mussel_final$meanplusd)


Mussel_epaydha <- subset(Mussel_final, (nutr=="20:5 n-3 (EPA)" | nutr=="22:6 n-3 (DHA)")) 
Mussel_epaydha <- rbind(Mussel_epaydha, c("EPA+DHA", "g",(colSums(Mussel_epaydha[3:5]))))
Mussel_epaydha <- Mussel_epaydha[-c(1, 2), ]

Mussel_final <- subset(Mussel_final, (nutr!="20:5 n-3 (EPA)") & (nutr!= "22:6 n-3 (DHA)"))
Mussel_final <- rbind(Mussel_final, Mussel_epaydha)
Mussel_final$dm_factor <- 5.149330587
Mussel_final$dm_factor <- as.numeric(as.character(Mussel_final$dm_factor))
Mussel_final$mean <- as.numeric(as.character(Mussel_final$mean))
Mussel_final$meanminussd <- as.numeric(as.character(Mussel_final$meanminussd))
Mussel_final$meanplusd <- as.numeric(as.character(Mussel_final$meanplusd))

#TRANSFORM ALL TO DRY WEIGHT (FACTOR)
Mussel_final$dm_mean <- (Mussel_final$mean * Mussel_final$dm_factor)
Mussel_final$dm_sdminus <- Mussel_final$meanminussd * Mussel_final$dm_factor
Mussel_final$dm_sdplus <- Mussel_final$meanplusd * Mussel_final$dm_factor



Mussel_final <- Mussel_final[,-(3:8),drop=FALSE]

Mussel_final2 <- melt(Mussel_final, id=c("nutr","unit"))

Mussel_final2$Species <- "Mussel"


colnames(Mussel_final2)[which(names(Mussel_final2) == "nutr")] <- "Component"
colnames(Mussel_final2)[which(names(Mussel_final2) == "unit")] <- "Units"
colnames(Mussel_final2)[which(names(Mussel_final2) == "variable")] <- "Feed"
colnames(Mussel_final2)[which(names(Mussel_final2) == "value")] <- "Value"

Mussel_final2$Author <- "USDA, 2018"
Mussel_final2$Weight <- "Dry weight"
Mussel_final2$Typefood <- "Future foods"


Mussel_final2 <- Mussel_final2[c("Component", "Units", "Author", "Species", "Weight", "Feed", "Typefood", "Value")]

Mussel_final2$concatenate<- with(Mussel_final2, paste0(Author, "_", Species, "_", Weight, "_", Feed, "_",Typefood))

Mussel_final2$Component <- ifelse(Mussel_final2$Component=="Calcium, Ca", "Ca (mg)", 
                                  ifelse (Mussel_final2$Component=="Iron, Fe", "Fe (mg)", 
                                          ifelse(Mussel_final2$Component=="Lysine", "Lysine (g)",
                                                 ifelse(Mussel_final2$Component=="Methionine", "Methionine (g)",
                                                        ifelse(Mussel_final2$Component=="Protein", "Protein (g)",
                                                               ifelse(Mussel_final2$Component=="Threonine", "Threonine (g)",
                                                                      ifelse(Mussel_final2$Component=="Tryptophan", "Tryptophan (g)", 
                                                                             ifelse (Mussel_final2$Component=="Vitamin A, RAE", "Vit. A (ug)", 
                                                                                     ifelse(Mussel_final2$Component=="Vitamin B-12", "Vit. B12 (ug)",
                                                                                            ifelse(Mussel_final2$Component=="Vitamin D", "Vit. D (IU)",
                                                                                                   ifelse(Mussel_final2$Component=="Zinc, Zn", "Zn (mg)",
                                                                                                          ifelse(Mussel_final2$Component=="EPA+DHA", "EPA + DHA (g)", "0"))))))))))))


Mussel_final2$Units <- ifelse(Mussel_final2$Units=="mg", "mg/100g",
                              ifelse(Mussel_final2$Units=="g", "g/100g", 
                                     ifelse(Mussel_final2$Units=="?g", "ug/100g", 
                                            ifelse(Mussel_final2$Units=="IU", "IU/100g", "0"))))  


#join all foods USDA


USDA_all <- rbind(Meat, Seafood, Plants, Mussel_final2)

USDA_all$Feed <- ifelse(USDA_all$Feed=="dm_mean", "dm.mean",
                        ifelse(USDA_all$Feed=="dm_sdminus", "dm.sdminus",
                               ifelse(USDA_all$Feed=="dm_sdplus", "dm.sdplus", "0")))





#1.3 Merge of two datasets (Nutritional_ff and USDA_all) and calculations to express nutrient content per gram of protein (Suplementary Table 1).

Nutritionalcontent <- rbind(Nutritional_ff, USDA_all)
unique(Nutritionalcontent$Species)
unique(Nutritionalcontent$Component)

#Adding protein content to each row

protein <- subset(Nutritionalcontent, (Component=="Protein (g)")) #create new df where only the protein content is shown

#As not all the nutritional studies have protein content (there are many NA), all NA were filled with the mean value of the protein content of the studies that showed a value for protein

#create a column with the protein average

protein$concatenate2<- with(protein, paste0(Species, "_", Weight))
protein$valuemean <- ave(protein$Value, protein$concatenate2, FUN=function(x) mean(x, na.rm=T))


#All studies that had a protein value listed as "NA" will be filled with the mean protein value for each food. Those studies that showed an original protein value will remain with the original value
#For USDA foods, the protein value added for the dm.sdminus and dm.sdplus, correspond to the mean-sdmin and mean+sdmax protein values, respectively. In that way the overall range is covered.
protein$proteinvalue <- ifelse(is.na(protein$Value), protein$valuemean, protein$Value) 


#Add protein value column to the Nutritional dataset:

Nutritionalcontent <-merge(Nutritionalcontent, protein[c("concatenate", "proteinvalue")], all.x=TRUE) #DATASET
Nutritionalcontent$value1gprot <- Nutritionalcontent$Value/Nutritionalcontent$proteinvalue

#Nutrient profile dataset will be use later
Nutrientprofile <- Nutritionalcontent

#Nutritional content is the name of the dataset where we have all the nutritional studies that were included. 
#filter dry weight:
dry1 <- subset(Nutritionalcontent, (Weight=="Dry weight"))


dry1 <- dry1[,c(8, 5, 4, 2, 3, 7, 9, 10, 11, 6, 1)]

#Format dataset to present it as Supplementary Table
dry2 <- dry1
#Rename columns:
colnames(dry2) <- c("Typefood", "Species",
                    "Source", "Nutrients", "Units",
                    "Feed/other", "Content in 100g Dry matter",
                    "Protein content (g/100g dry mater product)",
                    "Nutrient content in 1g  of prot", "Type of weight", "Concatenate")

#Remove rows with NA values
dry2 <- dry2[complete.cases(dry2[ , 7]),]

dry2[10:11] <- list(NULL)

#Supplementary Table 1:
#write.csv(dry2, file = "Table 1.csv", row.names = FALSE)


#1.4    Calculations to obtain data for Supplementary Table 5, Figure 2 and Supplementary Figure 1.

#Using the Supplementary Table 1, the mean and the standard errors are calculated:
dry <- ddply(dry1, .(Component, Species, Typefood), summarize, mean = mean (value1gprot, na.rm=TRUE), sd= std.error(value1gprot, na.rm=TRUE))


#Isolate protein values for later calculations:
#Table not per 1g of protein but normal content (in 100 g dry matter sample)
xxdry <- ddply(dry1, .(Component, Species, Typefood), summarize, mean = mean (Value, na.rm=TRUE), sd= std.error (Value, na.rm=TRUE))
proteindry <- subset(xxdry, (Component=="Protein (g)"))

#Correct for those that have a mean of zero and a sd of zero instead of NA
dry$newsd <- ifelse(dry$mean==0, is.na(dry$newsd), dry$sd)

#Modify mean-sd when negative to prevent having negative values with the error bars in the plots
dry$meanminusd <- dry$mean - dry$newsd
dry$minussd2 <- ifelse(dry$meanminusd <0, "0", dry$meanminusd )
dry$minussd2 <- as.numeric(as.character(dry$minussd2))

#subset to get a clean database with the desired nutrient and sources
dry <- subset(dry, (Component!= "ALA 18:3 n-3 (g)" 
                    &Component!= "Protein (g)"
                    &Component!= "DHA 22:6 n-3 (g)"
                    &Component!= "I (ug)"
                    &Component!= "EPA 20:5 n-3 (g)"
                    &Component!= "Vitamin D2(?g)"
                    &Component!= "Vit. D (ug)"
                    &Component!= "Chitin"
                    &Component!= "DPA 22:5 n-3 (g)"
                    &Component!= "Vitamin D3"
                    &Component!= "Chitin corrected protein"
                    &Component!= "Water"
                    &Species!= "Almond"))

#Edit table for Supplementary Table 5

dry_1gram <- dry
dry_1gram <- dry_1gram[,c(3,2,1,4,5,6,7,8)]
dry_1gram[6:8] <- list(NULL)

colnames(dry_1gram) <- c("Typefood", "Species",
                    "Nutrients", 
                    "Mean", "St. error")

#write.csv(dry, file = "Table5.csv", row.names = FALSE)

# For Figure 2

#Remove cultured meat:
dry <- subset(dry, (Species!= "Cultured meat"))

#order factors for graphs
dry$Typefood=factor(dry$Typefood, levels=c('Future foods',
                                           'Plant source foods',
                                           'Seafood',
                                           'Animal source foods'))


dry$Component=factor(dry$Component, levels=c('Lysine (g)', 
                                             'Methionine (g)', 
                                             'Threonine (g)', 
                                             'Tryptophan (g)', 
                                             'Ca (mg)', 
                                             'Fe (mg)', 
                                             'Zn (mg)', 
                                             'Vit. D (ug)',
                                             'Vit. A (ug)',
                                             'Vit. B12 (ug)',
                                             'EPA + DHA (g)'))


dry$Species=factor(dry$Species, levels=c('Mycoprotein',
                                         'Chlorella',
                                         'Spirulina',
                                         'Sugar kelp',
                                         'Black soldier fly',
                                         'Housefly',
                                         'Mealworm',
                                         'Mussel',
                                         'Bean',
                                         'Wheat',
                                         'Soybean',
                                         'Almond',
                                         'Rice',
                                         'Maize',
                                         'Tuna',
                                         'Tilapia',
                                         'Egg',
                                         'Milk',
                                         'Chicken',
                                         'Pork',
                                         'Beef'))

col <- c("#FF9933", "#30C23D", "#0078E3", "#FF3300")



#Graphs nutrients:

Calcium <- subset(dry, (Component== "Ca (mg)"))
##geom_rect(aes(xmin = -Inf, xmax = +Inf, ymin = 0, ymax = maxNutrient), fill = "grey", alpha = 0.03)+
Ca <- ggplot(Calcium, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(ymin=minussd2, ymax=mean+newsd), width=.3) +
  ylab("mg Ca/1 g protein") + 
  xlab("") +
  theme_classic() + 
  theme(strip.text = element_text(size=10, face="bold"))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("b") + 
  theme(plot.title=element_text(size=10, hjust = 0, vjust=0.5)) + 
  theme(plot.title = element_text(hjust = 0, face="bold")) + 
  theme(axis.text.x = element_text(size = 10, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0.5, vjust=0.8, margin=margin(t=10,1,10,100))) + 
  theme(axis.title.y = element_text(size=10)) + 
  theme(axis.title.x  = element_text(size=10))+ 
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  theme(legend.position="none")+
  scale_y_continuous(expand = c(0, 0),limits=c(0, 150),breaks = seq(0, 150, by = 50))



Iron <-subset(dry, (Component== "Fe (mg)"))

Fe <- ggplot(Iron, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(ymin=minussd2, ymax=mean+newsd), width=.3) +
  ylab("mg Fe/1 g protein") + 
  xlab("") +
  theme_classic() + 
  theme(strip.text = element_text(size=10, face="bold"))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("c") + 
  theme(plot.title=element_text(size=10, hjust = 0, vjust=0.5)) + 
  theme(plot.title = element_text(hjust = 0, face="bold")) + 
  theme(axis.text.x = element_text(size = 10, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0.5, vjust=0.8, margin=margin(t=10,1,10,100))) + 
  theme(axis.title.y = element_text(size=10)) + 
  theme(axis.title.x  = element_text(size=10))+ 
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  theme(legend.position="none")+
  scale_y_continuous(expand = c(0, 0),limits=c(0, 6),breaks = seq(0, 6, by = 1))

Zinc <-subset(dry, (Component== "Zn (mg)"))

Zn <- ggplot(Zinc, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(ymin=minussd2, ymax=mean+newsd), width=.3) +
  ylab("mg Zn/1 g protein") + 
  xlab("") +
  theme_classic() + 
  theme(strip.text = element_text(size=10, face="bold"))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("d") + 
  theme(plot.title=element_text(size=10, hjust = 0, vjust=0.5)) + 
  theme(plot.title = element_text(hjust = 0, face="bold")) + 
  theme(axis.text.x = element_text(size = 10, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0.5, vjust=0.8, margin=margin(t=10,1,10,100))) + 
  theme(axis.title.y = element_text(size=10)) + 
  theme(axis.title.x  = element_text(size=10))+ 
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  theme(legend.position="none")+
  scale_y_continuous(expand = c(0, 0), limits=c(0, 0.5),breaks = seq(0, 0.5, by = 0.1))

Vit.A <-subset(dry, (Component== "Vit. A (ug)"))
Vit.A$mean2 <- ifelse(Vit.A$mean >100, 120, Vit.A$mean)
Vit.A$minussd2 <- ifelse(Vit.A$mean2==120, NA, Vit.A$minussd2)
Vit.A$newsd <- ifelse(Vit.A$mean2==120, NA, Vit.A$newsd)


VitA <- ggplot(Vit.A, aes(x=Species, y=mean2, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(ymin=minussd2, ymax=mean2+newsd), width=.3) +
  labs(y=expression(mu~"g Vit.A/1 g protein"))+
  xlab("") +
  theme_classic() + 
  theme(strip.text = element_text(size=10, face="bold"))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("e") + 
  theme(plot.title=element_text(size=10, hjust = 0, vjust=0.5)) + 
  theme(plot.title = element_text(hjust = 0, face="bold")) + 
  theme(axis.text.x = element_text(size = 10, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0.5, vjust=0.8, margin=margin(t=10,1,10,100))) + 
  theme(axis.title.y = element_text(size=10)) + 
  theme(axis.title.x  = element_text(size=10))+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  theme(legend.position="none")  +
  geom_text(data = subset(Vit.A, is.na(mean)),
            aes(y = 1.5, label = "ND"),  vjust=0, size=2)+
  geom_text(data = subset(Vit.A, mean==0), aes(y=0, label ="*"), vjust=0.4, hjust=0.5,size=4)+
  scale_y_continuous(expand = c(0, 0),limits=c(0, 125),breaks = seq(0, 120, by = 20))

Vit.B12 <-subset(dry, (Component== "Vit. B12 (ug)"))

Vit.B12 <-subset(dry, (Component== "Vit. B12 (ug)"))
Vit.B12$mean2 <- ifelse(Vit.B12$mean >4, 3, Vit.B12$mean)
Vit.B12$minussd2 <- ifelse(Vit.B12$mean2==3, NA, Vit.B12$minussd2)
Vit.B12$newsd <- ifelse(Vit.B12$mean2==3, NA, Vit.B12$newsd)

VitB12<- ggplot(Vit.B12, aes(x=Species, y=mean2, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(ymin=minussd2, ymax=mean2+newsd), width=.3) +
  labs(y=expression(mu ~ "g Vit.B"[12]/"1 g protein"))+
  xlab("") +
  theme_classic() + 
  theme(strip.text = element_text(size=10, face="bold"))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("f") + 
  theme(plot.title=element_text(size=10, hjust = 0, vjust=0.5)) + 
  theme(plot.title = element_text(hjust = 0, face="bold")) + 
  theme(axis.text.x = element_text(size = 10, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0.5, vjust=0.8, margin=margin(t=10,1,10,100))) + 
  theme(axis.title.y = element_text(size=10)) + 
  theme(axis.title.x  = element_text(size=10))+ 
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  theme(legend.position="none")  +
  geom_text(data = subset(Vit.B12, mean==0), aes(y=0, label ="*"), vjust=0.4, hjust=0.5,size=4)+
  scale_y_continuous(expand = c(0, 0), limits = c(0,3.2))
##

omega3fa <-subset(dry, (Component== "EPA + DHA (g)"))

DHAEPA<- ggplot(omega3fa, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(ymin=minussd2, ymax=mean+newsd), width=.3) +
  ylab("g EPA + DHA/1 g protein") + 
  xlab("") +
  theme_classic() + 
  theme(strip.text = element_text(size=10, face="bold"))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("g") + 
  theme(plot.title=element_text(size=10, hjust = 0, vjust=0.5)) + 
  theme(plot.title = element_text(hjust = 0, face="bold")) + 
  theme(axis.text.x = element_text(size = 10, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0.5, vjust=0.8, margin=margin(t=10,1,10,100))) + 
  theme(axis.title.y = element_text(size=10)) + 
  theme(axis.title.x  = element_text(size=10))+ 
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  theme(legend.position="none")  +
  geom_text(data = subset(omega3fa, is.na(mean)),
            aes(y = 0.001, label = "ND"),  vjust=0, size=2)+
  geom_text(data = subset(omega3fa, mean==0), aes(y=0, label ="*"), vjust=0.4, hjust=0.5,size=4)+
  scale_y_continuous(expand = c(0, 0), limits = c(0,0.07), breaks = seq(0, 0.07, by = 0.02))

#For protein (which has other units (g/100 g dry matter product))



proteindry <- subset(proteindry, (Species!= "Cultured meat"))
unique(proteindry$Species)

proteindry$Typefood=factor(proteindry$Typefood, levels=c('Future foods',
                                                         'Plant source foods',
                                                         'Seafood',
                                                         'Animal source foods'))




proteindry$Species=factor(proteindry$Species, levels=c('Mycoprotein',
                                                       'Chlorella',
                                                       'Spirulina',
                                                       'Sugar kelp',
                                                       'Black soldier fly',
                                                       'Housefly',
                                                       'Mealworm',
                                                       'Mussel',
                                                       'Bean',
                                                       'Wheat',
                                                       'Soybean',
                                                       'Rice',
                                                       'Maize',
                                                       'Tuna',
                                                       'Tilapia',
                                                       'Egg',
                                                       'Milk',
                                                       'Chicken',
                                                       'Pork',
                                                       'Beef'))

#write.csv(proteindry, file="Proteinfig2.csv")

prot<- ggplot(proteindry, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd), width=.3) +
  ylab("g protein/100 g dry matter") + 
  xlab("") +
  theme_classic() + 
  theme(strip.text = element_text(size=10, face="bold"))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("a") + 
  theme(plot.title=element_text(size=10, hjust = 0, vjust=0.5)) + 
  theme(plot.title = element_text(hjust = 0, face="bold")) + 
  theme(axis.text.x = element_text(size = 10, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0.5, vjust=0.8, margin=margin(t=10,1,10,100))) + 
  theme(axis.title.y = element_text(size=10)) + 
  theme(axis.title.x  = element_text(size=10))+ 
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  theme(legend.position="none")+
  scale_y_continuous(expand = c(0, 0),limits=c(0, 100),breaks = seq(0, 100, by = 20))



Lysine <- subset(dry, (Component== "Lysine (g)"))
##geom_rect(aes(xmin = -Inf, xmax = +Inf, ymin = 0, ymax = maxNutrient), fill = "grey", alpha = 0.03)+
Lysinenutrient <- ggplot(Lysine, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(ymin=minussd2, ymax=mean+newsd), width=.3) +
  ylab("g Lysine/1 g protein") + 
  xlab("") +
  theme_classic() + 
  theme(strip.text = element_text(size=10, face="bold"))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("a") + 
  theme(plot.title=element_text(size=10, hjust = 0, vjust=0.5)) + 
  theme(plot.title = element_text(hjust = 0, face="bold")) + 
  theme(axis.text.x = element_text(size = 10, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0.5, vjust=0.8, margin=margin(t=10,1,10,100))) + 
  theme(axis.title.y = element_text(size=10)) + 
  theme(axis.title.x  = element_text(size=10))+ 
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  theme(legend.position="none")+
  scale_y_continuous(expand = c(0, 0))


Methionine <- subset(dry, (Component== "Methionine (g)"))
##geom_rect(aes(xmin = -Inf, xmax = +Inf, ymin = 0, ymax = maxNutrient), fill = "grey", alpha = 0.03)+
Methioninenutrient <- ggplot(Methionine, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(ymin=minussd2, ymax=mean+newsd), width=.3) +
  ylab("g Methionine/1 g protein") + 
  xlab("") +
  theme_classic() + 
  theme(strip.text = element_text(size=10, face="bold"))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("b") + 
  theme(plot.title=element_text(size=10, hjust = 0, vjust=0.5)) + 
  theme(plot.title = element_text(hjust = 0, face="bold")) + 
  theme(axis.text.x = element_text(size = 10, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0.5, vjust=0.8, margin=margin(t=10,1,10,100))) + 
  theme(axis.title.y = element_text(size=10)) + 
  theme(axis.title.x  = element_text(size=10))+ 
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  theme(legend.position="none")+
  scale_y_continuous(expand = c(0, 0))


Threonine <- subset(dry, (Component== "Threonine (g)"))
##geom_rect(aes(xmin = -Inf, xmax = +Inf, ymin = 0, ymax = maxNutrient), fill = "grey", alpha = 0.03)+
Threoninenutrient <- ggplot(Threonine, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(ymin=minussd2, ymax=mean+newsd), width=.3) +
  ylab("g Threonine/1 g protein") + 
  xlab("") +
  theme_classic() + 
  theme(strip.text = element_text(size=10, face="bold"))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("c") + 
  theme(plot.title=element_text(size=10, hjust = 0, vjust=0.5)) + 
  theme(plot.title = element_text(hjust = 0, face="bold")) + 
  theme(axis.text.x = element_text(size = 10, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0.5, vjust=0.8, margin=margin(t=10,1,10,100))) + 
  theme(axis.title.y = element_text(size=10)) + 
  theme(axis.title.x  = element_text(size=10))+ 
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  theme(legend.position="none")+
  scale_y_continuous(expand = c(0, 0))



Tryptophan <- subset(dry, (Component== "Tryptophan (g)"))




##geom_rect(aes(xmin = -Inf, xmax = +Inf, ymin = 0, ymax = maxNutrient), fill = "grey", alpha = 0.03)+
Tryptophannutrient <- ggplot(Tryptophan, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(ymin=minussd2, ymax=mean+newsd), width=.3) +
  ylab("g Tryptophan/1 g protein") + 
  xlab("") +
  theme_classic() + 
  theme(strip.text = element_text(size=10, face="bold"))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("d") + 
  theme(plot.title=element_text(size=10, hjust = 0, vjust=0.5)) + 
  theme(plot.title = element_text(hjust = 0, face="bold")) + 
  theme(axis.text.x = element_text(size = 10, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0.5, vjust=0.8, margin=margin(t=10,1,10,100))) + 
  theme(axis.title.y = element_text(size=10)) + 
  theme(axis.title.x  = element_text(size=10))+ 
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  theme(legend.position="none")+
  scale_y_continuous(expand = c(0, 0))+
  geom_text(data = subset(Tryptophan, is.na(mean)),
            aes(y = 0.0001, label = "ND"),  vjust=0, size=2)



############################################### GRID GRAPH IN WHICH ALL SMALL GRAPHS ARE COMBINED INTO ONE ########################

#UPLOAD PACKAGE GRIDEXTRA
#With this section Figure 2 was made. The scales of the y label for vit A and vitB12 were shortened and arrow with the correct values were made with adoble illustrator. 

#Figure 2:
grid.arrange(prot, Ca, Fe, Zn, VitA, VitB12, DHAEPA, ncol=3)
allgraph <- arrangeGrob(prot, Ca, Fe, Zn, VitA, VitB12, DHAEPA, nrow=3) #generates g

#ggsave(file="Figure2.png", width = 25, height = 20, units="cm", dpi=300, allgraph) #saves g
#ggsave(file="Figure2).pdf", width = 25, height = 20, units="cm", dpi=300, allgraph)


#Supplementary Figure 1:

grid.arrange(Lysinenutrient, Methioninenutrient, Threoninenutrient, Tryptophannutrient, ncol=2)
aagraphnutrients <- arrangeGrob(Lysinenutrient, Methioninenutrient, Threoninenutrient, Tryptophannutrient, ncol=2)
#ggsave(file="Supplementary Figure 1.pdf", width = 18, height = 14.4, units="cm", dpi=300, aagraphnutrients)



#2.     Environmental impacts
#2.1.   Environmental impact of future foods, tilapia and tuna
#Environmental impacts of all future foods were obtained from the LCA literature. All the assumptions for the recalculations of the funcional units to impacts per kg of dry matter edible product
#are presented in the Supplementary Materials of the paper (SI 2 and SI 4).

#Import dataset with all the environmental impacts of future foods, tilapia and tuna.
Envimpacts_ff <- read.csv("Envimpacts_ff.csv")

#name columns
#[1] Study - Study from which the data was extracted (Author and year)
#[2] Functional_unit - Functional unit in which the environmental impact is expressed
#[3] Typeweight - Fresh or dry weight
#[4] Species - Name of the food
#[5] Feed_or_place - Additional specification regarding the type of species
#[6] Impact - Type of environmental impact and units (Global warming potential, Land use and Energy use)
#[7] Impact_dm_edible - Value of the impact
#[8] Watercontent - Water content in % relative to the fresh weight. It is used to calculate the impact per dry matter product.






#Import dataset with the impacts taken from Leip et al. (2014) & Leip et al. (2015):
# Leip, A., Weiss, F., Lesschen, J. P. & Westhoek, H. The nitrogenfootprint of food products in the European Union. J. Agric. Sci. 152,20-33 (2014).
# Leip, A. et al. Impacts of European livestock production: nitrogen, sulphur, phosphorus and greenhouse gas emissions, land-use, water eutrophication and biodiversity. Environ. Res. Lett. 10, 115004 (2015).
#These impacts are expressed per carcass weight

Leip_impacts <- read.csv("Leip_impacts.csv")
sapply(Leip_impacts, function(x) unique(x))


#name columns
#[1] Country - EU27 country code - see https://www.capri-model.org/dokuwiki/doku.php?id=capri:concept:regMarket
#[2] Impact - Type of impact (land use or GHG emissions)
#[3] Source - Source of the impact for each gas. LCAREA expressed in m2, the rest expressed in kg CO2eq. see below for the definition of acronyms.
#[4] BEEF - Values for beef per kg of carcass weight
#[5] PORK - Values for pork per kg of carcass weight
#[6] EGGS - Values for egg per kg of while weight
#[7] POUM - Values for poultry meat per kg of carcass weight
#[8] ANIMP - Values for animal protein per kg of carcass weight
#[9] DAIR - Values for dairy per kg of milk
#[10] SGMP - Values for sheep and goat meat per kg of carcass weight
#[11] SWHE - Values for common wheat per kg product
#[12] SOYA - Values for soy per kg product
#[13] PULS - Values for pulses per kg product
#[14] OFRU - Values for nuts and trees per kg product
#[15] MAIZ - Values for maize per kg product
#[16] RICE - Values for rice per kg product


#Values column [3] 'Source'.
#LCAREA - Land use in ha
#N2OMA2 - Direct nitrous oxide emissions stemming from manure management (only housing and storage) (IPCC)
#N2OAPL - Direct nitrous oxide emissins from manure application on soils (except grazing) due to livestock production
#N2OGRC - Direct nitrous oxide emissions from grazings on crops (IPCC)
#N2OSYN - Direct nitrous oxide emissions from anorganic fertilizer application (IPCC)
#N2OHIL - Direct nitrous oxide emissions from cultivation of histosols (IPCC via Miterra) due to livestock production
#N2OLEL - Indirect nitrous oxide emissions from leaching due to livestock production
#N2OCRL - Direct nitrous oxide emissions from crop residues due to livestock production
#N2OAML - Indirect nitrous oxide emissions from ammonia volatilisation due to livestock production
#N2OPRL - Nitrous oxide emissions during fertilizer production due to livestock production
#N2OBUL - Nitrous oxide emissions from land use change due to feed use of european livestock production (IPCC)
#N2OSOL - N2O emissions from land use change due to soil carbon losses caused by feed use of european livestock production (IPCC)
#CH4EN2 - Methane emissions from enteric fermentation (IPCC)
#CH4MA2 - Methane emissions from manure management (IPCC)
#CH4BUL - Methane emissions from land use change due to feed use of european livestock production (IPCC)
#CO2PRL - Carbon Dioxide emissions during fertilizer production due to livestock production
#CO2FTR - Carbon Dioxide emissions from feed transport
#CO2FPR - Carbon Dioxide emissions from feed processing
#CO2SEL - Carbon Dioxide emissions from seed production due to livestock production
#CO2PPL - Carbon Dioxide emissions from plant protection due to livestock production
#CO2BIL - Carbon dioxide emissions from land use change due to losses of carbon in biomass and litter caused by feed use of european livestock production(IPCC)
#CO2SOL - Carbon dioxide emissions from land use change due to soil carbon losses caused by feed use of european livestock production (IPCC)
#CO2SQL - Carbon dioxide emissions due to lost carbon sequestration of grassland (for grassland negative) caused by feed use of european livestock production
#CO2HIL - Carbon dioxide emissions from the cultivation of histosols due to livestock production
#CO2DIC - Carbon Dioxide emissions from diesel consumption in machinery use
#CO2OFC - Carbon Dioxide emissions from consumption of other fuels
#CO2ELC - Carbon Dioxide emissions from electricity consumption
#CO2INC - Indirect Carbon Dioxide emissions from machinery and buildings
#CO2ELA - Carbon Dioxide emissions from electricity consumption
#CO2INQ - Indirect Carbon Dioxide emissions from machinery and buildings
#CO2OFA - Carbon Dioxide emissions from consumption of other fuels
#N2OHIS - Direct nitrous oxide emissions from cultivation of histosols (IPCC via Miterra)
#N2OLEA - Indirect nitrous oxide emissions from leaching (IPCC via Miterra)
#N2OCRO - Direct nitrous oxide emissions from crop residues (IPCC)
#N2OAMM - Indirect nitrous oxide emissions from ammonia volatilisation (IPCC)
#N2OPRD - Nitrous oxide emissions during fertilizer production (Expert Data)
#CO2PRD - Carbon Dioxide emissions during fertilizer production
#CO2SEE - Carbon Dioxide emissions from seed production
#CO2PPT - Carbon Dioxide emissions from plant protection
#CO2HIS - Carbon dioxide emissions from the cultivation of histosols
#N2OBUR - Nitrous oxide emissions from land use change (IPCC)
#N2OSOI - N2O emissions from land use change due to soil carbon losses (IPCC)
#CH4BUR - Methane emissions from land use change (IPCC)
#CO2BIO - Carbon dioxide emissions from land use change due to losses of carbon in biomass and litter (IPCC)
#CO2SOI - Carbon dioxide emissions from land use change due to soil carbon losses (IPCC)
#CH4RIC - Methane emissions from rice production (IPCC)


#Restructure dataset
Leip2 <- gather(Leip_impacts, "product", "value", 4:16)
Leip2 <- na.omit(Leip2)
unique(Leip2$Source)

#Delete the "saved" impacts associated to carbon sequestration.
Leip2 <- subset(Leip2, (value >0)) 
Leip2 <- subset(Leip2, (Source!="CO2SQL"))


#Transform Land Use to m2:
Leip2$value <- ifelse(Leip2$Impact=="Land Use", Leip2$value*10000, Leip2$value)


#Sum all the impacts per product
Leip3 <- ddply(Leip2, .(Country, Impact, product), summarize, suma = sum (value, na.rm=TRUE))

#Remove total EU average and undesired animal products:
Leip3 <- subset(Leip3, (Country!="EU027000") & (product!= "ANIMP") & (product!= "SGMP") & (product!= "OFRU"))
unique(Leip3$product)

#Transformation factors from carcass to edible weight (the references/sources are presented in the Supplementary Table 6)

Leip3$edible_factor <- ifelse(Leip3$product=="BEEF", "0.63", 
                                ifelse (Leip3$product=="DAIR", "1", 
                                        ifelse(Leip3$product=="PORK", "0.6", 
                                               ifelse(Leip3$product=="EGGS", "0.88", 
                                                      ifelse(Leip3$product=="POUM", "0.58",
                                                             ifelse(Leip3$product=="SWHE", "1",
                                                                    ifelse(Leip3$product=="PULS", "1",
                                                                           ifelse(Leip3$product=="SOYA", "1",
                                                                                  ifelse(Leip3$product=="MAIZ", "1",
                                                                                         ifelse(Leip3$product=="RICE", "1", "0"))))))))))  
#factors to convert to dry matter edible weight:
Leip3$dm_factor <- ifelse(Leip3$product=="BEEF", "2.728782942", 
                            ifelse (Leip3$product=="DAIR", "8.424599832", 
                                    ifelse(Leip3$product=="PORK", "2.497936034", 
                                           ifelse(Leip3$product=="EGGS", "4.192872117", 
                                                  ifelse(Leip3$product=="POUM", "2.939809027",
                                                         ifelse(Leip3$product=="SWHE", "1.122838536",
                                                                ifelse(Leip3$product=="PULS", "1.133144476",
                                                                       ifelse(Leip3$product=="SOYA", "1.093374153", 
                                                                              ifelse(Leip3$product=="MAIZ", "4.167534903",
                                                                                     ifelse(Leip3$product=="RICE", "1.14416476", "0"))))))))))


Leip3$dm_factor <- as.numeric(as.character(Leip3$dm_factor))
Leip3$edible_factor <- as.numeric(as.character(Leip3$edible_factor))

#Calculate environmental impacts per kg of dry matter edible product:
Leip3$watercontent <- (1- (1/Leip3$dm_factor))*100
Leip3$impact_dm_edible <- (Leip3$suma/Leip3$edible_factor)* Leip3$dm_factor


#Change names:

Leip3$product[Leip3$product == "BEEF"] <- "Beef"
Leip3$product[Leip3$product == "DAIR"] <- "Milk"
Leip3$product[Leip3$product == "EGGS"] <- "Egg"
Leip3$product[Leip3$product == "PORK"] <- "Pork"
Leip3$product[Leip3$product == "POUM"] <- "Chicken"
Leip3$product[Leip3$product == "PULS"] <- "Bean"
Leip3$product[Leip3$product == "SOYA"] <- "Soybean"
Leip3$product[Leip3$product == "SWHE"] <- "Wheat"
Leip3$product[Leip3$product == "MAIZ"] <- "Maize"
Leip3$product[Leip3$product == "RICE"] <- "Rice"
Leip3$Impact<- as.character(Leip3$Impact)
unique(Leip3$Impact)

Leip3$Impact[Leip3$Impact == "GHG emissions"] <- "GWP (kg CO2 eq)"
Leip3$Impact[Leip3$Impact == "Land Use"] <- "LU(m2)"

unique(Leip3$product)

#Add columns to merge the dataset with the dataset of future foods "Envimpacts_ff"
Leip3$Study <- "Leip et al. (2014) & Leip et al. (2015)"
Leip3$FU <- "1 kg edible product"
Leip3$Typeweight <- "Dry weight"
#Reorder columns
Leip3 <- Leip3[,c(9,10,11,3,1,2,8,7,4,5,6)]
Leip3[9:11] <- list(NULL)
colnames(Leip3) <- c("Study", "Functional_unit",
                       "Typeweight", 
                       "Species", "Feed_or_place", "Impact", "Impact_dm_edible", "Watercontent")


### Merge Envimpacts_ff and "Leip3" Everything is in dry weight
compilationfinal <- rbind(Envimpacts_ff, Leip3)

# Edit the database "Compilationfinal" to get the Supplementary Table 7

SupTablesix <- compilationfinal
SupTablesix[9] <- list(NULL)
SupTablesix[2:3] <- list(NULL)

SupTablesix$Typefood <- ifelse(SupTablesix$Species=="Beef" |  
                                 SupTablesix$Species=="Pork" |
                                 SupTablesix$Species=="Chicken" |
                                 SupTablesix$Species=="Milk" |
                                 SupTablesix$Species=="Egg", "Animal-source foods", "rest" )

SupTablesix$Typefood <- ifelse(SupTablesix$Species=="Maize" |  
                                 SupTablesix$Species=="Rice" |
                                 SupTablesix$Species=="Wheat" |
                                 SupTablesix$Species=="Bean" |
                                 SupTablesix$Species=="Soybean",  "Plant-source foods", SupTablesix$Typefood)

SupTablesix$Typefood <- ifelse(SupTablesix$Species=="Tuna" |  
                                 SupTablesix$Species=="Tilapia", "Seafood", SupTablesix$Typefood)

SupTablesix$Typefood <- ifelse(SupTablesix$Typefood=="rest", "Future foods", SupTablesix$Typefood)

SupTablesix <- SupTablesix[,c(7,1,2,3,4,5,6)]

names(SupTablesix)[names(SupTablesix) == "Watercontent"] <- "Watercontent(%)"


#Supplementary Table 6

#write.csv(SupTablesix, file = "Supplementary Table 7.csv", row.names = FALSE)


### Nutritional dataset (express in dry matter edible product)
Nutrientprofiledry <- subset(Nutrientprofile, (Weight=="Dry weight"))
unique(Nutrientprofiledry$Component)
unique(Nutrientprofiledry$Species)


#Combine both datasets:
Nutrientprofiledry <- Nutrientprofiledry[,-1]

Nutrientprofiledry$concatenate<- with(Nutrientprofiledry, paste0(Component, "_",Units , 
                                                                 "_",Author , "_",Species , 
                                                                 "_",Weight , "_",Feed, 
                                                                 "_",Typefood, "_", Value, 
                                                                 "_", proteinvalue, "_", value1gprot))


compilationfinal$concatenate<- with(compilationfinal, paste0(Study, "_",Functional_unit , 
                                                             "_",Typeweight, "_",Species , 
                                                             "_",Feed_or_place, "_",Impact, "_",
                                                             Impact_dm_edible, "_", Watercontent))

#In this stage, the nutritional composition and the environmental impacts dataset are mixed using expand.grid. 
#The columns "concatenate" of both datasets are combined in a way that every row of one dataset is mixed with all the concatenate values of the other dataset
#The concatenate columns are expanded using the "separate" function. 
#Once separated, the desired combinations are the ones in which the "Species" , match with the "Source". For this a subset is used:


combinatie <- expand.grid(x=Nutrientprofiledry$concatenate, y=compilationfinal$concatenate)
combinatie$x <- as.character(combinatie$x)


combinatie2 <- data.frame(do.call(rbind, str_split(combinatie$x,'_')))
names(combinatie2) <- c("Component", "Units", "Author", 
                        "Species", "Weight", "Feed", 
                        "Typefood", "Value", "proteinvalue", "value1gprot")

combinatie2$y <- combinatie$y
combinatie3 <- combinatie2 %>% separate(y, c("study", "FU", "Typeweight", "Source", 
                                             "feedplace", "impact",
                                             "dryweight", "watercontent"), "_")

futurefoods <- subset(combinatie3, combinatie3$Species == combinatie3$Source)     

#Transform columns as numeric
futurefoods$Value <- as.numeric(as.character(futurefoods$Value))
futurefoods$proteinvalue <- as.numeric(as.character(futurefoods$proteinvalue))
futurefoods$value1gprot <- as.numeric(as.character(futurefoods$value1gprot))
futurefoods$dryweight <- as.numeric(as.character(futurefoods$dryweight))
futurefoods$watercontent <- as.numeric(as.character(futurefoods$watercontent))

#Upload dataset with nutrient requirements (References/sources are presented in the Supplementary Table 4)

requirements <- read.csv("requirements.csv")

#[1] Component - Name of the nutrient & units
#[2] Requirement - Value for each nutrient requirement on a daily basis

#Merge the requirements in the "future foods" dataset created above

futurefoods <- merge(futurefoods, requirements[c("Component", "Requirement")], all.x=TRUE)

#Remove the nutrients that do not have any requirement (e.g., Chitin, ALA, etc)

futurefoods<- futurefoods[complete.cases(futurefoods[ , 19]),]

#Calculate the impacts to fulfill 100% of the nutrient requirement. How much of each food do you need to fulfill the daily requirement. And then, what is the environmental impact associated
#to the production of such amount?

futurefoods$impactreq <- ((futurefoods$Requirement*1)*(futurefoods$dryweight/10)/futurefoods$Value)

futurefoods <- do.call(data.frame,lapply(futurefoods, function(x) replace(x, is.infinite(x),NaN)))
unique(futurefoods$Typefood)

futurefoods$Typefood <- as.character(futurefoods$Typefood)
futurefoods$Typefood <- ifelse((futurefoods$Species == "Cultured meat"),"Future foods",futurefoods$Typefood)



#Calculate the mean and the std. error of the mean of the impacts to fulfill the daily recommended intake of each nutrient:

futurefoodsmean <- ddply(futurefoods, .(Component, Species, Typefood, impact), 
                         summarize, mean = mean (impactreq, na.rm=TRUE), sderror= std.error(impactreq, na.rm=TRUE))

#For the nutrients that there is no data, "NA" is added:

futurefoodsmean$mean <- ifelse((futurefoodsmean$Component== "EPA + DHA (g)" & futurefoodsmean$Species=="Mycoprotein"), NA, futurefoodsmean$mean)
futurefoodsmean$mean <- ifelse((futurefoodsmean$Component== "EPA + DHA (g)" & futurefoodsmean$Species=="Soybean"), NA, futurefoodsmean$mean)
futurefoodsmean$mean <- ifelse((futurefoodsmean$Component== "Vit. A (ug)" & futurefoodsmean$Species=="Chlorella"), NA, futurefoodsmean$mean)

futurefoodsmean$Component <- as.character(futurefoodsmean$Component)

#Change labels

futurefoodsmean$Component[futurefoodsmean$Component == "Ca (mg)"] <- "Ca (1000 mg)"
futurefoodsmean$Component[futurefoodsmean$Component == "Fe (mg)"] <- "Fe (14 mg)"
futurefoodsmean$Component[futurefoodsmean$Component == "Zn (mg)"] <- "Zn (15 mg)"
futurefoodsmean$Component[futurefoodsmean$Component == "EPA + DHA (g)"] <- "EPA + DHA (250 mg)"
futurefoodsmean$Component[futurefoodsmean$Component == "Vit. A (ug)"] <- "Vit. A (800 ug)"
futurefoodsmean$Component[futurefoodsmean$Component == "Vit. B12 (ug)"] <- "Vit. B12 (2.4 ug)"
futurefoodsmean$Component[futurefoodsmean$Component == "Protein (g)"] <- "Protein (50 g)"
futurefoodsmean$Component[futurefoodsmean$Component == "Lysine (g)"] <- "Lysine (2.1 g)"
futurefoodsmean$Component[futurefoodsmean$Component == "Methionine (g)"] <- "Methionine (0.73 g)"
futurefoodsmean$Component[futurefoodsmean$Component == "Threonine (g)"] <- "Threonine (1.05 g)"
futurefoodsmean$Component[futurefoodsmean$Component == "Tryptophan (g)"] <- "Tryptophan (0.28 g)"


#Modify table for Supplementary Table 8
Tableight <- futurefoodsmean
Tableight <- Tableight[,c(3, 2, 1, 4, 5, 6)]

names(Tableight)[names(Tableight) == "Component"] <- "Nutrient"
names(Tableight)[names(Tableight) == "impact"] <- "Impact"
names(Tableight)[names(Tableight) == "mean"] <- "Mean impact"
names(Tableight)[names(Tableight) == "sderror"] <- "Standard error"

Tableight <- subset(Tableight, Nutrient!= "Vit. D (ug)")

#write.csv(Tableight, file="Supplementary Table 8.csv", row.names = FALSE)


#Figure 3, Figure 4, Supplementary Figures 2-5

futurefoodsghgbar <- subset(futurefoodsmean, (impact=="GWP (kg CO2 eq)"| impact=="GHG (kgCO2eq)"))
futurefoodsLUbar <- subset(futurefoodsmean, (impact=="LU (m2)" | impact=="LU(m2)"))

unique(futurefoodsmean$impact)


futurefoodsghgbar$Typefood=factor(futurefoodsghgbar$Typefood, levels=c('Future foods',
                                                                       'Plant source foods',
                                                                       'Seafood',
                                                                       'Animal source foods'))




futurefoodsghgbar$Species=factor(futurefoodsghgbar$Species, levels=c('Cultured meat', 
                                                                     'Mycoprotein',
                                                                     'Chlorella',
                                                                     'Spirulina',
                                                                     'Sugar kelp',
                                                                     'Black soldier fly',
                                                                     'Housefly',
                                                                     'Mealworm',
                                                                     'Mussel',
                                                                     'Bean',
                                                                     'Wheat',
                                                                     'Soybean',
                                                                     'Rice',
                                                                     'Maize',
                                                                     'Almond',
                                                                     'Tuna',
                                                                     'Tilapia',
                                                                     'Egg',
                                                                     'Milk',
                                                                     'Chicken',
                                                                     'Pork',
                                                                     'Beef'))


futurefoodsghgbar$Component=factor(futurefoodsghgbar$Component, levels=c('Protein (50 g)',
                                                                         'Lysine (2.1 g)',
                                                                         'Methionine (0.73 g)',
                                                                         'Threonine (1.05 g)',
                                                                         'Tryptophan (0.28 g)',
                                                                         'Ca (1000 mg)', 
                                                                         'Fe (14 mg)', 
                                                                         'Zn (15 mg)', 
                                                                         'Vit. A (800 ug)',
                                                                         'Vit. B12 (2.4 ug)',
                                                                         'EPA + DHA (250 mg)'))

futurefoodsghgbar <- futurefoodsghgbar[complete.cases(futurefoodsghgbar[ , 1]),]

Proteinghg <- subset(futurefoodsghgbar, (Component=="Protein (50 g)"))
Caghg <- subset(futurefoodsghgbar, (Component=="Ca (1000 mg)"))
Feghg <- subset(futurefoodsghgbar, (Component=="Fe (14 mg)"))
Znghg <- subset(futurefoodsghgbar, (Component=="Zn (15 mg)"))
VitAghg <- subset(futurefoodsghgbar, (Component=="Vit. A (800 ug)"))
VitB12ghg <- subset(futurefoodsghgbar, (Component=="Vit. B12 (2.4 ug)"))
dhafutureghg <- subset(futurefoodsghgbar, (Component=="EPA + DHA (250 mg)"))
Lysineghg <- subset(futurefoodsghgbar, (Component=="Lysine (2.1 g)"))
Methionineghg <- subset(futurefoodsghgbar, (Component=="Methionine (0.73 g)"))
Threonineghg <- subset(futurefoodsghgbar, (Component=="Threonine (1.05 g)"))
Tryptophanghg <- subset(futurefoodsghgbar, (Component=="Tryptophan (0.28 g)"))

#Protein
ghgprot<- ggplot(Proteinghg, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  labs(y=expression(kgCO[2*eq]))+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0), limits = c(0,13), breaks = seq(0, 13, by = 3))+
  theme(legend.position="none")


#Calcium
Caghg <- subset(futurefoodsghgbar, (Component=="Ca (1000 mg)"))
#modify the scale because beef is too high!
Caghg$mean <- ifelse(Caghg$mean >200, 180, Caghg$mean)
Caghg$sderror <- ifelse(Caghg$mean==180, NA, Caghg$sderror)

ghgCa<- ggplot(Caghg, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  ylab("")+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0), limits = c(0,180), breaks = seq(0, 180, by = 30))+
  theme(legend.position="none")

#Iron

Feghg <- subset(futurefoodsghgbar, (Component=="Fe (14 mg)"))
Feghg$mean <- ifelse(Feghg$mean >40, 50, Feghg$mean)
Feghg$sderror <- ifelse(Feghg$mean==50, NA, Feghg$sderror)


ghgFe<- ggplot(Feghg, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  ylab("")+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0.0),limits = c(0,50), breaks = seq(0, 50, by = 10))+
  theme(legend.position="none")

#Zinc
Znghg <- subset(futurefoodsghgbar, (Component=="Zn (15 mg)"))

ghgZn <- ggplot(Znghg, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  labs(y=expression(kgCO[2*eq]))+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0.1),limits = c(0,100), breaks = seq(0, 100, by = 20))+
  theme(legend.position="none")

#VitA - NaN means that the nutrient is absent. NA means that it uknown, so there is "NO DATA" for that food.
VitAghg <- subset(futurefoodsghgbar, (Component=="Vit. A (800 ug)"))

VitAghg$mean2 <- ifelse(VitAghg$Species=="Beef", 350, ifelse(VitAghg$Species=="Pork", 320, VitAghg$mean))
VitAghg$sderror <- ifelse(VitAghg$mean>319, NA, VitAghg$sderror)

ghgVitA<-ggplot(VitAghg, aes(x=Species, y=mean2, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean2-sderror, ymax=mean2+sderror), width=.3) +
  ylab("")+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  geom_text(data = subset(VitAghg, is.nan(mean2)),
            aes(y = 4, label = "*"),  vjust=0.4, hjust=0.5,size=4)+
  geom_text(data = subset(VitAghg, Species=="Chlorella"),
            aes(y = 4, label = "ND"),    vjust=0, size=2)+
  scale_y_continuous(expand = c(0, 0.1),limits = c(0,350), breaks = seq(0, 400, by = 80))+
  theme(legend.position="none")



#B12
VitB12ghg <- subset(futurefoodsghgbar, (Component=="Vit. B12 (2.4 ug)"))

VitB12ghg$Typefood=factor(VitB12ghg$Typefood, levels=c('Future foods',
                                                       'Plant source foods',
                                                       'Seafood',
                                                       'Animal source foods'))
colb12 <- c("#FF3300","#FF9933","#30C23D",  "#0078E3" )

ghgVitBdoce<- ggplot(VitB12ghg, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  ylab("")+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=colb12)+
  scale_color_manual(values=colb12)+
  theme(legend.position="bottom")+
  geom_text(data = subset(VitB12ghg, is.nan(mean)), aes(y=0, label ="*"), vjust=0.4, hjust=0.5,size=4)+
  scale_y_continuous(expand = c(0, 0), limits= c(0,8), breaks = seq(0, 8, by = 2))+
  theme(legend.position="none")


##dha

dhafutureghg <- subset(futurefoodsghgbar, (Component=="EPA + DHA (250 mg)"))
dhafutureghg$mean2 <- ifelse(dhafutureghg$Species=="Beef", 80, ifelse(dhafutureghg$Species=="Pork", 90, ifelse(dhafutureghg$Species=="Cultured meat", 70, dhafutureghg$mean)))
dhafutureghg$sderror <- ifelse(dhafutureghg$mean>60, NA, dhafutureghg$sderror)
colb12 <- c("#FF3300","#FF9933","#30C23D",  "#0078E3" )


ghgdha<- ggplot(dhafutureghg, aes(x=Species, y=mean2, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean2-sderror, ymax=mean2+sderror), width=.3) +
  labs(y=expression(kgCO[2*eq]))+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) +
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=colb12)+
  scale_color_manual(values=colb12)+
  theme(legend.position="bottom")+
  geom_text(data = subset(dhafutureghg, is.nan(mean2)),
            aes(y = 0.7, label = "*"),  vjust=0.4, hjust=0.5,size=4)+
  geom_text(data = subset(dhafutureghg, Species=="Mycoprotein" | Species=="Soybean"),
            aes(y = 0.7, label = "ND"),  vjust=0, size=2)+
  scale_y_continuous(expand = c(0, 0), limits = c(0, 90))+
  theme(legend.position="none")



Lysineghg <- subset(futurefoodsghgbar, (Component=="Lysine (2.1 g)"))
Lysineghg$sderror <- ifelse(Lysineghg$mean==0, NA, Lysineghg$sderror)

ghgLysine <- ggplot(Lysineghg, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  labs(y=expression(kgCO[2*eq]))+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0.1), limits=c(0, 12.5),breaks = seq(0, 15, by = 3))+
  theme(legend.position="none")


Methionineghg <- subset(futurefoodsghgbar, (Component=="Methionine (0.73 g)"))
Methionineghg$sderror <- ifelse(Methionineghg$mean==0, NA, Methionineghg$sderror)

ghgMethionine <- ggplot(Methionineghg, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  labs(y=expression(kgCO[2*eq]))+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0.1), limits=c(0, 9),breaks = seq(0, 9, by = 3))+
  theme(legend.position="none")


Threonineghg <- subset(futurefoodsghgbar, (Component=="Threonine (1.05 g)"))
Threonineghg$sderror <- ifelse(Threonineghg$mean==0, NA, Threonineghg$sderror)

ghgThreonine <- ggplot(Threonineghg, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  labs(y=expression(kgCO[2*eq]))+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0.1), limits=c(0, 8),breaks = seq(0, 8, by = 2))+
  theme(legend.position="none")



Tryptophanghg <- subset(futurefoodsghgbar, (Component=="Tryptophan (0.28 g)"))
Tryptophanghg$sderror <- ifelse(Tryptophanghg$mean==0, NA, Tryptophanghg$sderror)

ghgTryptophan <- ggplot(Tryptophanghg, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  labs(y=expression(kgCO[2*eq]))+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0.1), limits=c(0, 8),breaks = seq(0, 8, by = 2))+
  theme(legend.position="none")+
  geom_text(data = subset(Tryptophanghg, is.nan(mean)),
            aes(y = 0.2, label = "ND"),  vjust=0.4, hjust=0.5,size=2)




#Figure 4 (It is then edited in Adobe Illustrator to add the arrows)

grid.arrange(ghgprot, ghgCa, ghgFe, ghgZn, ghgVitA, ghgVitBdoce, ghgdha, ncol=3)
aver <- arrangeGrob(ghgprot, ghgCa, ghgFe, ghgZn, ghgVitA, ghgVitBdoce, ghgdha, ncol=3) #generates g
#ggsave(file="Figure4.png", width = 25, height = 20, units="cm", dpi=300, aver) #saves g
#ggsave(file="Figure4(1).pdf", width = 25, height = 20, units="cm", dpi=300, aver)


#Supplementary Figure 5:

grid.arrange(ghgLysine, ghgMethionine, ghgThreonine, ghgTryptophan, ncol=2, nrow=2)
ghgaver <- arrangeGrob(ghgLysine, ghgMethionine, ghgThreonine, ghgTryptophan, ncol=2) #generates g
#ggsave(file="Figure 7.pdf", width = 18, height = 14.4, units="cm", dpi=300, ghgaver) #saves g
#SAME BUT FOR LAND USE



#Figures for Land use:

unique(futurefoodsLUbar$Species)
unique(futurefoodsLUbar$Component)

futurefoodsLUbar$Typefood=factor(futurefoodsLUbar$Typefood, levels=c('Future foods',
                                                                     'Plant source foods',
                                                                     'Seafood',
                                                                     'Animal source foods'))




futurefoodsLUbar$Species=factor(futurefoodsLUbar$Species, levels=c('Cultured meat', 
                                                                   'Mycoprotein',
                                                                   'Chlorella',
                                                                   'Spirulina',
                                                                   'Sugar kelp',
                                                                   'Black soldier fly',
                                                                   'Housefly',
                                                                   'Mealworm',
                                                                   'Mussel',
                                                                   'Bean',
                                                                   'Wheat',
                                                                   'Soybean',
                                                                   'Rice',
                                                                   'Maize',
                                                                   'Almond',
                                                                   'Tuna',
                                                                   'Tilapia',
                                                                   'Egg',
                                                                   'Milk',
                                                                   'Chicken',
                                                                   'Pork',
                                                                   'Beef'))


futurefoodsLUbar$Component=factor(futurefoodsLUbar$Component, levels=c('Protein (50 g)',
                                                                       'Lysine (2.1 g)',
                                                                       'Methionine (0.73 g)',
                                                                       'Threonine (1.05 g)',
                                                                       'Tryptophan (0.28 g)',
                                                                       'Ca (1000 mg)', 
                                                                       'Fe (14 mg)', 
                                                                       'Zn (15 mg)', 
                                                                       'Vit. A (800 ug)',
                                                                       'Vit. B12 (2.4 ug)',
                                                                       'EPA + DHA (250 mg)'))


#Remove NAs from nutrient (this is vitamin D)
futurefoodsLUbar <- futurefoodsLUbar[complete.cases(futurefoodsLUbar[ , 1]),]

Proteinlu <- subset(futurefoodsLUbar, (Component=="Protein (50 g)"))
Calu <- subset(futurefoodsLUbar, (Component=="Ca (1000 mg)"))
Felu <- subset(futurefoodsLUbar, (Component=="Fe (14 mg)"))
Znlu <- subset(futurefoodsLUbar, (Component=="Zn (15 mg)"))
VitAglu <- subset(futurefoodsLUbar, (Component=="Vit. A (800 ug)"))
VitB12lu <- subset(futurefoodsLUbar, (Component=="Vit. B12 (2.4 ug)"))
dhafuturelu <- subset(futurefoodsLUbar, (Component=="EPA + DHA (250 mg)"))
dhafuturelu2 <- subset(dhafuturelu, (Typefood!= "Animal source foods" & Typefood!= "Plant source foods"))
Lysinelu <- subset(futurefoodsLUbar, (Component=="Lysine (2.1 g)"))
Methioninelu <- subset(futurefoodsLUbar, (Component=="Methionine (0.73 g)"))
Threoninelu <- subset(futurefoodsLUbar, (Component=="Threonine (1.05 g)"))
Tryptophanlu <- subset(futurefoodsLUbar, (Component=="Tryptophan (0.28 g)"))


coltwo <- c("#FF9933", "#0078E3")




#Protein

luprot<- ggplot(Proteinlu, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  labs(y=expression("LU "(m^{2})))+ 
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0),limits=c(0, 25),breaks = seq(0, 25, by = 5))+
  theme(legend.position="none")


#Calcium
Calu <- subset(futurefoodsLUbar, (Component=="Ca (1000 mg)"))
Calu$mean2 <- ifelse(Calu$mean >400, 400, Calu$mean)

luCa<- ggplot(Calu, aes(x=Species, y=mean2, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean2-sderror, ymax=mean2+sderror), width=.3) +
  ylab("")+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0.1),limits=c(0, 400),breaks = seq(0, 400, by = 100))+
  theme(legend.position="none")

#Iron

Felu <- subset(futurefoodsLUbar, (Component=="Fe (14 mg)"))
Felu$mean2 <- ifelse(Felu$Species=="Milk", 70, Felu$mean)


luFe<- ggplot(Felu, aes(x=Species, y=mean2, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean2-sderror, ymax=mean2+sderror), width=.3) +
  ylab("")+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0.1),limits=c(0, 80),breaks = seq(0, 80, by = 20))+
  theme(legend.position="none")

#Zinc
Znlu <- subset(futurefoodsLUbar, (Component=="Zn (15 mg)"))
Znlu$mean2 <- ifelse(Znlu$Species=="Tilapia", 30, Znlu$mean)
Znlu$sderror <- ifelse(Znlu$mean>29, NA, Znlu$sderror)

luZn <- ggplot(Znlu, aes(x=Species, y=mean2, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean2-sderror, ymax=mean2+sderror), width=.3) +
  labs(y=expression("LU "(m^{2})))+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0.1), limits=c(0, 40),breaks = seq(0, 40, by = 10))+
  theme(legend.position="none")

#VitA
VitAglu <- subset(futurefoodsLUbar, (Component=="Vit. A (800 ug)"))
VitAglu$mean2 <- ifelse(VitAglu$Species=="Beef", 450, ifelse(VitAglu$Species=="Pork", 400, VitAglu$mean))
VitAglu$sderror <- ifelse(VitAglu$mean2>399, NA, VitAglu$sderror)


luVitA<-ggplot(VitAglu, aes(x=Species, y=mean2, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean2-sderror, ymax=mean2+sderror), width=.3) +
  ylab("")+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  geom_text(data = subset(VitAglu, Species=="Chlorella"),
            aes(y = 10, label = "ND"),  vjust=0, size=2)+
  geom_text(data = subset(VitAglu, is.nan(mean)), aes(y=0, label ="*"), vjust=0.4, hjust=0.5,size=4)+
  scale_y_continuous(expand = c(0, 0.1), limits = c(0, 450),breaks = seq(0, 450, by = 90))+
  theme(legend.position="none")


#B12
VitB12lu <- subset(futurefoodsLUbar, (Component=="Vit. B12 (2.4 ug)"))


luVitBdoce<- ggplot(VitB12lu, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  ylab("")+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=colb12)+
  scale_color_manual(values=colb12)+
  theme(legend.position="bottom")+
  geom_text(data = subset(VitB12lu, is.nan(mean)), aes(y=0, label ="*"), vjust=0.4, hjust=0.5,size=4)+
  scale_y_continuous(expand = c(0, 0), limits = c(0, 15))+
  theme(legend.position="none")


#dha

dhafuturelu <- subset(futurefoodsLUbar, (Component=="EPA + DHA (250 mg)"))
dhafuturelu$mean2 <- ifelse(dhafuturelu$Species=="Beef", 150, ifelse(dhafuturelu$Species=="Pork", 160, dhafuturelu$mean))
dhafuturelu$sderror <- ifelse(dhafuturelu$mean2>84, NA, dhafuturelu$sderror)

dhafuturelu$Typefood=factor(dhafuturelu$Typefood, levels=c('Future foods',
                                                           'Plant source foods',
                                                           'Seafood',
                                                           'Animal source foods'))




dhafuturelu$Species=factor(dhafuturelu$Species, levels=c('Cultured meat', 
                                                         'Mycoprotein',
                                                         'Chlorella',
                                                         'Spirulina',
                                                         'Sugar kelp',
                                                         'Black soldier fly',
                                                         'Housefly',
                                                         'Mealworm',
                                                         'Mussel',
                                                         'Bean',
                                                         'Wheat',
                                                         'Soybean',
                                                         'Rice',
                                                         'Maize',
                                                         'Almond',
                                                         'Tuna',
                                                         'Tilapia',
                                                         'Egg',
                                                         'Milk',
                                                         'Chicken',
                                                         'Pork',
                                                         'Beef'))




ludha<- ggplot(dhafuturelu, aes(x=Species, y=mean2, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean2-sderror, ymax=mean2+sderror), width=.3) +
  labs(y=expression("LU "(m^{2})))+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) +
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=colb12)+
  scale_color_manual(values=colb12)+
  theme(legend.position="bottom")+
  geom_text(data = subset(dhafutureghg, is.nan(mean2)),
            aes(y = 3, label = "*"),  vjust=0.4, hjust=0.5,size=4)+
  geom_text(data = subset(dhafutureghg, Species=="Mycoprotein" | Species=="Soybean"),
            aes(y = 3, label = "ND"),  vjust=0, size=2)+
  scale_y_continuous(expand = c(0, 0), limits = c(0,160))+
  theme(legend.position="none")


#####
Lysinelu <- subset(futurefoodsLUbar, (Component=="Lysine (2.1 g)"))
Lysinelu$sderror <- ifelse(Lysinelu$mean==0, NA, Lysinelu$sderror)

luLysine <- ggplot(Lysinelu, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  labs(y=expression("LU "(m^{2})))+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0.1), limits=c(0, 11),breaks = seq(0, 15, by = 3))+
  theme(legend.position="none")

Methioninelu <- subset(futurefoodsLUbar, (Component=="Methionine (0.73 g)"))
Methioninelu$sderror <- ifelse(Methioninelu$mean==0, NA, Methioninelu$sderror)

luMethionine <- ggplot(Methioninelu, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  labs(y=expression("LU "(m^{2})))+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0.1), limits=c(0, 12.5),breaks = seq(0, 12, by = 3))+
  theme(legend.position="none")




Threoninelu <- subset(futurefoodsLUbar, (Component=="Threonine (1.05 g)"))
Threoninelu$sderror <- ifelse(Threoninelu$mean==0, NA, Threoninelu$sderror)

luThreonine <- ggplot(Threoninelu, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  labs(y=expression("LU "(m^{2})))+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0.1), limits=c(0, 12),breaks = seq(0, 12, by = 4))+
  theme(legend.position="none")


Tryptophanlu <- subset(futurefoodsLUbar, (Component=="Tryptophan (0.28 g)"))
Tryptophanlu$sderror <- ifelse(Tryptophanlu$mean==0, NA, Tryptophanlu$sderror)

luTryptophan <- ggplot(Tryptophanlu, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  labs(y=expression("LU "(m^{2})))+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol = 2) + 
  theme_classic() + 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  theme(strip.text = element_text(size=10, face="bold", hjust=0))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  ggtitle("") + 
  theme(plot.title=element_text(size=13, face="bold", hjust = 1, vjust=0)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 8, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0, vjust=0.8, margin=margin(t=1,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  theme(legend.position="bottom")+
  coord_cartesian(ylim=c())+
  scale_fill_manual(values=col)+
  scale_color_manual(values=col)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = c(0, 0.1), limits=c(0, 13.5),breaks = seq(0, 13, by = 3))+
  theme(legend.position="none")

###################

#Figure 3

grid.arrange(luprot, luCa, luFe, luZn, luVitA, luVitBdoce, ludha, ncol=3)

averlu <- arrangeGrob(luprot, luCa, luFe, luZn, luVitA, luVitBdoce, ludha, ncol=3) #generates g
#ggsave(file="Figure3.png", width = 25, height = 20, units="cm", dpi=300, averlu) #saves g
#ggsave(file="Figure3.pdf", width = 25, height = 20, units="cm", dpi=300, averlu)


#Supplementary Figure 4
grid.arrange(luLysine, luMethionine, luThreonine, luTryptophan, ncol=2)

averaalu <- arrangeGrob(luLysine, luMethionine, luThreonine, luTryptophan, ncol=2) #generates g

#ggsave(file="Supplementary Figure 4.pdf", width = 18, height = 14.4, units="cm", dpi=300, averaalu)


#Supplementary Figures 2 and 3

extendedlu <- futurefoodsLUbar
extendedghg <- futurefoodsghgbar


extendedlu2 <- subset(extendedlu, (Typefood != "Animal source foods" & Typefood != "Seafood" ))
extendedghg2 <- subset(extendedghg, (Typefood != "Animal source foods" & Typefood != "Seafood" ))




unique(extendedlu2$Component)

extendedlu2$Typefood=factor(extendedlu2$Typefood, levels=c('Future foods',
                                                           'Plant source foods'))




extendedlu2$Species=factor(extendedlu2$Species, levels=c('Cultured meat',
                                                         'Mycoprotein',
                                                         'Chlorella',
                                                         'Spirulina',
                                                         'Sugar kelp',
                                                         'Black soldier fly',
                                                         'Housefly',
                                                         'Mealworm',
                                                         'Mussel',
                                                         'Bean',
                                                         'Wheat',
                                                         'Soybean',
                                                         'Rice',
                                                         'Maize',
                                                         'Almond'))


extendedlu2$Component=factor(extendedlu2$Component, levels=c('Protein (50 g)',
                                                             'Lysine (2.1 g)',
                                                             'Methionine (0.73 g)',
                                                             'Threonine (1.05 g)',
                                                             'Tryptophan (0.28 g)',
                                                             'Ca (1000 mg)', 
                                                             'Fe (14 mg)', 
                                                             'Zn (15 mg)', 
                                                             'Vit. A (800 ug)',
                                                             'Vit. B12 (2.4 ug)',
                                                             'EPA + DHA (250 mg)'))

col5 <- c("#FF9933", "#30C23D", "#0078E3")

extendedghg2$Typefood=factor(extendedghg2$Typefood, levels=c('Future foods',
                                                             'Plant source foods'))




extendedghg2$Species=factor(extendedghg2$Species, levels=c('Cultured meat','Mycoprotein',
                                                           'Chlorella',
                                                           'Spirulina',
                                                           'Sugar kelp',
                                                           'Black soldier fly',
                                                           'Housefly',
                                                           'Mealworm',
                                                           'Mussel',
                                                           'Bean',
                                                           'Wheat',
                                                           'Soybean',
                                                           'Rice',
                                                           'Maize',
                                                           'Almond'))


extendedghg2$Component=factor(extendedghg2$Component, levels=c('Protein (50 g)',
                                                               'Lysine (2.1 g)',
                                                               'Methionine (0.73 g)',
                                                               'Threonine (1.05 g)',
                                                               'Tryptophan (0.28 g)',
                                                               'Ca (1000 mg)', 
                                                               'Fe (14 mg)', 
                                                               'Zn (15 mg)', 
                                                               'Vit. A (800 ug)',
                                                               'Vit. B12 (2.4 ug)',
                                                               'EPA + DHA (250 mg)'))


#Supplementary Figure 2
ggplot(extendedlu2, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  labs(y=expression("LU "(m^{2})))+ 
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol=3) + 
  theme_classic() +
  theme(strip.text = element_text(size=10, hjust=0, face="bold"))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.2))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  ggtitle("") + 
  theme(plot.title=element_text(size=13, hjust = 1, vjust=0.5)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 10, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0.5, vjust=0.8, margin=margin(t=10,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  scale_fill_manual(values=col5)+
  scale_color_manual(values=col5)+
  geom_text(data = subset(extendedlu2, is.nan(mean)),aes(y = 0, label = "*"),  vjust=0.4, hjust=0.5,size=4)+
  geom_text(data = subset(extendedlu2, (Species=="Chlorella" & Component=="Vit. A (800 ug)") | 
                            ((Species=="Mycoprotein" & Component=="EPA + DHA (250 mg)") |
                               Species=="Soybean" & Component=="EPA + DHA (250 mg)")) ,aes(y = 0, label = "ND"),  vjust=0, size=3)+
  theme(legend.position="bottom")+
  scale_y_continuous(expand = expand_scale(c(0, 0.05)))+
  theme(legend.position="none")




#ggsave("Supplementary Figure 2.pdf", width = 18, height = 21, units="cm", dpi=300)


#Supplementary Figure 3

ggplot(extendedghg2, aes(x=Species, y=mean, fill=Typefood)) + 
  geom_bar(stat="identity")+ 
  geom_errorbar(aes(min=mean-sderror, ymax=mean+sderror), width=.3) +
  labs(y=expression(kgCO[2*eq]))+
  xlab("") +
  facet_wrap(~Component, scales="free_y", ncol=3) + 
  theme_classic() +
  theme(strip.text = element_text(size=10, hjust=0, face="bold"))+ 
  theme(panel.grid.major  = element_line(colour = "white", size = 0.1))+ 
  theme(panel.grid.minor  = element_line(colour = "white", size = 0.5))+ 
  theme(strip.background = element_rect(colour="white", fill="white"))+
  ggtitle("") + 
  theme(plot.title=element_text(size=13, hjust = 1, vjust=0.5)) + 
  theme(plot.title = element_text(hjust = 0)) + 
  theme(axis.text.x = element_text(size = 10, face = "plain",  angle = 65, hjust = 1, vjust=1, colour="black", lineheight = 0)) + 
  theme(strip.text.y = element_text(angle = 0)) + 
  theme(strip.background=element_rect(fill="white")) + 
  guides(fill=guide_legend(title=" ")) + 
  theme (plot.caption=element_text(size=8, hjust=0.5, vjust=0.8, margin=margin(t=10,1,10,100))) + 
  theme(axis.title.y = element_text(size=12, face="bold")) + 
  theme(axis.title.x  = element_text(size=14, face="bold"))+ 
  scale_fill_manual(values=col5)+
  scale_color_manual(values=col5)+
  theme(legend.position="bottom")+
  geom_text(data = subset(extendedlu2, is.nan(mean)),aes(y = 0, label = "*"),  vjust=0.4, hjust=0.5,size=4)+
  geom_text(data = subset(extendedlu2, (Species=="Chlorella" & Component=="Vit. A (800 ug)") | 
                            ((Species=="Mycoprotein" & Component=="EPA + DHA (250 mg)") |
                               Species=="Soybean" & Component=="EPA + DHA (250 mg)")) ,aes(y = 0, label = "ND"),  vjust=0, size=3)+
  scale_y_continuous(expand = expand_scale(c(0, 0.05)))+
  theme(legend.position="none")

#ggsave("Supplementary Figure 3.pdf", width = 20, height = 25, units="cm", dpi=300)


