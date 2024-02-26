$Title: Animal module

$ontext
Model Related to publication: Circularity in animal production requires a change in the EAT-Lancet diet in Europe
Author: Ollie van Hal
GHG emission and eat lancet update: Ben van Selm
Date: October 2021

Worknotes:
N1. per total of HerdType means: per herdtype*#animals of herdtype (=#PU * #each HertType/PU)
N2. # PProducer is actually # of pig producer places; #producers =  #PProducer * Producers per year. (needed to calculate with PU composition)
N3. N2 is corrected in model by having Data input and output per producer place per year.
$offtext

*************************************************************************
*---------------------------SET DECLARATION-----------------------------*
*************************************************************************

SET
EU28                                     EU28 Countries
                                         /Austria,Belgium,Bulgaria,Croatia,Cyprus,"Czech Republic",Denmark,Estonia,Finland,France,Germany,Greece,
                                          Hungary,Ireland,Italy,Latvia,Lithuania,Luxembourg,Malta,Netherlands,Poland,Portugal,Romania,Slovakia,
                                          Slovenia,Spain,Sweden,"United Kingdom"/
Products                                 All Products (CropCo Waste Grazing FishByProd AniBy CropMain)
                                         /Wheat_bran,Wheat_germ,Wheat_feedmeal,Barley_byprod,Barley_rootlet,Brewers_grain_spend,Maize_bran,
                                          Maize_germ_meal,Rye_bran,Oat_offals,Oat_hulls,Rice_hulls,Rice_bran_meal,Cereal_other_bran,Potato_peel,
                                          Sweetpotato_peel,Cassava_peels,Cassava_pomace,Cassava_whey,Cassava_stumps,Cassava_effluent,Sugarcane_tops,
                                          Sugarcane_molasses,Sugarcane_bergasse,Sugarcane_filtercake,Sugarbeet_toptails,Sugarbeet_molasses,
                                          Sugarbeet_pulp,Soyabean_hulls,Soyabean_meal,Groundnut_shells,Groundnut_meal,Sunflowerseed_hulls,
                                          Sunflowerseed_meal,Rapeseed_meal,Cottonseed_meal,Copra_meal,Coconut_waste,Sesameseed_meal,Palm_fiber,
                                          Palm_EFB,Palm_shell,Palm_effluent,Palm_kernel_meal,Olive_residue,Oilcrop_other_meal,Citrus_pulp,Grape_pomace,
                                          Grape_stems,Coffee_husk,Cocoa_husk,Waste,FMeatR,FMeatC,FOil,FMeal,Milk,Eggs,MeatC,MeatR,OffalC,OffalR,
                                          PigBoneMeal,PoultryBoneMeal,RuminantBoneMeal,PBlMeal,BBlMeal,BeefMBMeal,Carcass,FCGrease,PigMBMeal,Lard,Plasma,Tallow,
                                          PoultryByMeal,PoultryFeMeal,LW,SalmonMeal,SalmonOil,TilapiaMeal,TilapiaOil
                                          Wheat_flour,Barley_pearl,Maize_flour,Maize_germ_oil,Rye_flour,Oat_rolled,Rice_milled,Rice_bran_oil,Cereal_other_flour,Potato_peeled,Sweetpotato_peeled,Yams,Cassava_tapioca,Tuber_other,Sugar_refined,Beans,Peas,Pulses_other,Nuts_shelled,Copra,Soyabean,Soyabean_oil,Groundnut_shelled,Sunflowerseed,Sunflowerseed_oil,Rapeseed,Rapeseed_oil,Cottonseed,Cottonseed_oil,Coconut_oil,Sesameseed,Sesameseed_oil,Groundnut_oil,Palm_oil,
                                          Palm_kernel_oil,Olive,Olive_oil,Oilcrop_other_oil,Oilcrop_other,Tomato,Onion,Vegetable_other,Orange_mandarin,Lemon_lime,Grapefruit,Citrus_other,Banana,Plantain,Apple,Date,Fruit_other
                                          Fish,FishSalmon,FishTilapia,FishHerring,FishCod,FishWhiting,FishMackerel,FishSprat,FishHaddock,FishPollock,FishPlaice,FishHake,FishHorseMackerel,
                                          FishSandeels,FishPilchard,FishNorwayPout,FishNorwayLobster,FishNorthernPrawn,FishLing
                                          MeatPig,MeatBeef,MeatPoultry,Grass,Silage,Hay,Managed_HQ,Managed_MQ,Managed_LQ,Natural_HQ,Natural_MQ,Natural_LQ,Shrub_HQ,Shrub_MQ,Shrub_LQ/
FishProd(Products)                       Fish products (Main & By)
                                         /FMeatR,FMeatC,FOil,FMeal/
FSlaughterOut(FishProd)                  Fish slaugther output
                                         /FMeatR,FOil,FMeal/
FishByProd(FishProd)                     Fish by-products
                                         /FOil,FMeal/
EdFishProd(FishProd)                     Edible Fish output
                                         /FMeatC/
FishSpecies                              Considered fisheries species
                                         /Atlantic_herring,Atlantic_cod,Blue_whiting,Atlantic_mackerel,European_sprat,Haddock,Pollock,
                                          European_plaice,European_hake,Atlantic_horse_mackerel,Sandeels,European_pilchard,
                                          Norway_pout,Norway_lobster,Northern_prawn,Ling/
APS                                      Animal production systems
                                         /Pig,Dairy,Beef,Broiler,Layer,Salmon,Tilapia/
Mono(APS)                                Monogastric production systems
                                         /Pig,Broiler,Layer,Salmon,Tilapia/
Rumi(APS)                                Ruminant production systems
                                         /Dairy,Beef/
Poultry(APS)                             Poultry Production Systems
                                         /Broiler,Layer/
AquaCulture(APS)                         Aquaculture Production Systems
                                         /Salmon,Tilapia/
Level                                    Animal Productivity levels
                                         /High,Mid,Low/
APSLevel(APS,Level)                      Level included vor each APS
                                         /Pig.High,Pig.Mid,Pig.Low,Dairy.High,Dairy.Mid,Dairy.Low,Beef.High,Beef.Mid,Beef.Low,Broiler.High,Broiler.Mid,
                                         Broiler.Low,Layer.High,Layer.Mid,Layer.Low,Salmon.High,Tilapia.High/
HerdTypes                                Components of PU's
                                         /Sow,Boar,Suckler,Rep_Sow,PProducer,
                                          DBull,DRep_Calf,DRep_Heifer,VealCalf,DProducer,
                                          BBull,BBreeder,BRep_Calf,BRep_Heifer,BProducer,
                                          BrBreederCock,BrBreeder,BrRep_Breeder,BrProducer,
                                          LBreederCock,LCock,LBreeder,LRep_Breeder,LRep_Producer,LProducer,
                                          SBroodMale,SBroodFemale,SAlevin,SFry,SParr,SSmolt,SProducer,
                                          TBroodMale,TBroodFemale,TSwimupFry,TFry,TFingerling,TJuvenile,TProducer/
Producers(HerdTypes)                     Subset of production animals
                                         /PProducer,DProducer,BProducer,BrProducer,LProducer,SProducer,TProducer/
Producer(APS,HerdTypes)                   Producer herdtypes linked to APS
                                         /Pig.PProducer,Dairy.DProducer,Beef.BProducer,Broiler.BrProducer,Layer.LProducer,Salmon.SProducer,Tilapia.TProducer /
APSHerdType(APS,HerdTypes)               Herdcomponent of each APS
                                         /Pig.Sow,Pig.Suckler,Pig.Boar,Pig.Rep_Sow,Pig.PProducer,
                                          Dairy.DBull,Dairy.DRep_Calf,Dairy.DRep_Heifer,Dairy.VealCalf,Dairy.DProducer,
                                          Beef.BBull,Beef.BBreeder,Beef.BRep_Calf,Beef.BRep_Heifer,Beef.BProducer,
                                          Broiler.BrBreederCock,Broiler.BrBreeder,Broiler.BrRep_Breeder,Broiler.BrProducer,
                                          Layer.LBreederCock,Layer.LCock,Layer.LBreeder,Layer.LRep_Breeder,Layer.LRep_Producer,Layer.LProducer
                                          Salmon.SBroodMale,Salmon.SBroodFemale,Salmon.SAlevin,Salmon.SFry,Salmon.SParr,Salmon.SSmolt,Salmon.SProducer
                                          Tilapia.TBroodMale,Tilapia.TBroodFemale,Tilapia.TSwimupFry,Tilapia.TFry,Tilapia.TFingerling,Tilapia.TJuvenile,Tilapia.TProducer/
AniProd(Products)                        Animal Products (Main & By)
                                         /Milk,Eggs,MeatC,MeatR,OffalC,OffalR,PigBoneMeal,PoultryBoneMeal,RuminantBoneMeal,PBlMeal,BBlMeal,BeefMBMeal,Carcass,FCGrease,PigMBMeal,
                                          Lard,Plasma,Tallow,PoultryByMeal,PoultryFeMeal,LW,SalmonMeal,SalmonOil,TilapiaMeal,TilapiaOil/
EdAniProd(Products)                      Edible Animal products
                                         /Milk,Eggs,MeatC,OffalC/
MilkEggs(Products)                       MilkEggs
                                         /Milk,Eggs/
AniByProd(Products)                      Animal by-products
                                         /PigBoneMeal,PoultryBoneMeal,RuminantBoneMeal,PBlMeal,BBlMeal,BeefMBMeal,FCGrease,PigMBMeal,Lard,Plasma,Tallow,
                                          PoultryByMeal,PoultryFeMeal,SalmonMeal,SalmonOil,TilapiaMeal,TilapiaOil/
NoFeedPigs(AniByProd)                    Not allowed for Pigs
                                         /PoultryByMeal,PigBoneMeal,PigMBMeal,Plasma,Lard,PBlMeal,BBlMeal,BeefMBMeal/
NoFeedPoultry(AniByProd)                 Not allowed for Poultry
                                         /PoultryByMeal,PoultryBoneMeal,PigMBMeal,Plasma,BBlMeal,BeefMBMeal/
NoFeedRumi(AniByProd)                    Not allowed for Rumi
                                         /PigMBMeal,PBlMeal,BBlMeal,BeefMBMeal,Plasma,PoultryFeMeal,PoultryByMeal,TilapiaMeal,SalmonMeal,Tallow/
NoFeedTilapia(AniByProd)                 Not allowed for Tilapia
                                         /TilapiaMeal,TilapiaOil,BBlMeal,BeefMBMeal/
NoFeedSalmon(AniByProd)                  Not allowed for Salmon
                                         /BBlMeal,BeefMBMeal/
SlaughterOut(AniProd)                    Slaughter output
                                         /Carcass,OffalR,PBlMeal,BBlMeal,BeefMBMeal,FCGrease,PigMBMeal,Lard,Plasma,Tallow,PoultryByMeal,PoultryFeMeal,
                                         SalmonMeal,SalmonOil,TilapiaMeal,TilapiaOil/
CuttingOut(AniProd)                      Cutting output
                                         /PigBoneMeal,PoultryBoneMeal,RuminantBoneMeal,MeatR/
CookingOut(AniProd)                      Cooking output
                                         /MeatC,OffalC/
APSEdOut(APS,EdAniProd)                  Products of each APS
                                         /Pig.MeatC,Pig.OffalC,Dairy.MeatC,Dairy.OffalC,Dairy.Milk,Beef.MeatC,Beef.OffalC,Broiler.MeatC,
                                          Broiler.OffalC,Layer.MeatC,Layer.OffalC,Layer.Eggs,Salmon.MeatC,Tilapia.MeatC/
NutrOut                                  Nutrient output
                                         /Protein,Fat,Energy,VitA,VitD,VitB12,Calcium,Selenium,Iron,Zinc,ALA,EPA,DPA,DHA/
NutrientOpt(NutrOut)                     Nutrient output optimised
                                         /Protein/
CropCoProd(Products)                     Crop co-products for feed
                                         /Wheat_bran,Wheat_germ,Wheat_feedmeal,Barley_byprod,Barley_rootlet,Brewers_grain_spend,Maize_bran,Maize_germ_meal,Rye_bran,
                                          Oat_offals,Oat_hulls,Rice_hulls,Rice_bran_meal,Cereal_other_bran,Potato_peel,Sweetpotato_peel,Cassava_peels,Cassava_pomace,
                                          Cassava_whey,Cassava_stumps,Cassava_effluent,Sugarcane_tops,Sugarcane_molasses,Sugarcane_bergasse,Sugarcane_filtercake,
                                          Sugarbeet_toptails,Sugarbeet_molasses,Sugarbeet_pulp,Soyabean_hulls,Soyabean_meal,Groundnut_shells,Groundnut_meal,Sunflowerseed_hulls,
                                          Sunflowerseed_meal,Rapeseed_meal,Cottonseed_meal,Copra_meal,Coconut_waste,Sesameseed_meal,Palm_fiber,Palm_EFB,Palm_shell,
                                          Palm_effluent,Palm_kernel_meal,Olive_residue,Oilcrop_other_meal,Citrus_pulp,Grape_pomace,Grape_stems,Coffee_husk,Cocoa_husk/
FoodProd(Products)                       Crop main products for food
                                         /Wheat_flour,Barley_pearl,Maize_flour,Maize_germ_oil,Rye_flour,Oat_rolled,Rice_milled,Rice_bran_oil,Cereal_other_flour,Potato_peeled,Sweetpotato_peeled,Yams,Cassava_tapioca,Tuber_other,Sugar_refined,Beans,Peas,Pulses_other,Nuts_shelled,Copra,Soyabean,Soyabean_oil,Groundnut_shelled,Sunflowerseed,Sunflowerseed_oil,Rapeseed,Rapeseed_oil,Cottonseed,Cottonseed_oil,Coconut_oil,Sesameseed,Sesameseed_oil,Groundnut_oil,Palm_oil,
                                          Palm_kernel_oil,Olive,Olive_oil,Oilcrop_other_oil,Oilcrop_other,Tomato,Onion,Vegetable_other,Orange_mandarin,Lemon_lime,Grapefruit,Citrus_other,Banana,Plantain,Apple,Date,Fruit_other/
WasteProd(Products)                      Waste products feed
                                         /Waste/
GrassProd(Products)                      Grass crop products
                                         /Grass,Silage,hay/
FreshGrass(GrassProd)                    Grazed pasture products
                                         /Grass/
ConsvGrass(GrassProd)                    Conserved grass products
                                         /Silage,hay/
GrassType(Products)                      Grass types
                                         /Managed_HQ,Managed_MQ,Managed_LQ/
GrazingManaged(GrassType)                Managed grazing
                                         /Managed_HQ,Managed_MQ,Managed_LQ/
GrassTypeProd(GrassType,GrassProd)       Grazing products from each grass type
                                         /Managed_HQ.Grass,Managed_HQ.Silage,Managed_HQ.Hay,Managed_MQ.Grass,Managed_MQ.Silage,Managed_MQ.Hay,
                                          Managed_LQ.Grass,Managed_LQ.Silage,Managed_LQ.Hay/
FeedProd(Products)                       Feedingredients
                                         /Wheat_bran,Wheat_germ,Wheat_feedmeal,Barley_byprod,Barley_rootlet,Brewers_grain_spend,Maize_bran,Maize_germ_meal,Rye_bran,
                                          Oat_offals,Oat_hulls,Rice_hulls,Rice_bran_meal,Cereal_other_bran,Potato_peel,Sweetpotato_peel,Cassava_peels,Cassava_pomace,
                                          Cassava_whey,Cassava_stumps,Cassava_effluent,Sugarcane_tops,Sugarcane_molasses,Sugarcane_bergasse,Sugarcane_filtercake,
                                          Sugarbeet_toptails,Sugarbeet_molasses,Sugarbeet_pulp,Soyabean_hulls,Soyabean_meal,Groundnut_shells,Groundnut_meal,Sunflowerseed_hulls,
                                          Sunflowerseed_meal,Rapeseed_meal,Cottonseed_meal,Copra_meal,Coconut_waste,Sesameseed_meal,Palm_fiber,Palm_EFB,Palm_shell,
                                          Palm_effluent,Palm_kernel_meal,Olive_residue,Oilcrop_other_meal,Citrus_pulp,Grape_pomace,Grape_stems,Coffee_husk,Cocoa_husk,
                                          FOil,FMeal,PigBoneMeal,PoultryBoneMeal,RuminantBoneMeal,PBlMeal,BBlMeal,BeefMBMeal,FCGrease,PigMBMeal,Lard,Plasma,Tallow,PoultryByMeal,PoultryFeMeal,
                                          SalmonMeal,SalmonOil,TilapiaMeal,TilapiaOil,waste,Grass,Silage,Hay/
Nutrients                                Nutrients available in products
                                         /DMtoFM,FMtoDM,NEP,DVLysP,DVMetP,VEM,VEVI,DVE,OEB,VW,SW,OEBr,DVLysBr,DVMetBr,OEL,DVLysL,DVMetL,CP,DES,DPS,DET,DPT,Fat,N3,N,P,GrassProdtoGrassType,ASH,CFAT,NFE,DDCP,BDCP,DDOM,BDOM,PDCP,PDOM,LDCP,LDNFE,LDCFAT,BrDCP,BrDNFE,BrDCFAT,GE/
NutrReq(Nutrients)                       Nutrients required to meed feed demands
                                         /NEP,DVLysP,DVMetP,VEM,VEVI,DVE,OEB,OEBr,DVLysBr,DVMetBr,OEL,DVLysL,DVMetL,CP,DES,DPS,DET,DPT/
AnimalNutrients(APS,NutrReq)             Nutrients required by each APS
                                         /Pig.NEP,Pig.DVLysP,Pig.DVMetP,Dairy.VEM,Dairy.DVE,Dairy.OEB,Beef.VEM,Beef.VEVI,Beef.DVE,Beef.OEB,
                                          Broiler.OEBr,Broiler.DVLysBr,Broiler.DVMetBr,Broiler.OEL,Broiler.DVLysL,Broiler.DVMetL
                                          Layer.OEL,Layer.DVLysL,Layer.DVMetL,Salmon.DES,Salmon.DPS,Tilapia.DET,Tilapia.DPT/
NPK(Nutrients)                           Nutrients in manure
                                         /N,P/
FeedFunction                             Feed classes based on function
                                         /Cereal,"Oil Seed Meal",Pulp,Roughage,Molasses,Waste,"Animal Fat","Animal Protein","Fish Oil","Fish Meal",Grass,Silage,Hay/
CerealFeed(Products)                     /Wheat_bran,Wheat_germ,Wheat_feedmeal,Barley_byprod,Barley_rootlet,Brewers_grain_spend,Maize_bran,Rye_bran,
                                          Oat_offals,Cereal_other_bran/
OilSeedFeed(Products)                    /Rice_bran_meal,Maize_germ_meal,Soyabean_meal,Groundnut_meal,Sunflowerseed_meal,Rapeseed_meal,Cottonseed_meal,Copra_meal,Olive_residue,Sesameseed_meal,Palm_effluent,Palm_kernel_meal,Oilcrop_other_meal/
PulpFeed(Products)                       /Sugarbeet_pulp,Citrus_pulp,Grape_pomace,Potato_peel,Sweetpotato_peel/
RoughageFeed(Products)                   /Oat_hulls,Rice_hulls,Sugarbeet_toptails,Soyabean_hulls,Groundnut_shells,Sunflowerseed_hulls,Coffee_husk,Cocoa_husk,Palm_fiber/
MolassesFeed(Products)                   /Sugarbeet_molasses/
FishOilFeed(Products)                    /FOil,SalmonOil,TilapiaOil/
FishMealFeed(Products)                   /FMeal,SalmonMeal,TilapiaMeal/
AniFatFeed(Products)                     /FCGrease,Lard,Tallow/
AniProtFeed(Products)                    /PigBoneMeal,PoultryBoneMeal,RuminantBoneMeal,PBlMeal,BBlMeal,BeefMBMeal,PigMBMeal,PoultryByMeal,PoultryFeMeal,Plasma/
WasteFeed(Products)                      /Waste/
Grass(Products)                          /Grass/
Silage(Products)                         /Silage/
Hay(Products)                            /Hay/
Managed_HQ(Products)                     /Managed_HQ/
FeedOrigin                               Feed classes based on origin
                                         /Cereal,Oilseed,Pulp,Roughage,Molasses,Waste,Grass,Silage,Hay,Managed_HQ,Managed_MQ,Managed_LQ,Fisheries,Pig,Poultry,Cattle,Salmon,Tilapia/
CerealBy(Products)                       /Wheat_bran,Wheat_germ,Wheat_feedmeal,Barley_byprod,Barley_rootlet,Brewers_grain_spend,Maize_bran,Rye_bran,
                                          Oat_offals,Cereal_other_bran/
PulpBy(Products)                         /Sugarbeet_pulp,Citrus_pulp,Grape_pomace,Potato_peel,Sweetpotato_peel/
MolassesBy(Products)                     /Sugarbeet_molasses/
PigBy(Products)                          /FCGrease,Lard,PigBoneMeal,PigMBMeal,PBlMeal,Plasma/
PoultryBy(Products)                      /PoultryBoneMeal,PoultryByMeal,PoultryFeMeal/
CattleBy(Products)                       /Tallow,RuminantBoneMeal,BBlMeal,BeefMBMeal/
SalmonBy(Products)                       /SalmonMeal,SalmonOil/
TilapiaBy(Products)                      /TilapiaMeal,TilapiaOil/
*You could add the other classes later
FoodType                                 Food classes based on type
                                         /Cereal,Tuber,Sweets,Legumes,NutSeed,Oil,VegFruit,Beverage,Milk,Eggs,Meat,Offal,Fish/
MeatFood(Products)                       /MeatPig,MeatBeef,MeatPoultry/
FishFood(Products)                       /FishSalmon,FishTilapia,FishHerring,FishCod,FishWhiting,FishMackerel,FishSprat,FishHaddock,FishPollock,
                                          FishPlaice,FishHake,FishHorseMackerel,FishSandeels,FishPilchard,
                                          FishNorwayPout,FishNorwayLobster,FishNorthernPrawn,FishLing/
DCoefficients                            Digestability coefficients
                                         /DCP,DOM,DNFE,DCFAT/
EFMM                                     Manure Management EF's
                                         /MCFMM,B0,EF1,EF2,Frac1/
EFGrass                                  Grassland EF's
                                         /MCFGR,B0G,EF3,EF4,EF5,EF6,EF7,FracSN,FracM,FracLe/
FertTypes                                Types of fertilisers
                                         /Manure,Artificial/
ELmme                                    Meat Milk Eggs Eat-Lancet
                                         /MeatEL,MilkEL,EggsEL/
EdAniProdEL(ELmme,EdAniProd)             Eat-Lancet MME linked to MME model
                                         /MilkEL.Milk,EggsEL.Eggs,MeatEL.MeatC,MeatEL.OffalC/
AnimalEL                                 Animal systems Eat-lancet
                                         /Pig,Cattle,Poultry,Fish/
APSEL(AnimalEL,APS)                      Animal systems eat-lancet linked to animal systems model
                                         /Pig.Pig,Cattle.Dairy,Cattle.Beef,Poultry.Broiler,Poultry.Layer,Fish.Salmon,Fish.Tilapia/
AniELEdAniProdEL(AnimalEL,ELmme)         Animal systems eat-lancet linked to MME eat-lancet
                                         /Pig.MeatEL,Cattle.MeatEL,Cattle.MilkEL,Poultry.MeatEL,Poultry.EggsEL,Fish.MeatEL/
ASFMinMax                                Min-Max ASF intake
                                         /Min,Max/
Losses                                   Types of losses
                                         /FeedingLosses,ProcessingLosses,ConsumptionLosses/
HML                                      High Mid Low
                                         /High,Mid,Low/
Scenario                                 Scenarios to run           
                                         /Potential,RefinedGrain,WholeGrain/
;
ALIAS (EdAniProd,EdAniProd2);
ALIAS (APS,APS2);
ALIAS (Level,Level2);
ALIAS (HerdTypes,HerdTypes1);
ALIAS (EU28,EU282);
ALIAS (FreshGrass,FreshGrass2)

*************************************************************************
*--------------------SCENARIO DECLARATION/SELECTION---------------------*
*************************************************************************
*S1 Waste utilisation
$setglobal WasteUtilization "0.35"

*S2 Grazing Distribution
SET GrassQualityScenarios                /Miterra,Erb,Plutzar,MiterraHigh,MiterraMed,MiterraLow/;
*$setglobal DistributionGrazing           "MiterraHigh"
*$setglobal DistributionGrazing           "MiterraMed"
*$setglobal DistributionGrazing           "MiterraLow"
$setglobal DistributionGrazing           "Miterra"
*$setglobal DistributionGrazing          "Plutzar"
*$setglobal DistributionGrazing          "Erb"

*S3 Fisheries landings
SET LandingScenarios                     /FCurrent,FMSYShort,FMSYLong,FExclude/;
$setglobal FisheriesLanding              "FMSYShort"

*S4 Fish feed-food allocation
SET FishFoodScenario                    /FAct,FExt,FOpti/;
$setglobal FishFeedFood                 "FOpti"

*S5 Emission level
*$Setglobal Emissions "High"
$Setglobal Emissions "Mid"
*$Setglobal Emissions "Low"

$iftheni %Emissions% == "High" ;
$SetGlobal EmissionLevel                         "High";
$SetGlobal MethaneLevel                          "0.075";
$elseifi %Emissions% == "Low";
$SetGlobal EmissionLevel                         "Low";
$SetGlobal MethaneLevel                          "0.055";
$else;
$SetGlobal EmissionLevel                         "Mid";
$SetGlobal MethaneLevel                          "0.065";
$endif
;

*************************************************************************
*------------------DATA UPLOAD; DECLARATION OF PARAMETERS---------------*
*************************************************************************

PARAMETERS
MilkEggHerdType          (APS,Level,HerdTypes,MilkEggs)                  Milk&egg output per HerdComponent*APS*Level [kg.Herdtype]
LWHerdType               (APS,Level,HerdTypes)                           Lifeweight(LW) output per HerdComponent*APS*Level [kgLW.Herdtype]
SlaughterFrac            (APS,Level,HerdTypes,SlaughterOut)              Fraction LW allocated to each slaugther output for each animal APS*Level
CuttingFrac              (APS,CuttingOut)                                Fraction Carcas allocated to each cutting output for each animal APS
NutrContEdAniProd        (APS,Level,EdAniProd,NutrOut)                   Nutrient content of each edible animal product [Nutrient.kg cookedAniProd]
Landings                 (FishSpecies,LandingScenarios)                  Fish landed of each species in EU ocean in each scenario [Tonne.species]
FSlaugther               (FishSpecies,FishFoodScenario,FSlaughterOut)    Fraction of landed fish allocated to each Fslaugther output (per species) under each feed-food allocation scenario
NutrContEdFishProd       (FishSpecies,EdFishProd,NutrOut)                Nutrient content of each edible Fish product [Nutrient.kg cookedfish]
GrazingDM                (EU28,GrassQualityScenarios,GrassType)          Amount of grazingproduct available in LQ MQ or HQ in each distribution scenario [tonne DM country]
LossFraction             (Products,losses)                               Loss fractions in different stages [%]
HerdTypesPerPU           (APS,Level,HerdTypes)                           #HerdTypes per producer for each each APS*Level
ProducersPerYear         (APS,Level)                                     #Producer production rounds per year
CastoffFed               (APS)                                           correction for castoff fed for producers
Duration                 (APS,Level,HerdTypes)                           Duration lifecycle period (365 producer as inputoutput defined per producer place per year)
NutrReqHerdType          (APS,Level,HerdTypes,Nutrients)                 MIN Nutrient intake Herdtype*APS*Level
IntakeCapHerdType        (APS,Level,HerdTypes)                           MAX feed mass (intake capacity) herdtype*APS*Level
VWCapHerdType            (APS,Level,HerdTypes)                           MAX VW Herdtype*Ruminant*Level
SWreqHerdType            (APS,Level,HerdTypes)                           MIN SW Herdtype*Ruminant*Level
MaxFat                   (APS)                                           MAX Fat APS
Population               (EU28)                                          Population size [#inhabitants*EU28]
NutrientDMAniBy          (AniByProd,Nutrients)                           Nutrients in animal by-product for each animal APS [Nutrient.kg AniByProd]
NutrientDMFishByProd     (FishSpecies,FishByProd,Nutrients)              Nutrients in fisheries by-products for each animal APS [Nutrient.kg FishByProd]
NutrientDMCropCo         (Products,Nutrients)                            Nutrients in CropCoProd for each animal APS [Nutrient.kg CropProd]
NutrientGrazingProd      (GrassType,GrassProd,Nutrients)                 Nutrients in GrazingProd for each ruminant [Nutrient.kg GrazingProd]
ProdAvailableFMEL        (EU28,Products)                                 Product available based on eat-lancet diet refiend grain [tonnes country]
ProdAvailableFMELWhole   (EU28,Products)                                 Product available based on eat-Lancet diet whole grains [tonnes country]
NutrientDMWaste          (EU28,WasteProd,Nutrients)                      Nutrient content per kg DM of waste [nutrient per kg DM]
WasteAvailableFM         (EU28,WasteProd)                                Nutrient content of waste [nutrient per kg FM]
NutrientsRetained        (APS,Level,HerdTypes,NPK)                       Nutrients retained in meat milk eggs [kg per animal or place]
EFHousingImport          (EU28,HerdTypes,HML,EFMM)                       Emission factors for manure management
EFGrazingImport          (EU28,HML,EFGrass)                              Emission factors for grassland
GrasslandYieldSen        (EU28,GrassQualityScenarios,GrassType)          Grassland yield [kg DM ha]
Fert                     (NPK,EU28,GrassType)                            Fertiliser application rates of grassland [kg per hectare]
ASFCompEL                (AnimalEL,ASFMinMax,ELmme)                      Composition of animal-sourced food in the eat-lancet diet [g per capita per day]
GrazingProportion        (EU28)                                          Proportion of grazing occuring [proportion of year]
CH4                                                                      CO2e biogenic methane value                    /28/
N2O                                                                      CO2e nitrous oxide value                       /265/
e                                                                        Prevents division by 0 error                   /0.00001/
;

$onecho > options.tmp
input= ModelData.xlsx output= ModelData.gdx
par=MilkEggHerdType              rng=MilkEggHerdType!A1          cdim=1  rdim=3
par=LWHerdType                   rng=LWHerdtype!A2                       rdim=3
par=SlaughterFrac                rng=SlaughterFrac!A1            cdim=1  rdim=3
par=CuttingFrac                  rng=CuttingFrac!A1              cdim=1  rdim=1
par=NutrContEdAniProd            rng=NutrContEdAniProd!A1        cdim=1  rdim=3
par=NutrientDMAniBy              rng=NutrientDMAniBy!A1          cdim=1  rdim=1
par=Landings                     rng=Landings!A1                 cdim=1  rdim=1
par=FSlaugther                   rng=FSlaugther!A1               cdim=2  rdim=1
par=NutrContEdFishProd           rng=NutrContEdFishProd!A1       rdim=2  cdim=1
par=NutrientDMFishByProd         rng=NutrientDMFishBy!A1         cdim=1  rdim=2
par=NutrientDMCropCo             rng=NutrientDMCropCo!A1         cdim=1  rdim=1
par=GrazingDM                    rng=GrazingDistribution!A1      cdim=2  rdim=1
par=NutrientGrazingProd          rng=GrazingNutrient!A1          cdim=1  rdim=2
par=LossFraction                 rng=LossFraction!A1             cdim=1  rdim=1
par=HerdTypesPerPU               rng=HerdTypesPerPU!A2                   rdim=3
par=ProducersPerYear             rng=ProducersPerYear!A2                 rdim=2
par=Duration                     rng=Duration!A2                         rdim=3
par=CastoffFed                   rng=Castoff!A2                          rdim=1
par=NutrReqHerdType              rng=NutrReqHerdType!A1          cdim=1  rdim=3
par=IntakeCapHerdType            rng=IntakeCapHerdType!A2                rdim=3
par=VWCapHerdType                rng=VWCapHerdType!A2                    rdim=3
par=SWreqHerdType                rng=SWreqHerdType!A2                    rdim=3
par=MaxFat                       rng=MaxFat!A2                           rdim=1
par=Population                   rng=Population!A2                       rdim=1
par=EFHousingImport              rng=EFHousing!A1                cdim=2 rdim=2
par=EFGrazingImport              rng=EFGrazing!A1                cdim=2 rdim=1
par=Fert                         rng=GrasslandFert!A1            cdim=1 rdim=2
par=ProdAvailableFMEL            rng=CropCoAvailableFMEL!A1      cdim=1 rdim=1
par=ProdAvailableFMELWhole       rng=CropCoAvailableFMELWhole!A1 cdim=1 rdim=1
par=NutrientsRetained            rng=NPHerdType!A1               cdim=1 rdim=3
par=GrasslandYieldSen            rng=GrasslandYield!A1           cdim=2 rdim=1
par=ASFCompEL                    rng=ASFCompEL!A1                cdim=2 rdim=1
par=GrazingProportion            rng=GrazingDays!A1                     rdim=1
$offecho

$Call GDXXRW.EXE @options.tmp
$GDXIN ModelData.gdx
$LOAD MilkEggHerdType LWHerdType SlaughterFrac CuttingFrac NutrContEdAniProd NutrientDMAniBy Landings FSlaugther NutrContEdFishProd NutrientDMFishByProd NutrientDMCropCo 
$LOAD GrazingDM NutrientGrazingProd ProdAvailableFMEL ProdAvailableFMELWhole LossFraction HerdTypesPerPU ProducersPerYear CastoffFed  GrasslandYieldSen  ASFCompEL GrazingProportion
$LOAD Duration NutrReqHerdType IntakeCapHerdType VWCapHerdType SWreqHerdType MaxFat Population NutrientsRetained Fert EFHousingImport EFGrazingImport 
$GDXIN

*************************************************************************
*------------------PARAMETER DECLARATION/CALCULATION--------------------*
*************************************************************************
PARAMETERS
SlaugtherOutHerdType     (APS,Level,HerdTypes,SlaughterOut)              SlaughterOutput per HerdType*APS*Level [kg SlaughterOut.HerdType]
CuttingOutHerdType       (APS,Level,HerdTypes,CuttingOut)                CuttingOutput per HerdType*APS*Level [kg CuttingOut.HerdType]
CookingOutHerdType       (APS,Level,HerdTypes,CookingOut)                CookingOutput per HerdType*APS*Level [kg MeatC.HerdType]
EdAniProdHerdType        (APS,Level,HerdTypes,EdAniProd)                 Edible animal output HerdType*APS*Level [kg EdAniProd.HerdType]
AniByProdHerdType        (APS,Level,HerdTypes,AniByProd)                 AniByOutput HerdType*APS*Level [kg AniByProd.HerdType]
LandingsAvailable        (FishSpecies)                                   Fish landed in EU ocean in the selected scenario [Tonne FM.Species]
FSlaugtherFrac           (FishSpecies,FSlaughterOut)                     Fraction of landed fish allocated to each Fslaugther output in selected feed-food allocation scenario [.Species]
FSlaugtherOutput         (FishSpecies,FSlaughterOut)                     Slaughter outputs per FishSpecies [Tonne FSlaughterOut.Species]
FOutput           (FishSpecies,EdFishProd)                               FMeatC per fish species [Tonne FMeatC.species]
FishByProdProd           (FishSpecies,FishByProd)                        Fish by-product output [Tonne FishByProd.species]
AniNutrOutHerdType       (APS,Level,HerdTypes,EdAniProd,NutrOut)         Nutrient output HerdTypes {ProdOut(kg) * nutrient content (?!?.kg) = [?!? NutrOut.HerdTypes]
AniOptOutHerdType        (APS,Level,HerdTypes,EdAniProd,NutrientOpt)     Above optimised nutrient = [?!? NutrOut.HerdTypes]
CropCoAvailableFMEU      (CropCoProd)                                    CropCoProd available in the whole EU28 [Tonne FM]
GrazingAvailableDM       (EU28,GrassType)                                GrazingProd available in the selected distribytion scenario [TonneDM.cntr]
FICHerdType              (APS,Level,HerdTypes)                           MAX feed mass (intake capacity) herdtype*APS*Level
N3OutHerdType            (APS,Level,HerdTypes,EdAniProd)
CalOutHerdType           (APS,Level,HerdTypes,EdAniProd)
B12OutHerdType           (APS,Level,HerdTypes,EdAniProd)
GrasslandYield           (EU28,GrassType)
CropCoAvailableFMEU      (CropCoProd)
CropCoAvailableFMEUCap   (CropCoProd)
EFHousing                (EU28,HerdTypes,EFMM)
EFGrazing                (EU28,EFGrass)
;
**//Slaughter and cutting outputs per Fish and Livestock\\**
SlaugtherOutHerdType(APS,Level,HerdTypes,SlaughterOut)   = LWHerdType(APS,Level,HerdTypes) * SlaughterFrac(APS,Level,HerdTypes,SlaughterOut);
CuttingOutHerdType(APS,Level,HerdTypes,CuttingOut)       = SlaugtherOutHerdType(APS,Level,HerdTypes,"Carcass") * CuttingFrac(APS,CuttingOut);
CookingOutHerdType(APS,Level,HerdTypes,"MeatC")          = CuttingOutHerdType(APS,Level,HerdTypes,"MeatR");
CookingOutHerdType(APS,Level,HerdTypes,"OffalC")         = SlaugtherOutHerdType(APS,Level,HerdTypes,"OffalR");

EdAniProdHerdType(APS,Level,HerdTypes,"MeatC")           = CookingOutHerdType(APS,Level,HerdTypes,"MeatC");
EdAniProdHerdType(APS,Level,HerdTypes,"OffalC")          = CookingOutHerdType(APS,Level,HerdTypes,"OffalC");
EdAniProdHerdType(APS,Level,HerdTypes,"Milk")            = MilkEggHerdType(APS,Level,HerdTypes,"Milk");
EdAniProdHerdType(APS,Level,HerdTypes,"Eggs")            = MilkEggHerdType(APS,Level,HerdTypes,"Eggs");

AniByProdHerdType(APS,Level,HerdTypes,"PigBoneMeal")     = CuttingOutHerdType(APS,Level,HerdTypes,"PigBoneMeal");
AniByProdHerdType(APS,Level,HerdTypes,"PoultryBoneMeal") = CuttingOutHerdType(APS,Level,HerdTypes,"PoultryBoneMeal");
AniByProdHerdType(APS,Level,HerdTypes,"RuminantBoneMeal")= CuttingOutHerdType(APS,Level,HerdTypes,"RuminantBoneMeal");
AniByProdHerdType(APS,Level,HerdTypes,"PBlMeal")         = SlaugtherOutHerdType(APS,Level,HerdTypes,"PBlMeal");
AniByProdHerdType(APS,Level,HerdTypes,"BBlMeal")         = SlaugtherOutHerdType(APS,Level,HerdTypes,"BBlMeal");
AniByProdHerdType(APS,Level,HerdTypes,"FCGrease")        = SlaugtherOutHerdType(APS,Level,HerdTypes,"FCGrease");
AniByProdHerdType(APS,Level,HerdTypes,"PigMBMeal")       = SlaugtherOutHerdType(APS,Level,HerdTypes,"PigMBMeal");
AniByProdHerdType(APS,Level,HerdTypes,"Lard")            = SlaugtherOutHerdType(APS,Level,HerdTypes,"Lard");
AniByProdHerdType(APS,Level,HerdTypes,"Plasma")          = SlaugtherOutHerdType(APS,Level,HerdTypes,"Plasma");
AniByProdHerdType(APS,Level,HerdTypes,"Tallow")          = SlaugtherOutHerdType(APS,Level,HerdTypes,"Tallow");
AniByProdHerdType(APS,Level,HerdTypes,"BeefMBMeal")      = SlaugtherOutHerdType(APS,Level,HerdTypes,"BeefMBMeal");
AniByProdHerdType(APS,Level,HerdTypes,"PoultryByMeal")   = SlaugtherOutHerdType(APS,Level,HerdTypes,"PoultryByMeal");
AniByProdHerdType(APS,Level,HerdTypes,"PoultryFeMeal")   = SlaugtherOutHerdType(APS,Level,HerdTypes,"PoultryFeMeal");
AniByProdHerdType(APS,Level,HerdTypes,"SalmonMeal")      = SlaugtherOutHerdType(APS,Level,HerdTypes,"SalmonMeal");
AniByProdHerdType(APS,Level,HerdTypes,"SalmonOil")       = SlaugtherOutHerdType(APS,Level,HerdTypes,"SalmonOil");
AniByProdHerdType(APS,Level,HerdTypes,"TilapiaMeal")     = SlaugtherOutHerdType(APS,Level,HerdTypes,"TilapiaMeal");
AniByProdHerdType(APS,Level,HerdTypes,"TilapiaOil")      = SlaugtherOutHerdType(APS,Level,HerdTypes,"TilapiaOil");

LandingsAvailable(FishSpecies)                           = (Landings(FishSpecies,"%FisheriesLanding%") / 507806470) * SUM(EU28, Population(EU28));
FSlaugtherFrac(FishSpecies,FSlaughterOut)                = FSlaugther(FishSpecies,"%FishFeedFood%",FSlaughterOut);
FSlaugtherOutput(FishSpecies,FSlaughterOut)              = LandingsAvailable(FishSpecies)* FSlaugtherFrac(FishSpecies,FSlaughterOut);
FOutput(FishSpecies,EdFishProd)                          = FSlaugtherOutput(FishSpecies,"FMeatR");
FishByProdProd(FishSpecies,"FOil")                       = FSlaugtherOutput(FishSpecies,"FOil") ;
FishByProdProd(FishSpecies,"FMeal")                      = FSlaugtherOutput(FishSpecies,"FMeal") ;

AniNutrOutHerdType(APS,Level,HerdTypes,EdAniProd,NutrOut)$(APSHerdType(APS,HerdTypes) and APSEdOut(APS,EdAniProd))
         = EdAniProdHerdType(APS,Level,HerdTypes,EdAniProd) * NutrContEdAniProd(APS,Level,EdAniProd,NutrOut);
AniOptOutHerdType(APS,Level,HerdTypes,EdAniProd,NutrientOpt)$(APSHerdType(APS,HerdTypes) and APSEdOut(APS,EdAniProd))
         = EdAniProdHerdType(APS,Level,HerdTypes,EdAniProd) * NutrContEdAniProd(APS,Level,EdAniProd,NutrientOpt);
N3OutHerdType(APS,Level,HerdTypes,EdAniProd)$(APSHerdType(APS,HerdTypes) and APSEdOut(APS,EdAniProd))
         = EdAniProdHerdType(APS,Level,HerdTypes,EdAniProd) * (NutrContEdAniProd(APS,Level,EdAniProd,"EPA") + NutrContEdAniProd(APS,Level,EdAniProd,"DHA"));
CalOutHerdType(APS,Level,HerdTypes,EdAniProd)$(APSHerdType(APS,HerdTypes) and APSEdOut(APS,EdAniProd))
         = EdAniProdHerdType(APS,Level,HerdTypes,EdAniProd) * NutrContEdAniProd(APS,Level,EdAniProd,"Calcium");
B12OutHerdType(APS,Level,HerdTypes,EdAniProd)$(APSHerdType(APS,HerdTypes) and APSEdOut(APS,EdAniProd))
         = EdAniProdHerdType(APS,Level,HerdTypes,EdAniProd) * NutrContEdAniProd(APS,Level,EdAniProd,"VitB12");

GrazingAvailableDM(EU28,GrassType)       = GrazingDM(EU28,"%DistributionGrazing%",GrassType);
GrasslandYield(EU28,GrassType)           = GrasslandYieldSen(EU28,"%DistributionGrazing%",GrassType);
FICHerdType(APS,Level,HerdTypes)         = IntakeCapHerdType(APS,Level,HerdTypes);
FICHerdType(AquaCulture,Level,HerdTypes) = IntakeCapHerdType(AquaCulture,Level,HerdTypes);

EFHousing(EU28,HerdTypes,EFMM) = EFHousingImport(EU28,HerdTypes,"%EmissionLevel%",EFMM);
EFGrazing(EU28,EFGrass) = EFGrazingImport(EU28,"%EmissionLevel%",EFGrass) ;
;
**//Waste calculations\\**




*************************************************************************
*-------------------------VARIABLE DECLARATION--------------------------*
*************************************************************************

VARIABLES
vAniOptOutTotal                                                                      Total Animal Protein output
vFertArt                         (EU28,Rumi,Level,HerdTypes,NPK)
;
POSITIVE VARIABLES
vNumHerdType                     (EU28,APS,Level,HerdTypes)                          Number of animals of each herdtype
vCropCoIntakeHerdTypekgDM        (EU28,APS,Level,HerdTypes,CropCoProd)               CropCo intake by total of each HerdType in kg DM (excluding feedlosses)
vGrazingIntakeHerdTypekgDM       (EU28,APS,Level,HerdTypes,GrassType,GrassProd)      Grazing intake by total of each HerdType in kg DM (excluding feedlosses)
vWasteIntakeHerdTypekgDM         (EU28,APS,Level,HerdTypes,WasteProd)                Waste intake by total of each HerdType in kg DM (excluding feedlosses)
vFishIntakeHerdTypekgDM          (EU28,APS,Level,HerdTypes,FishSpecies,FishByProd)   Fish by product intake (meal-oil species) by total of each HerdType in kg DM (excluding feedlosses)
vAniByIntakeHerdTypekgDM         (EU28,APS,Level,HerdTypes,AniByProd)                Animal by product intake  by total of each HerdType in kg DM (excluding feedlosses)
vVWintakeRumi                    (EU28,Rumi,Level,HerdTypes)                         Total Summed VW intake of Rumi

vNPKRet                          (EU28,APS,Level,HerdTypes,NPK)                      Total nutrients retained in meat milk eggs
vNPKRetGrazing                   (EU28,Rumi,Level,HerdTypes,NPK)                     Nutrients retained in meat milk eggs from grazing products
vNPKEx                           (EU28,APS,Level,HerdTypes,NPK)                      Total nutrients excreted
vNPKEXGrazing                    (EU28,Rumi,Level,HerdTypes,NPK)                     Nutrients excreted in manure management
vNPKExMM                         (EU28,APS,Level,HerdTypes,NPK)
vVSMM                            (EU28,APS,Level,HerdTypes)                          Nutrients excreted while grazing
vVSRumi                          (EU28,Rumi,Level,HerdTypes)
vVSGrazing                       (EU28,APS,Level,HerdTypes)                          Volatile solid excretion in manure management
vCH4Manure                       (EU28,APS,Level)                                    Volatile solid excretion during grazing
vCH4Enteric                      (EU28,APS,Level)                                    Ch4 emissions enteric fermentation
vCH4                             (EU28,APS,Level)                                    Total CH4 emissions

vN2ONMM                          (EU28,APS,Level,HerdTypes)                          N2O emissions from manure management
vN2ODeNitr                       (EU28,APS,Level,HerdTypes)
vGrasslandha                     (EU28,Rumi,Level,HerdTypes,GrassType)
vN2ONGrasslandD                  (EU28,Rumi,Level,HerdTypes)                         Direct N2O emissions from grassland
vN2ONGrasslandID                 (EU28,Rumi,Level,HerdTypes)                         Indirect N2O emissions from grassland
vN2ONGrassland                   (EU28,APS,Level,HerdTypes)                          Grassland N2O emission total
vN2O                             (EU28,APS,Level)                                    Total N2O emissions
vProcessing                      (EU28,APS,Level)                                    Processing emissions of feed
vCO2eq                           (EU28,APS,Level)                                    CO2 equivalent emissions of animal sourced food
vCO2eqAnimalMin
vCO2eqAnimal                     (EU28)
vCO2eqTotal                      (EU28)                                              Total emissions from plant and animal sourced food
vProOutput                       (APS,Level,HerdTypes,EdAniProd)
vProOutputCapD                   (APS,EdAniProd)
vASFGroup                        (AnimalEL,ELmme)

;
*************************************************************************
*-----------------EQUATION DECLARATION/IMPLEMENTATION-------------------*
*************************************************************************

*----1. OBJECTIVE FUNCTION----*
*E1 Maximise Protein output (optimised nutrient) {sum of nutrient output in each country,APS,Level,product}
EQUATION eAniNutOptTotal;
         eAniNutOptTotal..
         vAniOptOutTotal
         =E= SUM((EU28,APS,Level,EdAniProd,HerdTypes,NutrientOpt),
             (AniOptOutHerdType(APS,Level,HerdTypes,EdAniProd,NutrientOpt)
             * vNumHerdType(EU28,APS,Level,HerdTypes))
               $APSHerdType(APS,HerdTypes)$APSLevel(APS,Level))
;
*----2. HERD COMPOSITION----*
*E2 Occurence of each HerdType matches the Herdcomposition {#HerdType = HerdType per producer * #HerdType 'producer'}
EQUATION eNumHerdType ;
         eNumHerdType(EU28,APS,Level,HerdTypes)$((APSHerdType(APS,HerdTypes) AND APSLevel(APS,Level)) and not Producer(APS,HerdTypes))..
         vNumHerdType(EU28,APS,Level,HerdTypes) =e= sum(HerdTypes1$Producer(APS,HerdTypes1),vNumHerdType(EU28,APS,Level,HerdTypes1)) * HerdTypesPerPU(APS,Level,HerdTypes)
;
*----3. FEED AVAILABILITY----*
*E3 Availability FeedProd > consumption + losses in countries summed {SUM intake /Herdtype*APS*Level * 1-lossfraction /1000 = ton} [Ton DM]
EQUATION eRestrictionCropCoAvailable;
         eRestrictionCropCoAvailable(CropCoProd)..
         CropCoAvailableFMEU(CropCoProd) * NutrientDMCropCo(CropCoProd,'FMtoDM')
         =G= SUM((EU28,APS,Level,HerdTypes),vCropCoIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,CropCoProd)
             $(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level))
                 / (1- LossFraction(CropCoProd,'FeedingLosses')))/1000
;
EQUATION eRestrictionWasteAvailable;
         eRestrictionWasteAvailable(EU28,WasteProd)..
         WasteAvailableFM(EU28,WasteProd) * (NutrientDMWaste(EU28,WasteProd,'FMtoDM'))
         =G= SUM((APS,Level,HerdTypes),vWasteIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,WasteProd)
             $(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level))
                 / (1- LossFraction(WasteProd,'FeedingLosses')))/1000
;
EQUATION eRestrictionGrazingAvailable;
         eRestrictionGrazingAvailable(EU28,GrassType)..
         GrazingAvailableDM(EU28,GrassType)
         =G= SUM((APS,Level,HerdTypes,GrassProd),vGrazingIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,GrassType,GrassProd) * NutrientGrazingProd(GrassType,GrassProd,'GrassProdtoGrassType')
             $(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level) and GrassTypeProd(GrassType,GrassProd))
                 / (1- LossFraction(GrassProd,'FeedingLosses')))/1000
;
EQUATION eRestrictionFishAvailable;
         eRestrictionFishAvailable(FishSpecies,FishByProd)..
         FishByProdProd(FishSpecies,FishByProd) * NutrientDMFishByProd(FishSpecies,FishByProd,'FMtoDM')
         =G= SUM((EU28,APS,Level,HerdTypes),vFishIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,FishSpecies,FishByProd)
             $(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level))
                 / (1-0.02))/1000
;
EQUATION eRestrictionAniByAvailable;
         eRestrictionAniByAvailable(AniByProd)..
         SUM((EU28,APS,Level,HerdTypes),AniByProdHerdType(APS,Level,HerdTypes,AniByProd)
                 * vNumHerdType(EU28,APS,Level,HerdTypes) * NutrientDMAniBy(AniByProd,'FMtoDM')
                   $(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level)))
                   =G= SUM((EU28,APS,Level,HerdTypes),
                   vAniByIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,AniByProd)
                   $(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level))
                         / (1- LossFraction(AniByProd,'FeedingLosses')))
;
*----4. NUTRIENT REQUIREMENTS----*
*E4 Total product intake of a herdtype fulfils nutrient requirment of herdtype
EQUATION eNutrReqTHerdTypeMet;
         eNutrReqTHerdTypeMet(EU28,APS,Level,HerdTypes,NutrReq)$(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level) and AnimalNutrients(APS,NutrReq))..
           SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,CropCoProd)                             * NutrientDMCropCo(CropCoProd,NutrReq))
         + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,WasteProd)                                * NutrientDMWaste(EU28,WasteProd,NutrReq))
         + SUM((GrassType,GrassProd),vGrazingIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,GrassType,GrassProd)        * NutrientGrazingProd(GrassType,GrassProd,NutrReq))
         + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,FishSpecies,FishByProd)     * NutrientDMFishByProd(FishSpecies,FishByProd,NutrReq))
         + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,AniByProd)                                * NutrientDMAniBy(AniByProd,NutrReq))
         =G= NutrReqHerdType(APS,Level,HerdTypes,NutrReq) * vNumHerdType(EU28,APS,Level,HerdTypes)
;
*E4.2
EQUATION eN3Salmon;
         eN3Salmon(EU28,"Salmon",Level,HerdTypes)$(APSLevel("Salmon",Level) and APSHerdType("Salmon",HerdTypes))..
           SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,"Salmon",Level,HerdTypes,CropCoProd)                           * NutrientDMCropCo(CropCoProd,'N3') )
         + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,"Salmon",Level,HerdTypes,WasteProd)                              * NutrientDMWaste(EU28,WasteProd,'N3'))
         + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,"Salmon",Level,HerdTypes,FishSpecies,FishByProd)   * NutrientDMFishByProd(FishSpecies,FishByProd,'N3'))
         + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,"Salmon",Level,HerdTypes,AniByProd)                              * NutrientDMAniBy(AniByProd,'N3'))
         =G= ( SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,"Salmon",Level,HerdTypes,CropCoProd))
             + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,"Salmon",Level,HerdTypes,WasteProd))
             + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,"Salmon",Level,HerdTypes,FishSpecies,FishByProd))
             + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,"Salmon",Level,HerdTypes,AniByProd))) * 0.025
;
*----5. FEED INTAKE CAPACITY (FIC) ----*
*E5.1 Total FM intake /herdtype*APS*Level < FIC
EQUATION eMaxFeedIntake;
         eMaxFeedIntake(EU28,Mono,Level,HerdTypes)$(APSHerdType(Mono,HerdTypes) and APSLevel(Mono,Level))..
           SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,Mono,Level,HerdTypes,CropCoProd)                         * NutrientDMCropCo(CropCoProd,'DMtoFM'))
         + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,Mono,Level,HerdTypes,WasteProd)                            *(NutrientDMWaste(EU28,WasteProd,'DMtoFM')))
         + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,Mono,Level,HerdTypes,FishSpecies,FishByProd) * NutrientDMFishByProd(FishSpecies,FishByProd,'DMtoFM'))
         + SUM(AniByProd,(vAniByIntakeHerdTypekgDM(EU28,Mono,Level,HerdTypes,AniByProd)                           * NutrientDMAniBy(AniByProd,'DMtoFM')))
         =L= (vNumHerdType(EU28,Mono,Level,HerdTypes) * FICHerdType(Mono,Level,HerdTypes))
;
*E5.2 Total VW intkake by each Ruminant,Herdtype {DM intake (Sum over products)* VW per kg DM}
EQUATION eVWintakeRumi;
         eVWintakeRumi(EU28,Rumi,Level,HerdTypes)$(APSHerdType(Rumi,HerdTypes) and APSLevel(Rumi,Level))..
         vVWintakeRumi(EU28,Rumi,Level,HerdTypes)
         =E= SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,CropCoProd)                          * NutrientDMCropCo(CropCoProd,'VW'))
           + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,WasteProd)                             * NutrientDMWaste(EU28,WasteProd,'VW'))
           + SUM((GrassType,GrassProd),vGrazingIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,GrassType,GrassProd)     * NutrientGrazingProd(GrassType,GrassProd,'VW'))
           + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,FishSpecies,FishByProd)  * NutrientDMFishByProd(FishSpecies,FishByProd,'VW'))
           + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,AniByProd)                             * NutrientDMAniBy(AniByProd,'VW'))
;
*E5.3 Total feed intake capacity (VW) of each Ruminant,Herdtypee is higher than total feed intake (VW) by each Ruminant,Herdtype
EQUATION eMaxVWIntake;
         eMaxVWIntake(EU28,Rumi,Level,HerdTypes)$(APSHerdType(Rumi,HerdTypes) and APSLevel(Rumi,Level))..
         (vNumHerdType(EU28,Rumi,Level,HerdTypes)
         * VWCapHerdType(Rumi,Level,HerdTypes))
         =G= vVWintakeRumi(EU28,Rumi,Level,HerdTypes)
;
*----6. STRUCTURE REQUIREMENTS Rumi (SW)----*
*E6 Average SW of the ration (SW/kgDM) /ruminant herdtype is larger than required SW value
EQUATION eReqSWIntake;
         eReqSWIntake(EU28,Rumi,Level,HerdTypes)$(APSHerdType(Rumi,HerdTypes) and APSLevel(Rumi,Level))..
           SUM(CropCoProd,(vCropCoIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,CropCoProd)                           * NutrientDMCropCo(CropCoProd,'SW')))
         + SUM(WasteProd,(vWasteIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,WasteProd)                              * NutrientDMWaste(EU28,WasteProd,'SW')))
         + SUM((GrassType,GrassProd),(vGrazingIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,GrassType,GrassProd)      * NutrientGrazingProd(GrassType,GrassProd,'SW')))
         + SUM(AniByProd,(vAniByIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,AniByProd)                              * NutrientDMAniBy(AniByProd,'SW')))
         + SUM((FishSpecies,FishByProd),(vFishIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,FishSpecies,FishByProd)   * NutrientDMFishByProd(FishSpecies,FishByProd,'SW')))
         =G= ( SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,CropCoProd))
             + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,WasteProd))
             + SUM((GrassType,GrassProd),vGrazingIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,GrassType,GrassProd))
             + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,FishSpecies,FishByProd))
             + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,AniByProd)))
             * SWreqHerdType(Rumi,Level,HerdTypes)
;
*Fat limitation Ruminants:
EQUATION eFatMax;
         eFatMax(EU28,Rumi,Level,HerdTypes)$(APSLevel(Rumi,Level) and APSHerdType(Rumi,HerdTypes))..
           SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,CropCoProd)                             * NutrientDMCropCo(CropCoProd,'Fat'))
         + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,WasteProd)                                * NutrientDMWaste(EU28,WasteProd,'Fat'))
         + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,FishSpecies,FishByProd)     * NutrientDMFishByProd(FishSpecies,FishByProd,'Fat'))
         + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,AniByProd)                                * NutrientDMAniBy(AniByProd,'Fat') )
         =L= ( SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,CropCoProd))
             + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,WasteProd))
             + SUM((GrassType,GrassProd),vGrazingIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,GrassType,GrassProd))
             + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,FishSpecies,FishByProd))
             + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,AniByProd)))
             * MaxFat(Rumi)
;
*----7. Feed legislations ----*
*E7 Each APS is not allowed consume NoFeed (products legally banned as feed)
EQUATION eNoFeedRumi;
         eNoFeedRumi(EU28,Rumi,Level,HerdTypes,NoFeedRumi)$(APSHerdType(Rumi,HerdTypes) and APSLevel(Rumi,Level))..
         vAniByIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,NoFeedRumi)          =E= 0;
EQUATION eNoFeedRumiWaste;
         eNoFeedRumiWaste(EU28,Rumi,Level,HerdTypes,WasteProd)$(APSHerdType(Rumi,HerdTypes) and APSLevel(Rumi,Level))..
         vWasteIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,WasteProd)         =E= 0;
EQUATION eNoFeedPig;
         eNoFeedPig(EU28,'Pig',Level,HerdTypes,NoFeedPigs)$(APSHerdType('Pig',HerdTypes) and APSLevel('Pig',Level))..
         vAniByIntakeHerdTypekgDM(EU28,'Pig',Level,HerdTypes,NoFeedPigs)         =E= 0;
EQUATION eNoFeedPoultry;
         eNoFeedPoultry(EU28,Poultry,Level,HerdTypes,NoFeedPoultry)$(APSHerdType(Poultry,HerdTypes) and APSLevel(Poultry,Level))..
         vAniByIntakeHerdTypekgDM(EU28,Poultry,Level,HerdTypes,NoFeedPoultry)    =E= 0;
EQUATION eNoFeedTilapia;
         eNoFeedTilapia(EU28,'Tilapia',Level,HerdTypes,NoFeedTilapia)$(APSHerdType('Tilapia',HerdTypes) and APSLevel('Tilapia',Level))..
         vAniByIntakeHerdTypekgDM(EU28,'Tilapia',Level,HerdTypes,NoFeedTilapia)  =E= 0;
EQUATION eNoFeedSalmon;
         eNoFeedSalmon (EU28,'Salmon',Level,HerdTypes,NoFeedSalmon)$(APSHerdType('Salmon',HerdTypes)and APSLevel('Salmon',Level))..
         vAniByIntakeHerdTypekgDM(EU28,'Salmon',Level,HerdTypes,NoFeedSalmon)    =E= 0;



*----8. Grazing limits
*Grazing limit based on protein
EQUATION eGrazingLimitDVE;
         eGrazingLimitDVE(EU28,Rumi,Level,HerdTypes)..
         SUM((GrassType,FreshGrass)$ GrassTypeProd(GrassType,FreshGrass),
                 vGrazingIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,GrassType,FreshGrass) * NutrientGrazingProd(GrassType,FreshGrass,'DVE')) =E=
                 NutrReqHerdType(Rumi,level,HerdTypes,'DVE') * vNumHerdType(EU28,Rumi,level,HerdTypes) * GrazingProportion(EU28)
;
*Number of ha of grassland
EQUATION eGrasslandha;
         eGrasslandha(EU28,Rumi,Level,HerdTypes,GrassType)$(APSHerdType(Rumi,HerdTypes) and APSLevel(Rumi,Level))..
         vGrasslandha(EU28,Rumi,Level,HerdTypes,GrassType) =E=
                 SUM((GrassProd)$GrassTypeProd(GrassType,GrassProd),vGrazingIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,GrassType,GrassProd)
                 * NutrientGrazingProd(GrassType,GrassProd,'GrassProdtoGrassType') /(1- LossFraction(GrassProd,'FeedingLosses'))) / ((GrasslandYield(EU28,GrassType)+e) * 1000)
;

*----8. Manure excretion----*
*N & P retained in meat/milk/eggs (kg/kg)
EQUATION eNPKRet;
         eNPKRet(EU28,APS,Level,HerdTypes,NPK)$(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level))..
         vNPKRet(EU28,APS,Level,HerdTypes,NPK) =E=
                 NutrientsRetained(APS,Level,HerdTypes,NPK) * vNumHerdType(EU28,APS,Level,HerdTypes)
;
*N & P retained from the consumption of grazing products (kg/kg)
EQUATION eNPKRetGrazing;
         eNPKRetGrazing(EU28,Rumi,Level,HerdTypes,NPK)$(APSHerdType(Rumi,HerdTypes) and APSLevel(Rumi,Level))..
         vNPKRetGrazing(EU28,Rumi,Level,HerdTypes,NPK) =E=
                 vNPKRet(EU28,Rumi,Level,HerdTypes,NPK) * GrazingProportion(EU28)
;
*N & P excreted (kg/kg)
EQUATION eNPKEx;
         eNPKEx(EU28,APS,Level,HerdTypes,NPK)$(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level))..
         vNPKEx(EU28,APS,Level,HerdTypes,NPK) =E=
                 SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,CropCoProd)                             * (NutrientDMCropCo(CropCoProd,NPK)/1000))
               + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,WasteProd)                                * (NutrientDMWaste(EU28,WasteProd,NPK)/1000))
               + SUM((GrassType,GrassProd),vGrazingIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,GrassType,GrassProd)        * (NutrientGrazingProd(GrassType,GrassProd,NPK)/1000))
               + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,FishSpecies,FishByProd)     * (NutrientDMFishByProd(FishSpecies,FishByProd,NPK)/1000))
               + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,APS,Level,HerdTypes,AniByProd)                                * (NutrientDMAniBy(AniByProd,NPK)/1000))
               - vNPKRet(EU28,APS,Level,HerdTypes,NPK)
;
*N & P excreted during grazing (kg/kg)
EQUATION eNPKExGrazing;
         eNPKExGrazing(EU28,Rumi,Level,HerdTypes,NPK)$(APSHerdType(Rumi,HerdTypes) and APSLevel(Rumi,Level))..
         vNPKEXGrazing(EU28,Rumi,Level,HerdTypes,NPK) =E=
                 vNPKEx(EU28,Rumi,Level,HerdTypes,NPK) * GrazingProportion(EU28)
;
*N & P excreted by ruminants in a housing system (kg/kg)
EQUATION eNPKExMMR;
         eNPKExMMR(EU28,Rumi,Level,HerdTypes,NPK)$(APSHerdType(Rumi,HerdTypes) and APSLevel(Rumi,Level))..
         vNPKExMM(EU28,Rumi,Level,HerdTypes,NPK) =E=
                 vNPKEx(EU28,Rumi,Level,HerdTypes,NPK) * (1 - GrazingProportion(EU28))
;
*N & P excreted by monogastrics in a housing system (kg/kg)
EQUATION eNPKExMMM;
         eNPKExMMM(EU28,Mono,Level,HerdTypes,NPK)$(APSHerdType(Mono,HerdTypes) and APSLevel(Mono,Level))..
         vNPKExMM(EU28,Mono,Level,HerdTypes,NPK) =E=
                 vNPKEx(EU28,Mono,Level,HerdTypes,NPK)
;

*---- 9. Methane Equations ----*
*Volatile solid excretion equations (kg/kg)
EQUATION eVSPig;
         eVSPig(EU28,'Pig',Level,HerdTypes)$(APSHerdType('Pig',HerdTypes) and APSLevel('Pig',Level))..
         vVSMM(EU28,'Pig',Level,HerdTypes) =E=
             ((((SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,'Pig',Level,HerdTypes,CropCoProd)                             * NutrientDMCropCo(CropCoProd,'CP')                                 * NutrientDMCropCo(CropCoProd,'PDCP')                   /100)/6.25
               + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,'Pig',Level,HerdTypes,WasteProd)                                * NutrientDMWaste(EU28,WasteProd,'CP')                              * NutrientDMWaste(EU28,WasteProd,'PDCP')                /100)/6.25
               + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,'Pig',Level,HerdTypes,FishSpecies,FishByProd)     * NutrientDMFishByProd(FishSpecies,FishByProd,'CP')                 * NutrientDMFishByProd(FishSpecies,FishByProd,'PDCP')   /100)/6.25
               + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,'Pig',Level,HerdTypes,AniByProd)                                * NutrientDMAniBy(AniByProd,'CP')                                   * NutrientDMAniBy(AniByProd,'PDCP')                     /100)/6.25) - vNPKRet(EU28,'Pig',Level,HerdTypes,'N')*1000) * 28/60)

               + SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,'Pig',Level,HerdTypes,CropCoProd)                             * ((1000 - NutrientDMCropCo(CropCoProd,'ASH'))                       - ((1000 - NutrientDMCropCo(CropCoProd,'ASH'))                 * NutrientDMCropCo(CropCoProd,'PDOM')                   /100)))
               + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,'Pig',Level,HerdTypes,WasteProd)                                * ((1000 - NutrientDMWaste(EU28,WasteProd,'ASH'))                    - ((1000 - NutrientDMWaste(EU28,WasteProd,'ASH'))              * NutrientDMWaste(EU28,WasteProd,'PDOM')                /100)))
               + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,'Pig',Level,HerdTypes,FishSpecies,FishByProd)     * ((1000 - NutrientDMFishByProd(FishSpecies,FishByProd,'ASH'))       - ((1000 - NutrientDMFishByProd(FishSpecies,FishByProd,'ASH')) * NutrientDMFishByProd(FishSpecies,FishByProd,'PDOM')   /100)))
               + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,'Pig',Level,HerdTypes,AniByProd)                                * ((1000 - NutrientDMAniBy(AniByProd,'ASH'))                         - ((1000 - NutrientDMAniBy(AniByProd,'ASH'))                   * NutrientDMAniBy(AniByProd,'PDOM')                     /100))))/1000
;
EQUATION eVSBroiler;
         eVSBroiler(EU28,'Broiler',Level,HerdTypes)$(APSHerdType('Broiler',HerdTypes) and APSLevel('Broiler',Level))..
         vVSMM(EU28,'Broiler',Level,HerdTypes) =E=
             ((((SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,'Broiler',Level,HerdTypes,CropCoProd)                             * NutrientDMCropCo(CropCoProd,'CP')                                 * NutrientDMCropCo(CropCoProd,'BrDCP')                      /100)/6.25
               + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,'Broiler',Level,HerdTypes,WasteProd)                                * NutrientDMWaste(EU28,WasteProd,'CP')                              * NutrientDMWaste(EU28,WasteProd,'BrDCP')                   /100)/6.25
               + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,'Broiler',Level,HerdTypes,FishSpecies,FishByProd)     * NutrientDMFishByProd(FishSpecies,FishByProd,'CP')                 * NutrientDMFishByProd(FishSpecies,FishByProd,'BrDCP')      /100)/6.25
               + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,'Broiler',Level,HerdTypes,AniByProd)                                * NutrientDMAniBy(AniByProd,'CP')                                   * NutrientDMAniBy(AniByProd,'BrDCP')                        /100)/6.25) - vNPKRet(EU28,'Broiler',Level,HerdTypes,'N')*1000) * 56/168)

               + SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,'Broiler',Level,HerdTypes,CropCoProd)                             * ((1000 - NutrientDMCropCo(CropCoProd,'ASH'))                 - ((NutrientDMCropCo(CropCoProd,'CP')                  * NutrientDMCropCo(CropCoProd,'BrDCP')/100)                 + (NutrientDMCropCo(CropCoProd,'CFAT')    * NutrientDMCropCo(CropCoProd,'BrDCFAT')/100)    + (NutrientDMCropCo(CropCoProd,'NFE')     * NutrientDMCropCo(CropCoProd,'BrDNFE')/100))))
               + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,'Broiler',Level,HerdTypes,WasteProd)                                * ((1000 - NutrientDMWaste(EU28,WasteProd,'ASH'))              - ((NutrientDMWaste(EU28,WasteProd,'CP')               * NutrientDMWaste(EU28,WasteProd,'BrDCP')/100)              + (NutrientDMWaste(EU28,WasteProd,'CFAT') * NutrientDMWaste(EU28,WasteProd,'BrDCFAT')/100) + (NutrientDMWaste(EU28,WasteProd,'NFE')  * NutrientDMWaste(EU28,WasteProd,'BrDNFE')/100))))
               + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,'Broiler',Level,HerdTypes,FishSpecies,FishByProd)     * ((1000 - NutrientDMFishByProd(FishSpecies,FishByProd,'ASH')) - ((NutrientDMFishByProd(FishSpecies,FishByProd,'CP')  * NutrientDMFishByProd(FishSpecies,FishByProd,'BrDCP')/100) + (NutrientDMFishByProd(FishSpecies,FishByProd,'CFAT')  * NutrientDMFishByProd(FishSpecies,FishByProd,'BrDCFAT')/100)
                 + (NutrientDMFishByProd(FishSpecies,FishByProd,'NFE')     * NutrientDMFishByProd(FishSpecies,FishByProd,'BrDNFE')/100))))
               + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,'Broiler',Level,HerdTypes,AniByProd)                                * ((1000 - NutrientDMAniBy(AniByProd,'ASH'))                   - ((NutrientDMAniBy(AniByProd,'CP')                    * NutrientDMAniBy(AniByProd,'BrDCP')/100)                   + (NutrientDMAniBy(AniByProd,'CFAT')     * NutrientDMAniBy(AniByProd,'BrDCFAT')/100)       + (NutrientDMAniBy(AniByProd,'NFE')       * NutrientDMAniBy(AniByProd,'BrDNFE')/100)))))/1000
;

EQUATION eVSLayer;
         eVSLayer(EU28,'Layer',Level,HerdTypes)$(APSHerdType('Layer',HerdTypes) and APSLevel('Layer',Level))..
         vVSMM(EU28,'Layer',Level,HerdTypes) =E=
             ((((SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,'Layer',Level,HerdTypes,CropCoProd)                             * NutrientDMCropCo(CropCoProd,'CP')                                 * NutrientDMCropCo(CropCoProd,'LDCP')                 /100)/6.25
               + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,'Layer',Level,HerdTypes,WasteProd)                                * NutrientDMWaste(EU28,WasteProd,'CP')                              * NutrientDMWaste(EU28,WasteProd,'LDCP')              /100)/6.25
               + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,'Layer',Level,HerdTypes,FishSpecies,FishByProd)     * NutrientDMFishByProd(FishSpecies,FishByProd,'CP')                 * NutrientDMFishByProd(FishSpecies,FishByProd,'LDCP') /100)/6.25
               + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,'Layer',Level,HerdTypes,AniByProd)                                * NutrientDMAniBy(AniByProd,'CP')                                   * NutrientDMAniBy(AniByProd,'LDCP')                   /100)/6.25) - vNPKRet(EU28,'Layer',Level,HerdTypes,'N')*1000)* 56/168)

               + SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,'Layer',Level,HerdTypes,CropCoProd)                             * ((1000 - NutrientDMCropCo(CropCoProd,'ASH'))                 - ((NutrientDMCropCo(CropCoProd,'CP')                 * NutrientDMCropCo(CropCoProd,'LDCP')/100)                 + (NutrientDMCropCo(CropCoProd,'CFAT')    * NutrientDMCropCo(CropCoProd,'LDCFAT')/100)       + (NutrientDMCropCo(CropCoProd,'NFE')    * NutrientDMCropCo(CropCoProd,'LDNFE')/100))))
               + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,'Layer',Level,HerdTypes,WasteProd)                                * ((1000 - NutrientDMWaste(EU28,WasteProd,'ASH'))              - ((NutrientDMWaste(EU28,WasteProd,'CP')              * NutrientDMWaste(EU28,WasteProd,'LDCP')/100)              + (NutrientDMWaste(EU28,WasteProd,'CFAT') * NutrientDMWaste(EU28,WasteProd,'LDCFAT')/100)    + (NutrientDMWaste(EU28,WasteProd,'NFE') * NutrientDMWaste(EU28,WasteProd,'LDNFE')/100))))
               + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,'Layer',Level,HerdTypes,FishSpecies,FishByProd)     * ((1000 - NutrientDMFishByProd(FishSpecies,FishByProd,'ASH')) - ((NutrientDMFishByProd(FishSpecies,FishByProd,'CP') * NutrientDMFishByProd(FishSpecies,FishByProd,'LDCP')/100) + (NutrientDMFishByProd(FishSpecies,FishByProd,'CFAT')  * NutrientDMFishByProd(FishSpecies,FishByProd,'LDCFAT')/100)
                 + (NutrientDMFishByProd(FishSpecies,FishByProd,'NFE')     * NutrientDMFishByProd(FishSpecies,FishByProd,'LDNFE')/100))))
               + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,'Layer',Level,HerdTypes,AniByProd)                                * ((1000 - NutrientDMAniBy(AniByProd,'ASH'))                   - ((NutrientDMAniBy(AniByProd,'CP')                   * NutrientDMAniBy(AniByProd,'LDCP')/100)                   + (NutrientDMAniBy(AniByProd,'CFAT')      * NutrientDMAniBy(AniByProd,'LDCFAT')/100)          + (NutrientDMAniBy(AniByProd,'NFE')      * NutrientDMAniBy(AniByProd,'LDNFE')/100)))))/1000
;

EQUATION eVSDairy;
         eVSDairy(EU28,'Dairy',Level,HerdTypes)$(APSHerdType('Dairy',HerdTypes) and APSLevel('Dairy',Level))..
         vVSRumi(EU28,'Dairy',Level,HerdTypes) =E=
             ((((SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,'Dairy',Level,HerdTypes,CropCoProd)                            * NutrientDMCropCo(CropCoProd,'CP')                            * NutrientDMCropCo(CropCoProd,'DDCP')                          /100)/6.25
               + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,'Dairy',Level,HerdTypes,WasteProd)                               * NutrientDMWaste(EU28,WasteProd,'CP')                         * NutrientDMWaste(EU28,WasteProd,'DDCP')                       /100)/6.25
               + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,'Dairy',Level,HerdTypes,FishSpecies,FishByProd)    * NutrientDMFishByProd(FishSpecies,FishByProd,'CP')            * NutrientDMFishByProd(FishSpecies,FishByProd,'DDCP')          /100)/6.25
               + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,'Dairy',Level,HerdTypes,AniByProd)                               * NutrientDMAniBy(AniByProd,'CP')                              * NutrientDMAniBy(AniByProd,'DDCP')                            /100)/6.25
               + SUM((GrassType,GrassProd),vGrazingIntakeHerdTypekgDM(EU28,'Dairy',Level,HerdTypes,GrassType,GrassProd)       * NutrientGrazingProd(GrassType,GrassProd,'CP')                * NutrientGrazingProd(GrassType,GrassProd,'DDCP')              /100)/6.25) - vNPKRet(EU28,'Dairy',Level,HerdTypes,'N')*1000) * 28/60)

               + SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,'Dairy',Level,HerdTypes,CropCoProd)                            * ((1000 - NutrientDMCropCo(CropCoProd,'ASH'))                 - ((1000 - NutrientDMCropCo(CropCoProd,'ASH'))                 * NutrientDMCropCo(CropCoProd,'DDOM')                  /100)))
               + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,'Dairy',Level,HerdTypes,WasteProd)                               * ((1000 - NutrientDMWaste(EU28,WasteProd,'ASH'))              - ((1000 - NutrientDMWaste(EU28,WasteProd,'ASH'))              * NutrientDMWaste(EU28,WasteProd,'DDOM')               /100)))
               + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,'Dairy',Level,HerdTypes,FishSpecies,FishByProd)    * ((1000 - NutrientDMFishByProd(FishSpecies,FishByProd,'ASH')) - ((1000 - NutrientDMFishByProd(FishSpecies,FishByProd,'ASH')) * NutrientDMFishByProd(FishSpecies,FishByProd,'DDOM')  /100)))
               + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,'Dairy',Level,HerdTypes,AniByProd)                               * ((1000 - NutrientDMAniBy(AniByProd,'ASH'))                   - ((1000 - NutrientDMAniBy(AniByProd,'ASH'))                   * NutrientDMAniBy(AniByProd,'DDOM')                    /100)))
               + SUM((GrassType,GrassProd),vGrazingIntakeHerdTypekgDM(EU28,'Dairy',Level,HerdTypes,GrassType,GrassProd)       * ((1000 - NutrientGrazingProd(GrassType,GrassProd,'ASH'))     - ((1000 - NutrientGrazingProd(GrassType,GrassProd,'ASH'))     * NutrientGrazingProd(GrassType,GrassProd,'DDOM')      /100))))/1000
;
EQUATION eVSBeef;
         eVSBeef(EU28,'Beef',Level,HerdTypes)$(APSHerdType('Beef',HerdTypes) and APSLevel('Beef',Level))..
         vVSRumi(EU28,'Beef',Level,HerdTypes) =E=
             ((((SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,'Beef',Level,HerdTypes,CropCoProd)                             * NutrientDMCropCo(CropCoProd,'CP')                            * NutrientDMCropCo(CropCoProd,'BDCP')                          /100)/6.25
               + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,'Beef',Level,HerdTypes,WasteProd)                                * NutrientDMWaste(EU28,WasteProd,'CP')                         * NutrientDMWaste(EU28,WasteProd,'BDCP')                       /100)/6.25
               + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,'Beef',Level,HerdTypes,FishSpecies,FishByProd)     * NutrientDMFishByProd(FishSpecies,FishByProd,'CP')            * NutrientDMFishByProd(FishSpecies,FishByProd,'BDCP')          /100)/6.25
               + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,'Beef',Level,HerdTypes,AniByProd)                                * NutrientDMAniBy(AniByProd,'CP')                              * NutrientDMAniBy(AniByProd,'BDCP')                            /100)/6.25
               + SUM((GrassType,GrassProd),vGrazingIntakeHerdTypekgDM(EU28,'Beef',Level,HerdTypes,GrassType,GrassProd)        * NutrientGrazingProd(GrassType,GrassProd,'CP')                * NutrientGrazingProd(GrassType,GrassProd,'BDCP')              /100)/6.25) - vNPKRet(EU28,'Beef',Level,HerdTypes,'N')*1000) * 28/60)

               + SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,'Beef',Level,HerdTypes,CropCoProd)                             * ((1000 - NutrientDMCropCo(CropCoProd,'ASH'))                 - ((1000 - NutrientDMCropCo(CropCoProd,'ASH'))                 * NutrientDMCropCo(CropCoProd,'BDOM')                  /100)))
               + SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,'Beef',Level,HerdTypes,WasteProd)                                * ((1000 - NutrientDMWaste(EU28,WasteProd,'ASH'))              - ((1000 - NutrientDMWaste(EU28,WasteProd,'ASH'))              * NutrientDMWaste(EU28,WasteProd,'BDOM')               /100)))
               + SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,'Beef',Level,HerdTypes,FishSpecies,FishByProd)     * ((1000 - NutrientDMFishByProd(FishSpecies,FishByProd,'ASH')) - ((1000 - NutrientDMFishByProd(FishSpecies,FishByProd,'ASH')) * NutrientDMFishByProd(FishSpecies,FishByProd,'BDOM')  /100)))
               + SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,'Beef',Level,HerdTypes,AniByProd)                                * ((1000 - NutrientDMAniBy(AniByProd,'ASH'))                   - ((1000 - NutrientDMAniBy(AniByProd,'ASH'))                   * NutrientDMAniBy(AniByProd,'BDOM')                    /100)))
               + SUM((GrassType,GrassProd),vGrazingIntakeHerdTypekgDM(EU28,'Beef',Level,HerdTypes,GrassType,GrassProd)        * ((1000 - NutrientGrazingProd(GrassType,GrassProd,'ASH'))     - ((1000 - NutrientGrazingProd(GrassType,GrassProd,'ASH'))     * NutrientGrazingProd(GrassType,GrassProd,'BDOM')     /100))))/1000
;
EQUATION eVSDairyGrazing;
         eVSDairyGrazing(EU28,'Dairy',Level,HerdTypes)$(APSHerdType('Dairy',HerdTypes) and APSLevel('Dairy',Level))..
         vVSGrazing(EU28,'Dairy',Level,HerdTypes) =E= vVSRumi(EU28,'Dairy',Level,HerdTypes) * GrazingProportion(EU28)
;
EQUATION eVSBeefGrazing;
         eVSBeefGrazing(EU28,'Beef',Level,HerdTypes)$(APSHerdType('Beef',HerdTypes) and APSLevel('Beef',Level))..
         vVSGrazing(EU28,'Beef',Level,HerdTypes) =E= vVSRumi(EU28,'Beef',Level,HerdTypes) * GrazingProportion(EU28)
;
EQUATION eVSDairyMM;
         eVSDairyMM(EU28,'Dairy',Level,HerdTypes)$(APSHerdType('Dairy',HerdTypes) and APSLevel('Dairy',Level))..
         vVSMM(EU28,'Dairy',Level,HerdTypes) =E= vVSRumi(EU28,'Dairy',Level,HerdTypes) * (1-GrazingProportion(EU28))
;
EQUATION eVSBeefMM;
         eVSBeefMM(EU28,'Beef',Level,HerdTypes)$(APSHerdType('Beef',HerdTypes) and APSLevel('Beef',Level))..
         vVSMM(EU28,'Beef',Level,HerdTypes) =E= vVSRumi(EU28,'Beef',Level,HerdTypes) * (1 - GrazingProportion(EU28))
;
*CH4 from manure (including grassland)
EQUATION eCH4Manure;
         eCH4Manure(EU28,APS,Level)$APSLevel(APS,Level)..
         vCH4Manure(EU28,APS,Level) =E=
                 SUM((HerdTypes)$APSHerdType(APS,HerdTypes),
                         (vVSMM(EU28,APS,Level,HerdTypes)* EFHousing(EU28,HerdTypes,'MCFMM') * EFHousing(EU28,HerdTypes,'B0') * 0.67) +
                         (vVSGrazing(EU28,APS,Level,HerdTypes)* EFGrazing(EU28,'MCFGR') * EFGrazing(EU28,'B0G') * 0.67))
;
*CH4 enteric fermentation
EQUATION eCH4Enteric;
         eCH4Enteric(EU28,Rumi,Level)$APSLevel(Rumi,Level)..
         vCH4Enteric(EU28,Rumi,Level) =E=
                 SUM((HerdTypes)$APSHerdType(Rumi,HerdTypes),
               + (SUM(CropCoProd,vCropCoIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,CropCoProd)                          * NutrientDMCropCo(CropCoProd,'GE')                      * %MethaneLevel%) /55.65)
               + (SUM((GrassType,GrassProd),vGrazingIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,GrassType,GrassProd)     * NutrientGrazingProd(GrassType,GrassProd,'GE')          * %MethaneLevel%) /55.65)
               + (SUM(WasteProd,vWasteIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,WasteProd)                             * NutrientDMWaste(EU28,WasteProd,'GE')                   * %MethaneLevel%) /55.65)
               + (SUM((FishSpecies,FishByProd),vFishIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,FishSpecies,FishByProd)  * NutrientDMFishByProd(FishSpecies,FishByProd,'GE')      * %MethaneLevel%) /55.65)
               + (SUM(AniByProd,vAniByIntakeHerdTypekgDM(EU28,Rumi,Level,HerdTypes,AniByProd)                             * NutrientDMAniBy(AniByProd,'GE')                        * %MethaneLevel%) /55.65))
;

*CH4 total
EQUATION eCH4;
         eCH4(EU28,APS,Level)$APSLevel(APS,Level)..
         vCH4(EU28,APS,Level) =E=
                 vCH4Manure(EU28,APS,Level) + vCH4Enteric(EU28,APS,Level)
;
*---- 10. GHG EQUATIONS: N2O ----*
*N2O emissions from manure management
EQUATION eN2ONMM;
         eN2ONMM(EU28,APS,Level,HerdTypes)$(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level))..
         vN2ONMM(EU28,APS,Level,HerdTypes) =E=
                 ((vNPKExMM(EU28,APS,Level,HerdTypes,'N') * EFHousing(EU28,HerdTypes,'EF1'))
                 + (vNPKExMM(EU28,APS,Level,HerdTypes,'N') * EFHousing(EU28,HerdTypes,'EF2') * EFHousing(EU28,HerdTypes,'Frac1')))
;
EQUATION eN2ONFish(EU28,AquaCulture,Level,HerdTypes) "N2O emissions from aquaciulture";
         eN2ONFish(EU28,AquaCulture,Level,HerdTypes)$(APSHerdType(AquaCulture,HerdTypes) and APSLevel(AquaCulture,Level))..
         vN2ODeNitr(EU28,AquaCulture,Level,HerdTypes) =E=
                  (vNPKEx(EU28,AquaCulture,Level,HerdTypes,'N')                                                           +
                  SUM(CropCoProd, vCropCoIntakeHerdTypekgDM(EU28,AquaCulture,Level,HerdTypes,CropCoProd)                         * (NutrientDMCropCo(CropCoProd,'N')/1000)                      * LossFraction(CropCoProd,'FeedingLosses')) +
                  SUM(WasteProd, vWasteIntakeHerdTypekgDM(EU28,AquaCulture,Level,HerdTypes,WasteProd)                            * (NutrientDMWaste(EU28,WasteProd,'N')/1000)                   * LossFraction(WasteProd,'FeedingLosses'))  +
                  SUM((FishSpecies,FishByProd), vFishIntakeHerdTypekgDM(EU28,AquaCulture,Level,HerdTypes,FishSpecies,FishByProd) * (NutrientDMFishByProd(FishSpecies,FishByProd,'N')/1000)      * 0.02)                                     +
                  SUM(AniByProd, vAniByIntakeHerdTypekgDM(EU28,AquaCulture,Level,HerdTypes,AniByProd)                            * (NutrientDMAniBy(AniByProd,'N')/1000)                        * LossFraction(AniByProd,'FeedingLosses'))) * 0.018

;
*Grassland fertilisation (top-up of artificial fertiliser to meet demands)
EQUATION eGrasslandFert;
         eGrasslandFert(EU28,Rumi,Level,HerdTypes,NPK)$(APSHerdType(Rumi,HerdTypes) and APSLevel(Rumi,Level))..
           SUM(GrassType, vGrasslandha(EU28,Rumi,Level,HerdTypes,GrassType) * Fert(NPK,EU28,GrassType)) =E=
                 (vNPKEXGrazing(EU28,Rumi,Level,HerdTypes,NPK) + vNPKExMM(EU28,Rumi,Level,HerdTypes,NPK) + vFertArt(EU28,Rumi,Level,HerdTypes,NPK))
;
*Direct N2O emissions from grassland
EQUATION eN2ONGrasslandD;
         eN2ONGrasslandD(EU28,Rumi,Level,HerdTypes)$(APSHerdType(Rumi,HerdTypes) and APSLevel(Rumi,Level))..
         vN2ONGrasslandD(EU28,Rumi,Level,HerdTypes) =E=
                 (vNPKEXGrazing(EU28,Rumi,Level,HerdTypes,'N') * EFGrazing(EU28,'EF5')
                         + (vNPKExMM(EU28,Rumi,Level,HerdTypes,'N') - vN2ONMM(EU28,Rumi,Level,HerdTypes)) * EFGrazing(EU28,'EF3')
                                 + vFertArt(EU28,Rumi,Level,HerdTypes,'N') * EFGrazing(EU28,'EF4'))
;
*In direct N2O emissions from grassland
EQUATION eN2ONGrasslandID;
         eN2ONGrasslandID(EU28,Rumi,Level,HerdTypes)$(APSHerdType(Rumi,HerdTypes) and APSLevel(Rumi,Level))..
         vN2ONGrasslandID(EU28,Rumi,Level,HerdTypes) =E=
                 (((vNPKEXGrazing(EU28,Rumi,Level,HerdTypes,'N') * EFGrazing(EU28,'EF6') * EFGrazing(EU28,'FracM'))
                         + ((vNPKExMM(EU28,Rumi,Level,HerdTypes,'N') - vN2ONMM(EU28,Rumi,Level,HerdTypes)) * EFGrazing(EU28,'EF6') * EFGrazing(EU28,'FracM'))
                                 + (vFertArt(EU28,Rumi,Level,HerdTypes,'N') * EFGrazing(EU28,'EF6') * EFGrazing(EU28,'FracSN')))
                                                  + ((vNPKEXGrazing(EU28,Rumi,Level,HerdTypes,'N') + (vNPKExMM(EU28,Rumi,Level,HerdTypes,'N') - vN2ONMM(EU28,Rumi,Level,HerdTypes)) + vFertArt(EU28,Rumi,Level,HerdTypes,'N')) * EFGrazing(EU28,'EF7') * EFGrazing(EU28,'FracLe')))
;
*Total N2O emissions from grassland
EQUATION eN2ONGrassland;
         eN2ONGrassland(EU28,Rumi,Level,HerdTypes)$(APSHerdType(Rumi,HerdTypes) and APSLevel(Rumi,Level))..
         vN2ONGrassland(EU28,Rumi,Level,HerdTypes) =E=
                 vN2ONGrasslandD(Eu28,Rumi,Level,HerdTypes) + vN2ONGrasslandID(Eu28,Rumi,Level,HerdTypes)
;
*Total N2O emissions
EQUATION eN2O;
         eN2O(EU28,APS,Level)$APSLevel(APS,Level)..
         vN2O(EU28,APS,Level) =E=
                 SUM((HerdTypes)$APSHerdType(APS,HerdTypes), vN2ONMM(EU28,APS,Level,HerdTypes) + vN2ONGrassland(EU28,APS,Level,HerdTypes) + vN2ODeNitr(EU28,APS,Level,HerdTypes) ) * 44/28
;
*----12. GHG EQUATIONS: Total ----*

*Total emissions from animal products per country, animal activity and productivity level
EQUATION eCO2eq;
         eCO2eq(EU28,APS,Level)$APSLevel(APS,Level)..
         vCO2eq(EU28,APS,Level) =E=
                 (vN2O(EU28,APS,Level)* N2O) + ((vCH4Manure(EU28,APS,Level) + vCH4Enteric(EU28,APS,Level))* CH4) + vProcessing(EU28,APS,Level)
;
*Total emissions from animal products per country
EQUATION eCO2eqAnimal;
         eCO2eqAnimal(EU28)..
         vCO2eqTotal(EU28) =E=
                 SUM((APS,Level) ,vCO2eq(EU28,APS,Level))
;
*Maximum emissions based on the planetary boundaries frame work (5gt for 9.8 billion people)
EQUATION eCO2eqMax;
         eCO2eqMax..
                 SUM(EU28, vCO2eqTotal(EU28)) =L= SUM(EU28, 511.66 * Population(EU28))
;
*----12. EAT-LANCET diet specifications ----*
EQUATION eProOutput;
         eProOutput(APS,Level,HerdTypes,EdAniProd)$(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level) AND APSEdOut(APS,EdAniProd))..
         vProOutput(APS,Level,HerdTypes,EdAniProd) =E=
                  SUM(EU28, (vNumHerdType(EU28,APS,Level,HerdTypes) * AniNutrOutHerdType(APS,Level,HerdTypes,EdAniProd,'Protein')))
;
EQUATION eProOutputCapD;
         eProOutputCapD(APS,EdAniProd)$APSEdOut(APS,EdAniProd)..
         vProOutputCapD(APS,EdAniProd) =E= SUM((Level,HerdTypes)$(APSLevel(APS,Level) AND APSHerdType(APS,HerdTypes)), vProOutput(APS,Level,HerdTypes,EdAniProd)) / SUM(EU28, Population(EU28)) / 365
;
EQUATION eASFGroup;
         eASFGroup(AnimalEL,ELmme)$AniELEdAniProdEL(AnimalEL,ELmme)..
         vASFGroup(AnimalEL,ELmme) =E=
         SUM((APS,EdAniProd)$(APSEL(AnimalEL,APS) AND EdAniProdEL(ELmme,EdAniProd)), vProOutputCapD(APS,EdAniProd))
;
EQUATION eASFMax;
         eASFMax(ELmme,AnimalEL)..
         vASFGroup(AnimalEL,ELmme) =L= ASFCompEL(AnimalEL,'Max',ELmme)
;
EQUATION eASFMin;
         eASFMin..
         SUM((APS,Level,HerdTypes,EdAniProd),vProOutput(APS,Level,HerdTypes,EdAniProd)) =E= SUM(EU28, 27.967275 * 365 * Population(EU28))

;
EQUATION eMeat;
         eMeat..
         SUM(AnimalEL,vASFGroup(AnimalEL,'MeatEL')) =L= 18.1
;

vGrazingIntakeHerdTypekgDM.FX(EU28,Mono,Level,HerdTypes,GrassType,GrassProd)=0;


*************************************************************************
*---------------------DECLARE PARAMETERS FOR REPORTING------------------*
*************************************************************************
PARAMETERS
ProdOutAPSEU                     (Scenario,APS,EdAniProd)                         Product output per APS                  [kg EdAniProd.yr]
ProdOutAPSEUCapD                 (Scenario,APS,EdAniProd)                         Product output per APS                  [kg EdAniProd.cap.d]
ProdOutFisheriesEU               (Scenario,FishSpecies,EdFishProd)                Product output Fisheries                [kg Fish.Species.yr]
ProdOutFisheriesEUCapD           (Scenario,FishSpecies,EdFishProd)                Product output Fisheries                [kg Fish.Species.cap.d]
ProdOutMeatEUCapD                (Scenario,MeatFood)                              Product output Meat                     [kg Meat.Species.cap.d]
ProdOutFishEUCapD                (Scenario,FishFood)                              Product output Fish                     [kg Fish.Species.cap.d]
FoodOutputEUCapD                 (Scenario,FoodType)                              Product output Food                     [kg Type.cap.d]
Figure2ProcOut                   (Scenario,*)                                     Product output for paper figure         [kg EdAniProd.cap.d]
NutOutAPSEUCapD                  (Scenario,APS,EdAniProd,NutrOut)                 Nutrient output per APS                 [g-MJ.cap.d]
NutOutFisheriesEUCapD            (Scenario,FishSpecies,EdFishProd,NutrOut)        Nutrient output Fisheries               [g-MJ.Species.cap.d]
NutOutMeatEUCapD                 (Scenario,MeatFood,NutrOut)                      Nutrient output Meat                    [g-MJ.Species.cap.d]
NutOutFishEUCapD                 (Scenario,FishFood,NutrOut)                      Nutrient output Fish                    [g-MJ.Species.cap.d]
NutOutFoodProdEUCapD             (Scenario,FoodType,NutrOut)                      Nutrient output Food                    [g-MJ.Type.cap.d]
NutOutTotalEUCapD                (Scenario,NutrOut)                               Nutrient output Total                   [g-MJ.cap.d]
AniNumLevel                      (Scenario,EU28,APS,Level,HerdTypes)              #Animal of each HerdType                [#.cntr.APS.level]
AniNumLevelEU                    (Scenario,APS,Level,HerdTypes)                   #Animal of each HerdType                [#.APS.level]
AniNumCountry                    (Scenario,EU28,APS,HerdTypes)                    #Animal of each HerdType                [#.cntr.APS]
AniNumEU                         (Scenario,APS,HerdTypes)                         #Animal of each HerdType                [#.APS]
AvailableDMGrazingCT             (Scenario,EU28,GrassType)                        DM Grazing available (Excl. losses)     [tonne.cntr]
AvailableDMFishEU                (Scenario,FishSpecies,FishByProd)                DM Fish available (Excl. losses)        [tonne.Species]
AvailableDMFeedEU                (Scenario,Products)                              DM FeedProd available                   [tonne]
IngredientIntakeDM               (Scenario,EU28,APS,Level,HerdTypes,Products)     DM intake per Feed ingredient           [kg.cntr.yr]
IngredientIntakeHerdTypeDMD      (Scenario,EU28,APS,Level,HerdTypes,Products)     DM intake Feed ingredient               [kg.animal.cntr.d]
IngredientIntakeHerdTypeDMEUD    (Scenario,APS,Level,HerdTypes,Products)          DM intake Feed ingredient               [kg.animal.d]
IngrInFuncHerdTypeDMEUD          (Scenario,APS,Level,HerdTypes,*)                 DM intake Feed.fuction                  [kg.animal.d]
CO2Cap                           (Scenario)
LUCap                            (Scenario)
CO2APSCap                        (Scenario,APS) 
IngredientIntakeAPSDMEUD         (Scenario,APS,Products)
CH4eqEU                          (Scenario)
N2OeqEU                          (Scenario)
IntakeAPSLevelProduce            (Scenario,APS,Producers,FeedFunction)
;

SCALAR
CO2perkg
;


***********************************************************************
*--------------------------------SOLVE MODEL----------------------------*
*************************************************************************

MODEL AnimalModelPotential /eAniNutOptTotal eNumHerdType eRestrictionWasteAvailable eRestrictionGrazingAvailable eRestrictionCropCoAvailable eRestrictionFishAvailable eRestrictionAniByAvailable
                            eNutrReqTHerdTypeMet eMaxFeedIntake eVWintakeRumi eMaxVWIntake eReqSWIntake eNoFeedRumi eNoFeedRumiWaste eNoFeedPig eNoFeedPoultry eFatMax eN3Salmon eGrazingLimitDVE eGrasslandha
                            eNPKRet eNPKRetGrazing eNPKExMMR eNPKExGrazing eNPKEx eNPKExMMM eVSPig eVSBroiler eVSLayer eVSDairy eVSBeef eVSDairyGrazing eVSBeefGrazing eVSDairyMM eVSBeefMM
                            eCH4Manure eCH4Enteric eCH4 eN2ONMM eN2ONFish eGrasslandFert eN2ONGrasslandD eN2ONGrasslandID eN2ONGrassland eN2O eCO2eqAnimal eCO2eq/


      AnimalModelRefWhole  /eAniNutOptTotal eNumHerdType eRestrictionWasteAvailable eRestrictionGrazingAvailable eRestrictionCropCoAvailable eRestrictionFishAvailable eRestrictionAniByAvailable
                            eNutrReqTHerdTypeMet eMaxFeedIntake eVWintakeRumi eMaxVWIntake eReqSWIntake eNoFeedRumi eNoFeedRumiWaste eNoFeedPig eNoFeedPoultry eFatMax eN3Salmon eGrazingLimitDVE eGrasslandha
                            eNPKRet eNPKRetGrazing eNPKExMMR eNPKExGrazing eNPKEx eNPKExMMM eVSPig eVSBroiler eVSLayer eVSDairy eVSBeef eVSDairyGrazing eVSBeefGrazing eVSDairyMM eVSBeefMM
                            eCH4Manure eCH4Enteric eCH4 eN2ONMM eN2ONFish eGrasslandFert eN2ONGrasslandD eN2ONGrasslandID eN2ONGrassland eN2O eCO2eqAnimal eCO2eq eProOutput eProOutputCapD eASFGroup eASFMax/
;

file ofile / optionso.tmp /;

loop(Scenario,

Option limrow=27;
Option LP = CBC;
Option sysout = ON;
option solveopt = Clear;
option bratio = 1;

if(sameas(Scenario,'Potential'),
    CropCoAvailableFMEU(CropCoProd)          = SUM(EU28,ProdAvailableFMELWhole(EU28,CropCoProd));
    WasteAvailableFM(EU28,WasteProd)         = SUM(FoodProd, ProdAvailableFMELWhole(EU28,FoodProd) * %WasteUtilization%);
    NutrientDMWaste(EU28,WasteProd,Nutrients)= SUM(FoodProd, ProdAvailableFMELWhole(EU28,FoodProd) * NutrientDMCropCo(FoodProd,Nutrients)) / SUM(FoodProd,ProdAvailableFMELWhole(EU28,FoodProd));
    SOLVE AnimalModelPotential USING LP Maximise vAniOptOutTotal;

elseif sameas(Scenario,'RefinedGrain'),
    CropCoAvailableFMEU(CropCoProd)          = SUM(EU28,ProdAvailableFMEL(EU28,CropCoProd));
    WasteAvailableFM(EU28,WasteProd)         = SUM(FoodProd, ProdAvailableFMEL(EU28,FoodProd) * %WasteUtilization%);
    NutrientDMWaste(EU28,WasteProd,Nutrients)= SUM(FoodProd, ProdAvailableFMEL(EU28,FoodProd) * NutrientDMCropCo(FoodProd,Nutrients)) / SUM(FoodProd,ProdAvailableFMEL(EU28,FoodProd));
    SOLVE AnimalModelRefWhole USING LP Maximise vAniOptOutTotal;

elseif sameas(Scenario,'WholeGrain'),
    CropCoAvailableFMEU(CropCoProd)          = SUM(EU28,ProdAvailableFMELWhole(EU28,CropCoProd));
    WasteAvailableFM(EU28,WasteProd)         = SUM(FoodProd, ProdAvailableFMELWhole(EU28,FoodProd) * %WasteUtilization%);
    NutrientDMWaste(EU28,WasteProd,Nutrients)= SUM(FoodProd, ProdAvailableFMELWhole(EU28,FoodProd) * NutrientDMCropCo(FoodProd,Nutrients)) / SUM(FoodProd,ProdAvailableFMELWhole(EU28,FoodProd));
    SOLVE AnimalModelRefWhole USING LP Maximise vAniOptOutTotal;

);

*************************************************************************
*--------------------DECLARATION OUTPUT PARAMETERS----------------------*
*************************************************************************


***///Product output\\\***
ProdOutAPSEU(Scenario,APS,EdAniProd)
         = SUM((EU28,Level,HerdTypes), vNumHerdType.L(EU28,APS,Level,HerdTypes)
           * EdAniProdHerdType(APS,Level,HerdTypes,EdAniProd)
           $(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level) and vNumHerdType.L(EU28,APS,Level,HerdTypes)>1))
;
ProdOutAPSEUCapD(Scenario,APS,EdAniProd)                  = (ProdOutAPSEU(Scenario,APS,EdAniProd) / SUM(EU28,Population(EU28)) / 365) $(ProdOutAPSEU(Scenario,APS,EdAniProd)>0);
ProdOutFisheriesEU(Scenario,FishSpecies,EdFishProd)       = FOutput(FishSpecies,EdFishProd) * 1000;
ProdOutFisheriesEUCapD(Scenario,FishSpecies,EdFishProd)   = (FOutput(FishSpecies,EdFishProd) * 1000) / SUM(EU28,Population(EU28)) / 365;
ProdOutMeatEUCapD(Scenario,"MeatPig")                     = ProdOutAPSEUCapD(Scenario,"Pig","MeatC");
ProdOutMeatEUCapD(Scenario,"MeatBeef")                    = ProdOutAPSEUCapD(Scenario,"Dairy","MeatC") + ProdOutAPSEUCapD(Scenario,"Beef","MeatC");
ProdOutMeatEUCapD(Scenario,"MeatPoultry")                 = ProdOutAPSEUCapD(Scenario,"Layer","MeatC") + ProdOutAPSEUCapD(Scenario,"Broiler","MeatC");
ProdOutFishEUCapD(Scenario,"FishSalmon")                  = ProdOutAPSEUCapD(Scenario,"Salmon","MeatC");
ProdOutFishEUCapD(Scenario,"FishTilapia")                 = ProdOutAPSEUCapD(Scenario,"Tilapia","MeatC");
ProdOutFishEUCapD(Scenario,"FishHerring")                 = ProdOutFisheriesEUCapD(Scenario,"Atlantic_herring","FMeatC");
ProdOutFishEUCapD(Scenario,"FishCod")                     = ProdOutFisheriesEUCapD(Scenario,"Atlantic_cod","FMeatC");
ProdOutFishEUCapD(Scenario,"FishWhiting")                 = ProdOutFisheriesEUCapD(Scenario,"Blue_whiting","FMeatC");
ProdOutFishEUCapD(Scenario,"FishMackerel")                = ProdOutFisheriesEUCapD(Scenario,"Atlantic_mackerel","FMeatC");
ProdOutFishEUCapD(Scenario,"FishSprat")                   = ProdOutFisheriesEUCapD(Scenario,"European_Sprat","FMeatC");
ProdOutFishEUCapD(Scenario,"FishHaddock")                 = ProdOutFisheriesEUCapD(Scenario,"Haddock","FMeatC");
ProdOutFishEUCapD(Scenario,"FishPollock")                 = ProdOutFisheriesEUCapD(Scenario,"Pollock","FMeatC");
ProdOutFishEUCapD(Scenario,"FishPlaice")                  = ProdOutFisheriesEUCapD(Scenario,"European_plaice","FMeatC");
ProdOutFishEUCapD(Scenario,"FishHake")                    = ProdOutFisheriesEUCapD(Scenario,"European_hake","FMeatC");
ProdOutFishEUCapD(Scenario,"FishHorseMackerel")           = ProdOutFisheriesEUCapD(Scenario,"Atlantic_horse_mackerel","FMeatC");
ProdOutFishEUCapD(Scenario,"FishSandeels")                = ProdOutFisheriesEUCapD(Scenario,"Sandeels","FMeatC");
ProdOutFishEUCapD(Scenario,"FishPilchard")                = ProdOutFisheriesEUCapD(Scenario,"European_pilchard","FMeatC");
ProdOutFishEUCapD(Scenario,"FishNorwayPout")              = ProdOutFisheriesEUCapD(Scenario,"Norway_pout","FMeatC");
ProdOutFishEUCapD(Scenario,"FishNorwayLobster")           = ProdOutFisheriesEUCapD(Scenario,"Norway_lobster","FMeatC");
ProdOutFishEUCapD(Scenario,"FishNorthernPrawn")           = ProdOutFisheriesEUCapD(Scenario,"Northern_prawn","FMeatC");
ProdOutFishEUCapD(Scenario,"FishLing")                    = ProdOutFisheriesEUCapD(Scenario,"Ling","FMeatC");
FoodOutputEUCapD(Scenario,"Meat")                         = SUM(MeatFood,ProdOutMeatEUCapD(Scenario,MeatFood));
FoodOutputEUCapD(Scenario,"Offal")                        = SUM(APS,ProdOutAPSEUCapD(Scenario,APS,"OffalC"));
FoodOutputEUCapD(Scenario,"Milk")                         = ProdOutAPSEUCapD(Scenario,"Dairy","Milk");
FoodOutputEUCapD(Scenario,"Eggs")                         = ProdOutAPSEUCapD(Scenario,"Layer","Eggs");
FoodOutputEUCapD(Scenario,"Fish")                         = SUM(FishFood,ProdOutFishEUCapD(Scenario,FishFood));
;

Figure2ProcOut(Scenario,"Pork")         = ProdOutAPSEUCapD(Scenario,"Pig","MeatC") + ProdOutAPSEUCapD(Scenario,"Pig","OffalC");
Figure2ProcOut(Scenario,"Milk")         = ProdOutAPSEUCapD(Scenario,"Dairy","Milk");
Figure2ProcOut(Scenario,"Beef")         = ProdOutAPSEUCapD(Scenario,"Dairy","MeatC") + ProdOutAPSEUCapD(Scenario,"Beef","MeatC") + ProdOutAPSEUCapD(Scenario,"Dairy","OffalC") + ProdOutAPSEUCapD(Scenario,"Beef","OffalC");
Figure2ProcOut(Scenario,"Poultry")      = ProdOutAPSEUCapD(Scenario,"Layer","MeatC") + ProdOutAPSEUCapD(Scenario,"Broiler","MeatC") + ProdOutAPSEUCapD(Scenario,"Layer","OffalC") + ProdOutAPSEUCapD(Scenario,"Broiler","OffalC");
Figure2ProcOut(Scenario,"Eggs")         = ProdOutAPSEUCapD(Scenario,"Layer","Eggs");
Figure2ProcOut(Scenario,"Fish")         = FoodOutputEUCapD(Scenario,"Fish");




***///Nutrient output\\\***
NutOutAPSEUCapD(Scenario,APS,EdAniProd,NutrOut)
         = SUM((EU28,Level,HerdTypes),
           (AniNutrOutHerdType(APS,Level,HerdTypes,EdAniProd,NutrOut)
           * vNumHerdType.L(EU28,APS,Level,HerdTypes))
           $(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level) and vNumHerdType.L(EU28,APS,Level,HerdTypes)>1))
           / SUM(EU282,Population(EU282)) / 365
;
NutOutFisheriesEUCapD(Scenario,FishSpecies,EdFishProd,NutrOut)   = ProdOutFisheriesEUCapD(Scenario,FishSpecies,EdFishProd) * NutrContEdFishProd(FishSpecies,EdFishProd,NutrOut);
NutOutMeatEUCapD(Scenario,"MeatPig",NutrOut)                     = NutOutAPSEUCapD(Scenario,"Pig","MeatC",NutrOut);
NutOutMeatEUCapD(Scenario,"MeatBeef",NutrOut)                    = NutOutAPSEUCapD(Scenario,"Dairy","MeatC",NutrOut) + NutOutAPSEUCapD(Scenario,"Beef","MeatC",NutrOut);
NutOutMeatEUCapD(Scenario,"MeatPoultry",NutrOut)                 = NutOutAPSEUCapD(Scenario,"Layer","MeatC",NutrOut) + NutOutAPSEUCapD(Scenario,"Broiler","MeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishSalmon",NutrOut)                  = NutOutAPSEUCapD(Scenario,"Salmon","MeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishTilapia",NutrOut)                 = NutOutAPSEUCapD(Scenario,"Tilapia","MeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishHerring",NutrOut)                 = NutOutFisheriesEUCapD(Scenario,"Atlantic_herring","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishCod",NutrOut)                     = NutOutFisheriesEUCapD(Scenario,"Atlantic_cod","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishWhiting",NutrOut)                 = NutOutFisheriesEUCapD(Scenario,"Blue_whiting","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishMackerel",NutrOut)                = NutOutFisheriesEUCapD(Scenario,"Atlantic_mackerel","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishSprat",NutrOut)                   = NutOutFisheriesEUCapD(Scenario,"European_Sprat","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishHaddock",NutrOut)                 = NutOutFisheriesEUCapD(Scenario,"Haddock","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishPollock",NutrOut)                 = NutOutFisheriesEUCapD(Scenario,"Pollock","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishPlaice",NutrOut)                  = NutOutFisheriesEUCapD(Scenario,"European_plaice","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishHake",NutrOut)                    = NutOutFisheriesEUCapD(Scenario,"European_hake","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishHorseMackerel",NutrOut)           = NutOutFisheriesEUCapD(Scenario,"Atlantic_horse_mackerel","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishSandeels",NutrOut)                = NutOutFisheriesEUCapD(Scenario,"Sandeels","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishPilchard",NutrOut)                = NutOutFisheriesEUCapD(Scenario,"European_pilchard","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishNorwayPout",NutrOut)              = NutOutFisheriesEUCapD(Scenario,"Norway_pout","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishNorwayLobster",NutrOut)           = NutOutFisheriesEUCapD(Scenario,"Norway_lobster","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishNorthernPrawn",NutrOut)           = NutOutFisheriesEUCapD(Scenario,"Northern_prawn","FMeatC",NutrOut);
NutOutFishEUCapD(Scenario,"FishLing",NutrOut)                    = NutOutFisheriesEUCapD(Scenario,"Ling","FMeatC",NutrOut);
NutOutFoodProdEUCapD(Scenario,"Meat",NutrOut)                    = SUM(MeatFood,NutOutMeatEUCapD(Scenario,MeatFood,NutrOut));
NutOutFoodProdEUCapD(Scenario,"Offal",NutrOut)                   = SUM(APS,NutOutAPSEUCapD(Scenario,APS,"OffalC",NutrOut));
NutOutFoodProdEUCapD(Scenario,"Milk",NutrOut)                    = NutOutAPSEUCapD(Scenario,"Dairy","Milk",NutrOut);
NutOutFoodProdEUCapD(Scenario,"Eggs",NutrOut)                    = NutOutAPSEUCapD(Scenario,"Layer","Eggs",NutrOut);
NutOutFoodProdEUCapD(Scenario,"Fish",NutrOut)                    = SUM(FishFood,NutOutFishEUCapD(Scenario,FishFood,NutrOut));
NutOutTotalEUCapD(Scenario,NutrOut)                              = SUM(FoodType,NutOutFoodProdEUCapD(Scenario,FoodType,NutrOut));

***///Animal Numbers\\\***
AniNumLevel(Scenario,EU28,APS,Level,HerdTypes)$(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level))
         = vNumHerdType.L(EU28,APS,Level,HerdTypes)$(vNumHerdType.L(EU28,APS,Level,HerdTypes)>1)
;
AniNumLevelEU(Scenario,APS,Level,HerdTypes)       = SUM(EU28,AniNumLevel(Scenario,EU28,APS,Level,HerdTypes))$(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level));
AniNumCountry(Scenario,EU28,APS,HerdTypes)        = SUM(Level,AniNumLevel(Scenario,EU28,APS,Level,HerdTypes)$(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level)));
AniNumEU(Scenario,APS,HerdTypes)                  = SUM((EU28,Level),AniNumLevel(Scenario,EU28,APS,Level,HerdTypes)$(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level)));

***///Feed available\\\***
AvailableDMGrazingCT(Scenario,EU28,GrassType)     = GrazingAvailableDM(EU28,GrassType) * (1- LossFraction('Grass','FeedingLosses'));
AvailableDMFishEU(Scenario,FishSpecies,FishByProd)= FishByProdProd(FishSpecies,FishByProd)* NutrientDMFishByProd(FishSpecies,FishByProd,'FMtoDM')* (1-0.02);
AvailableDMFeedEU(Scenario,WasteProd)             = SUM(EU28, WasteAvailableFM(EU28,WasteProd) * NutrientDMWaste(EU28,WasteProd,'FMtoDM') * (1- LossFraction('Waste','FeedingLosses')));
AvailableDMFeedEU(Scenario,CropCoProd)            = CropCoAvailableFMEU(CropCoProd) * NutrientDMCropCo(CropCoProd,'FMtoDM') * (1- LossFraction(CropCoProd,'FeedingLosses'));
AvailableDMFeedEU(Scenario,GrassType)             = SUM(EU28,AvailableDMGrazingCT(Scenario,EU28,GrassType));
AvailableDMFeedEU(Scenario,FishByProd)            = SUM(FishSpecies,AvailableDMFishEU(Scenario,FishSpecies,FishByProd));
AvailableDMFeedEU(Scenario,AniByProd)             = SUM((EU28,APS,Level,HerdTypes),
                                                    ((AniByProdHerdType(APS,Level,HerdTypes,AniByProd)
                                                      * vNumHerdType.L(EU28,APS,Level,HerdTypes)
                                                           $(APSHerdType(APS,HerdTypes) and APSLevel(APS,Level) and vNumHerdType.L(EU28,APS,Level,HerdTypes)>1)))
                                                              * NutrientDMAniBy(AniByProd,'FMtoDM') * (1-0.02)) / 1000;


***///Feed Allocation\\\***
IngredientIntakeDM(Scenario,EU28,APS,Level,HerdTypes,FishByProd)  = SUM(FishSpecies,vFishIntakeHerdTypekgDM.L(EU28,APS,Level,HerdTypes,FishSpecies,FishByProd) $(vFishIntakeHerdTypekgDM.L(EU28,APS,Level,HerdTypes,FishSpecies,FishByProd)>1));
IngredientIntakeDM(Scenario,EU28,APS,Level,HerdTypes,AniByProd)   = vAniByIntakeHerdTypekgDM.L(EU28,APS,Level,HerdTypes,AniByProd)$(vAniByIntakeHerdTypekgDM.L(EU28,APS,Level,HerdTypes,AniByProd)>1);
IngredientIntakeDM(Scenario,EU28,APS,Level,HerdTypes,CropCoProd)  = vCropCoIntakeHerdTypekgDM.L(EU28,APS,Level,HerdTypes,CropCoProd)$(vCropCoIntakeHerdTypekgDM.L(EU28,APS,Level,HerdTypes,CropCoProd)>1);
IngredientIntakeDM(Scenario,EU28,APS,Level,HerdTypes,WasteProd)   = vWasteIntakeHerdTypekgDM.L(EU28,APS,Level,HerdTypes,WasteProd)$(vWasteIntakeHerdTypekgDM.L(EU28,APS,Level,HerdTypes,WasteProd)>1);
IngredientIntakeDM(Scenario,EU28,APS,Level,HerdTypes,GrassProd)   = SUM(GrassType,vGrazingIntakeHerdTypekgDM.L(EU28,APS,Level,HerdTypes,GrassType,GrassProd)$(GrassTypeProd(GrassType,GrassProd) and (vGrazingIntakeHerdTypekgDM.L(EU28,APS,Level,HerdTypes,GrassType,GrassProd)>1)));

***///Diet composition\\\***
IngredientIntakeHerdTypeDMD(Scenario,EU28,APS,Level,HerdTypes,FeedProd)$(AniNumLevel(Scenario,EU28,APS,Level,HerdTypes) and IngredientIntakeDM(Scenario,EU28,APS,Level,HerdTypes,FeedProd)>1)
         = IngredientIntakeDM(Scenario,EU28,APS,Level,HerdTypes,FeedProd)
           / AniNumLevel(Scenario,EU28,APS,Level,HerdTypes) / Duration(APS,Level,HerdTypes)
;
IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,FeedProd)$AniNumLevelEU(Scenario,APS,Level,HerdTypes)
         = SUM(EU28, IngredientIntakeDM(Scenario,EU28,APS,Level,HerdTypes,FeedProd))
           / AniNumLevelEU(Scenario,APS,Level,HerdTypes) / Duration(APS,Level,HerdTypes)
;

IngredientIntakeAPSDMEUD(Scenario,APS,Products) = (SUM((Level,HerdTypes), IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,Products) * AniNumLevelEU(Scenario,APS,Level,HerdTypes)) / SUM((Level,HerdTypes), AniNumLevelEU(Scenario,APS,Level,HerdTypes)))$SUM((Level,HerdTypes), AniNumLevelEU(Scenario,APS,Level,HerdTypes));

IngrInFuncHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,"Cereal")         = SUM(CerealFeed,IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,CerealFeed)     $IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,CerealFeed));
IngrInFuncHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,"Oil Seed Meal")  = SUM(OilSeedFeed,IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,OilSeedFeed)   $IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,OilSeedFeed));
IngrInFuncHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,"Pulp")           = SUM(PulpFeed,IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,PulpFeed)         $IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,PulpFeed));
IngrInFuncHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,"Roughage")       = SUM(RoughageFeed,IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,RoughageFeed) $IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,RoughageFeed));
IngrInFuncHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,"Molasses")       = SUM(MolassesFeed,IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,MolassesFeed) $IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,MolassesFeed));
IngrInFuncHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,"Waste")          = SUM(WasteFeed,IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,WasteFeed)       $IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,WasteFeed));
IngrInFuncHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,"Animal Fat")     = SUM(AniFatFeed,IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,AniFatFeed)     $IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,AniFatFeed));
IngrInFuncHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,"Animal Protein") = SUM(AniProtFeed,IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,AniProtFeed)   $IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,AniProtFeed));
IngrInFuncHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,"Fish Oil")       = SUM(FishOilFeed,IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,FishOilFeed)   $IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,FishOilFeed));
IngrInFuncHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,"Fish Meal")      = SUM(FishMealFeed,IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,FishMealFeed) $IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,FishMealFeed));
IngrInFuncHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,"Grass")          = SUM(Grass,IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,Grass)               $IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,Grass));
IngrInFuncHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,"Silage")         = SUM(Silage,IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,Silage)             $IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,Silage));
IngrInFuncHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,"Hay")            = SUM(Hay,IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,Hay)                   $IngredientIntakeHerdTypeDMEUD(Scenario,APS,Level,HerdTypes,Hay));
;

IntakeAPSLevelProduce(Scenario,APS,Producers,FeedFunction) = (SUM(Level, IngrInFuncHerdTypeDMEUD(Scenario,APS,Level,Producers,FeedFunction) * SUM(EU28, AniNumLevel(Scenario,EU28,APS,Level,Producers))) / SUM((EU28,Level2), AniNumLevel(Scenario,EU28,APS,Level2,Producers)))$SUM((EU28,Level2), AniNumLevel(Scenario,EU28,APS,Level2,Producers));

***/// Additional parameters for reporting \\\*** 
CO2Cap(Scenario) = SUM(EU28, vCO2eqTotal.L(EU28)) / SUM(EU28, Population(EU28))
;
LUCap(Scenario) =  (SUM((EU28,Rumi,Level,HerdTypes,GrassType), vGrasslandha.L(EU28,Rumi,Level,HerdTypes,GrassType)) / SUM(EU28, Population(EU28)))
;
CO2APSCap(Scenario,APS) = SUM((EU28,Level)$APSLevel(APS,Level), vCO2eq.L(EU28,APS,Level)) / SUM(EU28, Population(EU28))
;
CH4eqEU(Scenario) = CH4 * SUM((EU28,APS,Level), vCH4.L(EU28,APS,Level));

N2OeqEU(Scenario) = N2O * SUM((EU28,APS,Level), vN2O.L(EU28,APS,Level));

***
*** SCEDNARIO LOOP END
***
);

*************************************************************************
*-------------------------CREATE OUTPUTE FILES--------------------------*
*************************************************************************

Execute_Unload 'ModelResults.gdx'
ProdOutAPSEU
ProdOutFisheriesEU
FoodOutputEUCapD
ProdOutMeatEUCapD
ProdOutFishEUCapD
ProdOutAPSEUCapD
NutOutFoodProdEUCapD
NutOutMeatEUCapD
NutOutFishEUCapD
NutOutAPSEUCapD
AniNumLevelEU
AniNumLevel
IngrInFuncHerdTypeDMEUD
IngredientIntakeHerdTypeDMEUD
AvailableDMFeedEU
IngredientIntakeAPSDMEUD

vCropCoIntakeHerdTypekgDM
vWasteIntakeHerdTypekgDM
vGrazingIntakeHerdTypekgDM
vFishIntakeHerdTypekgDM
vAniByIntakeHerdTypekgDM
IntakeAPSLevelProduce

NutOutAPSEUCapD
ProdOutAPSEUCapD
vCO2eq
vCO2eqAnimal
vCO2eqTotal
CO2Cap
LUCap
CO2APSCap

CH4eqEU
N2OeqEU
Figure2ProcOut
;



put ofile 'o=GHGModelResults'/;
$onput
par=ProdOutAPSEU                         rng=ProdOutAPSEU!A1                     rdim=2  cdim=1
par=ProdOutFisheriesEU                   rng=ProdOutFisheriesEU!A1               rdim=2  cdim=1
par=FoodOutputEUCapD                     rng=FoodOutputEUCapD!A1                 rdim=2
par=ProdOutMeatEUCapD                    rng=ProdOutMeatEUCapD!A1                rdim=2
par=ProdOutFishEUCapD                    rng=ProdOutFishEUCapD!A1                rdim=2
par=ProdOutAPSEUCapD                     rng=ProdOutAPSEUCapD!A1                 rdim=2  cdim=1
par=NutOutFoodProdEUCapD                 rng=NutOutFoodProdEUCapD!A1             rdim=2  cdim=1
par=NutOutMeatEUCapD                     rng=NutOutMeatEUCapD!A1                 rdim=2  cdim=1
par=NutOutFishEUCapD                     rng=NutOutFishEUCapD!A1                 rdim=2  cdim=1
par=NutOutAPSEUCapD                      rng=NutOutAPSEUCapD!A1                  rdim=3  cdim=1
par=AniNumLevelEU                        rng=AniNumLevelEU!A1                    rdim=4
par=AniNumLevel                          rng=AniNumLevel!A1                      rdim=5
par=IngrInFuncHerdTypeDMEUD              rng=IngrInFuncHerdtypeDMEUD!A1          rdim=4  cdim=1
par=IngredientIntakeHerdTypeDMEUD        rng=IngredientIntakeHerdTypeDMEUD!A1    rdim=4  cdim=1
par=AvailableDMFeedEU                    rng=AvailableDMFeedEU!A1
par=CO2APSCap                            rng=CO2APSCap!A1
par=Figure2ProcOut                       rng=Figure2ProcOut!A1                   

par=IngredientIntakeAPSDMEUD             rng=IngredientIntakeAPSDMEUD!A1
par=IntakeAPSLevelProduce                rng=IntakeAPSLevelProduce!A1

par=CO2Cap                               rng=AniCO2Cap!A1                                cdim=1
par=LUCap                                rng=AniLUCap!A1                                 cdim=1
par=CH4eqEU                              rng=AniCH4eqEU!A1
par=N2OeqEU                              rng=AniN2OeqEU!A1
$offput
putclose;

Execute 'gdxxrw.exe ModelResults.gdx @optionso.tmp'




