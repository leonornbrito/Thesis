Title of the dataset:
Model and input data related to: Circularity in animal production requires a change in the EAT-Lancet diet in Europe

Creators:
Benjamin van Selm (ORCID: 0000-0002-0742-8291) (a,b)
Ollie van Hal (ORCID: 0000-0002-9691-8873) (a)
Anita Frehner (ORCID: 0000-0002-0039-8421) (a,c)

Contributors:
Imke J.M. de Boer (ORCID: 0000-0002-0675-7528) (a) 
Renske Hijbeek (ORCID: 0000-0001-8214-9121) (b)
Martin K. van Ittersum (0000-0001-8611-6781) (b)
Elise F. Talsma (ORCID: 0000-0002-6034-4708) (d)
Jan Peter Lesschen (ORCID: 0000-0003-1535-8294) (e)
Chantal M.J. Hendriks (0000-0001-6749-7232) (e)
Mario Herrero (ORCID: 0000-0002-7741-5090) (f)
Hannah H.E. van Zanten (ORCID: 0000-0002-5262-5518) (g)

(a): 	Animal Production Systems, Wageningen University & Research
(b):	Plant Production Systems, Wageningen University & Research
(c):    Department of Socioeconomics, Research Institute of Organic Agriculture FiBL, Frick, Switzerland
(d):	Global Nutrition, Wageningen University & Research
(e):	Sustainable Soil Use, Wageningen University & Research
(f):	Department of Global Development, College of Agriculture and Life Sciences and Cornell Atkinson Center for Sustainability, Cornell University
(g):	Farming Systems Ecology, Wageningen University & Research

Related publication:
Circularity in animal production requires a change in the EAT-Lancet diet in Europe

Description:
Repository contains input data for and model code to run the resource allocation model. 

The model is a linear optimisation model with an objective function to maximise human edible protein from livestock (dairy, beef, pigs, laying hens, broiler chickens, salmon and tilapia) while satisfying their nutritional requirements from a given availability of feed. The availability of feed is based on the low opportunity cost biomass (co-products, food waste, and grassland resources) produced from the EAT-LANCET diet and grasslands in the European Union 27 + United Kingdom. Two different availabilities of co-products and food waste are provided, one from the original EAT-LANCET diet and a second from a refined grain version of the EAT-LANCET diet. In addition the model can calculate the associated GHG emissions from livestock and steer livestock production to meet the animal-sourced food requirements of the EAT-LANCET diet. 

Keywords:
Circular food systems, GHG emissions, EAT-LANCET diet

Spatial coverage:
European Union 27 + United Kingdom

Temporal coverage:
N/A

This dataset contains the following files:

1. ModelData.xlsx
   Input data for resource allocation model

2. AnimalModelGHG.gms
   Resource allocation model code

Explanation of variables:

ModelData.xlsx
	Sheet: MilkEggHerdType
	Yield of milk and eggs per animal per year
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] Level: Productivity level e.g., High
		        [C] HerdTypes: Type of animal e.g., producer or replacement
                        [D] Milk: milk produced per animal (HerdType) [kg per animal per year]
		        [E] Eggs: eggs produced per animal (HerdType) [kg per animal per year]
		Source: van Hal, Ollie 
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412 

	Sheet: LWHerdType
	Yield of live weight per animal per year
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] Level: Productivity level e.g., High
		        [C] HerdTypes: Type of animal e.g., producer or replacement
                        [D] : live weight produced per animal (HerdType) [kg per animal per year]
		Source: van Hal, Ollie 
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412       

	Sheet: SlaughterFrac
	Percentage of products produced from animal live weight 
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] Level: Productivity level e.g., High
		        [C] HerdTypes: Type of animal e.g., producer or replacement
                        [D:S] : Percentage of products produced (e.g., carcass, blood meal, meat and bone meat, etc.) from animal live weight [%]
		Source: van Hal, Ollie 
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412        

	Sheet: CuttingFrac
	Percentage of products produced from animal carcass weight
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] Level: Productivity level e.g., High
		        [C] HerdTypes: Type of animal e.g., producer or replacement
                        [D:F] : Percentage of products produced (e.g., carcass, blood meal, meat and bone meat, etc.) from animal carcass weight [%]
		Source: van Hal, Ollie 2020
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412 
		        
	Sheet: NutrContEdAniProd
	Nutrient content (for humans) of edible animal products
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] Level: Productivity level e.g., High
		        [C] EdAniProd: Edible animal products e.g., meat, milk
                        [D] Protein: Total protein [g per kg]
		        [E] Fat: Total fat [g per kg]
                        [F] Energy: Total energy [kcal per kg]
		        [G] VitA: Total vitamin A [ug per kg] 
                        [H] VitD: Total vitamin D [ug per kg]
		        [I] VitB12: Total vitamin B12 [ug per kg]
                        [J] Calcium: Total calcium [mg per kg]
		        [K] Iron: Total iron [mg per kg]
                        [L] Zinc: Total zince [mg per kg]
		        [M] Selenium: Selenium [mg per kg]	
                        [N] ALA: Total alpha-linolenic acid [g per kg]
		        [O] EPA: Total eicosapentaenoic acid [g per kg]
                        [P] DPA: Total docosapentaenoic acid [g per kg]
		        [Q] DHA: Total docosahexaenoic acid [g per kg]
		Source: USDA 2012
			USDA Food Composition Databases
			United States Department of Agriculture (USDA), Washington D.C. 
                      
	Sheet: NutrientDMAniBy
	Nutrient content (for animals) of animal by-products
		Column: [A] AniByProd: Name of animal by-product e.g., pig bone meal, poultry bone meal  
		        [B] DMtoFM: Conversion from dry matter to fresh matter [kg FM per kg DM]
		        [C] FMtoDM: Conversion from fresh matter to dry matter [kg DM per kg FM]
                        [D] CP: Total crude protein [g per kg DM]
		        [E] N: Total nitrogen [g per kg DM]
                        [F] P: Total phosphorus [g per kg DM] 
		        [G] GE: Total Gross energy [MJ per kg DM]
                        [H] CFAT: Total Crude fat [g per kg DM]
		        [I] NFE: Total nitrogen-free extract [g per kg DM]
                        [J] ASH: Total ash [g per kg DM]
		        [K] VEM: Total fodder unit milk [unit per kg DM]
                        [L] VEVI: Total fodder unit beef [unit per kg DM]
		        [M] DVE: Total digestible true protein [unit per kg DM]
                        [N] OEB: Total degraded protein balance [unit per kg DM]
		        [O] SW: Satiety unit [unit per kg DM]
                        [P] VW: Fill unit (feed intake capacity) [unit per kg DM]
		        [Q] DCCP: Digestible crude protein dairy [%]  
                        [R] BDCP: Digestible crude protein beef [%]
		        [S] DDOM: Digestible organic matter dairy [%]
                        [T] BDOM: Digestible organic matter beef [%]
		        [U] NEP: Total net energy pig [MJ NE per kg DM] 	
		        [V] DPP: Total standardised digestible crude protein [g per kg DM]
                        [W] DVLysP: Total digestible lysine pig [g per kg DM]
		        [X] DVMetP: Total digestible methionine pig [g per kg DM]
                        [Y] PDCP: Digestible crude protein pig [%] 
		        [Z] PDOM: Digestible organic matter pig [%] 
                        [AA] OEL: Total metabolisable energy laying hen [MJ ME per kg DM]
		        [AB] DPL: Total digestible protein laying hen [g per kg DM]
		        [AC] DVLysL: Total digestible lysine laying hen [g per kg DM]
                        [AD] DVMETL: Total digestible methionine laying hen [g per kg DM]
		        [AE] LDCPL: Digestible crude protein laying hen [%]
                        [AF] LDNFE: Digestible nitrogen-free extract laying hen [%]
		        [AG] LDCFAT: Digestible crude fat laying hen [%]
                        [AH] OEBr: Total metabolisable energy broiler [MJ ME per kg DM]
		        [AI] DPBr: Total digestible protein broiler [g per kg DM]
                        [AJ] DVLysBr: Total digestible lysine broiler [g per kg DM]
		        [AK] DVMetBr: Total digestible methionine broiler [g per kg DM]
                        [AL] BrDCP: Digestible crude protein broiler [%]
		        [AM] BrDNFE: Digestible nitrogen-free extract broiler [%]
                        [AN] BrDCFAT: Digestible crude fat broiler [%]
		        [AO] DES: Total digestible energy salmon [MJ per kg DM]
                        [AP] DPS: Total digestible protein salmon [g per kg DM]
		        [AQ] DET: Total digestible energy tilapia [MJ per kg DM]
                        [AR] DPT: Total digestible protein tilapia [g per kg DM]
		        [AS] FAT: Total fat [gram per kg DM]
                        [AT] N3: Total omega−3 fatty acids [g per kg DM]
		Source: CVB 2016
			CVB Feed Table 2016: Chemical composition and nutritioal values of feedstuffs. 
			50 pages
			IAFFD 2018
			International Aquaculture Feed Formulation Database
			https://www.iaffd.com/

	Sheet: Landings
	Marine fisheries landings
		Column: [A] : FishSpecies e.g, Atlantic herring
		        [B] FMSYShort: Quantity of fish landed [tonnes]
		Source: van Hal, Ollie 2020
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412 
		        
	Sheet: FSlaugther
	Percentage of products produced from marine fish live weight 
		Column: [A] : FishSpecies e.g, Atlantic herring
		        [B:D] Percentage of products produced (e.g., meat, oil, meal) from fish live weight [%]
		Source: van Hal, Ollie 2020
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412 
		        
	Sheet: NutrContEdFishProd
	Nutrient content (for humans) of edible fish products
		Column: [A] FishSpecies: Fish species e.g, Atlantic herring
		        [B] EdFishProd: Edible fish products
                        [C] Protein: Total protein [g per kg]
		        [D] Fat: Total fat [g per kg]
                        [E] Energy: Total energy [kcal per kg]
		        [F] VitA: Total vitamin A [ug per kg] 
                        [G] VitD: Total vitamin D [ug per kg]
		        [H] VitB12: Total vitamin B12 [ug per kg]
                        [I] Calcium: Total calcium [mg per kg]
		        [J] Iron: Total iron [mg per kg]
                        [K] Zinc: Total zince [mg per kg]
		        [L] Selenium: Selenium [mg per kg]	
                        [M] ALA: Total alpha-linolenic acid [g per kg]
		        [N] EPA: Total eicosapentaenoic acid [g per kg]
                        [O] DPA: Total docosapentaenoic acid [g per kg]
		        [P] DHA: Total docosahexaenoic acid [g per kg]
		Source: USDA 2012
			USDA Food Composition Databases
			United States Department of Agriculture (USDA), Washington D.C. 

	Sheet: NutrientDMFishBy
	Nutrient content (for animals) of marine fish by-products
		Column: [A] FishSpecies: Fish species e.g, Atlantic herring
		        [B] FByProd: Marine fish by-products
		        [C] DMtoFM: Conversion from dry matter to fresh matter [kg FM per kg DM]
		        [D] FMtoDM: Conversion from fresh matter to dry matter [kg DM per kg FM]
                        [E] CP: Total crude protein [g per kg DM]
		        [F] N: Total nitrogen [g per kg DM]
                        [G] P: Total phosphorus [g per kg DM] 
		        [H] GE: Total Gross energy [MJ per kg DM]
                        [I] CFAT: Total Crude fat [g per kg DM]
		        [J] NFE: Total nitrogen-free extract [g per kg DM]
                        [K] ASH: Total ash [g per kg DM]
		        [L] VEM: Total fodder unit milk [unit per kg DM]
                        [M] VEVI: Total fodder unit beef [unit per kg DM]
		        [N] DVE: Total digestible true protein [unit per kg DM]
                        [O] OEB: Total degraded protein balance [unit per kg DM]
		        [P] SW: Satiety unit [unit per kg DM]
                        [Q] VW: Fill unit (feed intake capacity) [unit per kg DM]
		        [R] DCCP: Digestible crude protein dairy [%]  
                        [S] BDCP: Digestible crude protein beef [%]
		        [T] DDOM: Digestible organic matter dairy [%]
                        [U] BDOM: Digestible organic matter beef [%]
		        [V] NEP: Total net energy pig [MJ NE per kg DM] 	
		        [W] DPP: Total standardised digestible crude protein [g per kg DM]
                        [X] DVLysP: Total digestible lysine pig [g per kg DM]
		        [Y] DVMetP: Total digestible methionine pig [g per kg DM]
                        [Z] PDCP: Digestible crude protein pig [%] 
		        [AA] PDOM: Digestible organic matter pig [%] 
                        [AB] OEL: Total metabolisable energy laying hen [MJ ME per kg DM]
		        [AC] DPL: Total digestible protein laying hen [g per kg DM]
		        [AD] DVLysL: Total digestible lysine laying hen [g per kg DM]
                        [AE] DVMETL: Total digestible methionine laying hen [g per kg DM]
		        [AF] LDCPL: Digestible crude protein laying hen [%]
                        [AG] LDNFE: Digestible nitrogen-free extract laying hen [%]
		        [AH] LDCFAT: Digestible crude fat laying hen [%]
                        [AI] OEBr: Total metabolisable energy broiler [MJ ME per kg DM]
		        [AJ] DPBr: Total digestible protein broiler [g per kg DM]
                        [AK] DVLysBr: Total digestible lysine broiler [g per kg DM]
		        [AL] DVMetBr: Total digestible methionine broiler [g per kg DM]
                        [AM] BrDCP: Digestible crude protein broiler [%]
		        [AN] BrDNFE: Digestible nitrogen-free extract broiler [%]
                        [AO] BrDCFAT: Digestible crude fat broiler [%]
		        [AP] DES: Total digestible energy salmon [MJ per kg DM]
                        [AQ] DPS: Total digestible protein salmon [g per kg DM]
		        [AR] DET: Total digestible energy tilapia [MJ per kg DM]
                        [AS] DPT: Total digestible protein tilapia [g per kg DM]
		        [AT] FAT: Total fat [gram per kg DM]
                        [AU] N3: Total omega−3 fatty acids [g per kg DM]
		Source: CVB 2016
			CVB Feed Table 2016: Chemical composition and nutritioal values of feedstuffs. 
			50 pages
			IAFFD 2018
			International Aquaculture Feed Formulation Database
			https://www.iaffd.com/

	Sheet: NutrientDMCropCo
	Nutrient content (for animals) of crop by-products 
		Column: [A] CropProducts: Crop co-products e.g., wheat bran
		        [B] DMtoFM: Conversion from dry matter to fresh matter [kg FM per kg DM]
		        [C] FMtoDM: Conversion from fresh matter to dry matter [kg DM per kg FM]
                        [D] CP: Total crude protein [g per kg DM]
		        [E] N: Total nitrogen [g per kg DM]
                        [F] P: Total phosphorus [g per kg DM] 
		        [G] GE: Total Gross energy [MJ per kg DM]
                        [H] CFAT: Total Crude fat [g per kg DM]
		        [I] NFE: Total nitrogen-free extract [g per kg DM]
                        [J] ASH: Total ash [g per kg DM]
		        [K] VEM: Total fodder unit milk [unit per kg DM]
                        [L] VEVI: Total fodder unit beef [unit per kg DM]
		        [M] DVE: Total digestible true protein [unit per kg DM]
                        [N] OEB: Total degraded protein balance [unit per kg DM]
		        [O] SW: Satiety unit [unit per kg DM]
                        [P] VW: Fill unit (feed intake capacity) [unit per kg DM]
		        [Q] DCCP: Digestible crude protein dairy [%]  
                        [R] BDCP: Digestible crude protein beef [%]
		        [S] DDOM: Digestible organic matter dairy [%]
                        [T] BDOM: Digestible organic matter beef [%]
		        [U] NEP: Total net energy pig [MJ NE per kg DM] 	
		        [V] DPP: Total standardised digestible crude protein [g per kg DM]
                        [W] DVLysP: Total digestible lysine pig [g per kg DM]
		        [X] DVMetP: Total digestible methionine pig [g per kg DM]
                        [Y] PDCP: Digestible crude protein pig [%] 
		        [Z] PDOM: Digestible organic matter pig [%] 
                        [AA] OEL: Total metabolisable energy laying hen [MJ ME per kg DM]
		        [AB] DPL: Total digestible protein laying hen [g per kg DM]
		        [AC] DVLysL: Total digestible lysine laying hen [g per kg DM]
                        [AD] DVMETL: Total digestible methionine laying hen [g per kg DM]
		        [AE] LDCPL: Digestible crude protein laying hen [%]
                        [AF] LDNFE: Digestible nitrogen-free extract laying hen [%]
		        [AG] LDCFAT: Digestible crude fat laying hen [%]
                        [AH] OEBr: Total metabolisable energy broiler [MJ ME per kg DM]
		        [AI] DPBr: Total digestible protein broiler [g per kg DM]
                        [AJ] DVLysBr: Total digestible lysine broiler [g per kg DM]
		        [AK] DVMetBr: Total digestible methionine broiler [g per kg DM]
                        [AL] BrDCP: Digestible crude protein broiler [%]
		        [AM] BrDNFE: Digestible nitrogen-free extract broiler [%]
                        [AN] BrDCFAT: Digestible crude fat broiler [%]
		        [AO] DES: Total digestible energy salmon [MJ per kg DM]
                        [AP] DPS: Total digestible protein salmon [g per kg DM]
		        [AQ] DET: Total digestible energy tilapia [MJ per kg DM]
                        [AR] DPT: Total digestible protein tilapia [g per kg DM]
		        [AS] FAT: Total fat [gram per kg DM]
                        [AT] N3: Total omega−3 fatty acids [g per kg DM]
		Source: CVB 2016
			CVB Feed Table 2016: Chemical composition and nutritioal values of feedstuffs. 
			50 pages
			IAFFD 2018
			International Aquaculture Feed Formulation Database
			https://www.iaffd.com/

	Sheet: GrazingDistribution
	Quantity of grassland available in each country
		Column: [A] EuropeanUnion28 : Countries
		        [B:S] Scenario grassland productivity: Scenario (e.g., Miterra, Plutzar etc.) and grassland productivity (e.g., Managed high quality, etc.) [tonnes kg DM]
		Source: Plutzar, C. et al. 2016
			Changes in the spatial patterns of human appropriation of net primary production (HANPP) in Europe 1990–2006. 
			Reg. Environ. Chang. 16, 1225–1238
			Haberl, H. et al. 2007
			Quantifying and mapping the human appropriation of net primary production in earth’s terrestrial ecosystems. 
			Proc. Natl. Acad. Sci. 104, 12942–12947
			Velthof, G. L. et al. 2009
			Integrated Assessment of Nitrogen Losses from Agriculture in EU-27 using MITERRA-EUROPE. 
			J. Environ. Qual. 38, 402–417
	        
	Sheet: GrazingNutrient
        Nutrient content (for animals) of grassland products 
		Column: [A] GrassType: Type of grassland e.g., Managed high quality
                        [B] GrassProd: Type of grassland product e.g., silage
		        [C] CP: Total crude protein [g per kg DM]
		        [D] N: Total nitrogen [g per kg DM]
                        [E] P: Total phosphorus [g per kg DM] 
		        [F] GE: Total Gross energy [MJ per kg DM]
                        [G] ASH: Total ash [g per kg DM]
                        [H] SW: Satiety unit [unit per kg DM]
                        [I] VW: Fill unit (feed intake capacity) [unit per kg DM]
                        [J] VEM: Total fodder unit milk [unit per kg DM]
                        [K] VEVI: Total fodder unit beef [unit per kg DM]
		        [L] DVE: Total digestible true protein [unit per kg DM]
                        [M] OEB: Total degraded protein balance [unit per kg DM]
		        [N] GrassProdtoGrassType: Conversion from hay and silage into fresh grass equivalents [%]  
		        [O] BDCP: Digestible crude protein beef [%] 
                        [P] DCCP: Digestible crude protein dairy [%]  
                        [Q] BDOM: Digestible organic matter beef [%]
		        [R] DDOM: Digestible organic matter dairy [%]
                Source: CVB 2016
			CVB Feed Table 2016: Chemical composition and nutritioal values of feedstuffs. 
			50 pages
			IAFFD 2018
                         
	Sheet: LossFraction
	Loss Fractions from feed products
		Column: [A] FeedProducts: Feed and food products e.g., wheat, wheat bran etc. 
		        [B] FeedingLosses: Feeding losses [%]  
		        [C] ProcessingLosses: Processing and packaging losses from food items destined for food waste [%] 
                        [D] ConsumptionLosses: Consumption losses from food items destined for food waste [%]
		Source: Gustavsson, J. et al. 2011 
			Global food losses and food waste - Extent, causes and prevention.
			doi:10.1098/rstb.2010.0126.
			van Hal, Ollie 2020
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412 
		    
	Sheet: HerdTypesPerPU
	Ration of different herd types relative to each producing animal 
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] Level: Productivity level e.g., High
		        [C] HerdTypes: Type of animal e.g., producer or replacement
		        [B] HerdTypesPU: Ratio of herd type to producer [unit]
		Source: van Hal, Ollie 2020
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412 
		        
	Sheet: ProducersPerYear
	Number of producer rounds per year
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] Level: Productivity level e.g., High
		        [C] Producers: Number of producer rounds per year [unit]
		Source: van Hal, Ollie 2020
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412 
                        
	Sheet: Castoff
	Number of additional animals fed each year who don't produce due to mortality or replacement
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] Castoff: Number of additional animals fed [unit]
		Source: van Hal, Ollie 2020
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412 
		        
	Sheet: NutrReqHerdType
	Nutrient requirements of each APS, level, herd type
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] Level: Productivity level e.g., High
		        [C] HerdTypes: Type of animal e.g., producer or replacement
		        [B] NEP: Total net energy pig [MJ NE per animal or place per year]
		        [C] DVLysP: Total digestible lysine pig [g per animal or place per year]
                        [D] DVMetP: Total digestible methionine pig [g per animal or place per year]
		        [E] VEM: Total fodder unit milk [unit per animal or place per year]
                        [F] VEVI: Total fodder unit beef [unit per animal or place per year]
		        [G] DVE: Total digestible true protein [unit per animal or place per year]
                        [H] OEB: Total degraded protein balance [unit per animal or place per year]
		        [I] OEBr: Total metabolisable energy broiler [MJ ME per animal or place per year]
                        [J] DVLysBr: Total digestible lysine broiler [g per animal or place per year]
		        [K] DVMetP: Total digestible methionine pig [g per animal or place per year]
                        [L] OEL: Total metabolisable energy laying hen [MJ ME per animal or place per year]
		        [M] DVLysL: Total digestible lysine laying hen [g per animal or place per year]
                        [N] DVMETL: Total digestible methionine laying hen [g per animal or place per year]
		        [O] DES: Total digestible energy salmon [MJ per animal or place per year]
                        [P] DPS: Total digestible protein salmon [g per animal or place per year]
		        [Q] DET: Total digestible energy tilapia [MJ per animal or place per year]
                        [R] DPT: Total digestible protein tilapia [g per animal or place per year]
		Source: van Hal, Ollie 2020
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412 
		 
	Sheet: IntakeCapHerdType
	Feed intake capacity monogastric per herd type
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] Level: Productivity level e.g., High
		        [C] HerdTypes: Type of animal e.g., producer or replacement
		        [B] FIC: Feed intake capacity [kg fresh matter per animal or place per year]
		Source: van Hal, Ollie 2020
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412 
		        
	Sheet: VWCapHerdType
	Feed intake capacity ruminant per herd type
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] Level: Productivity level e.g., High
		        [C] HerdTypes: Type of animal e.g., producer or replacement
		        [B] FIC VW: Feed intake capacity [unit per animal or place per year]
		Source: van Hal, Ollie 2020
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412 
		
	Sheet: SWreqHerdType
	Satiety requirement ruminants
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] Level: Productivity level e.g., High
		        [C] HerdTypes: Type of animal e.g., producer or replacement
                         [D] SW requirement: Satiety requirement [unit per animal or place per year]
		Source: van Hal, Ollie 2020
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412  
		        
	Sheet: MaxFat
	Limitation of fat content of animal diets 
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] F MAX: Maximum proportion of fat in animal diets [unit]
		Source: van Hal, Ollie 2020
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412 
		        
	Sheet: Population
	Human population of each country 
		Column: [A] Country: Countries
		        [B] Population: Number of people living in each country
		Source: FAOSTAT 1997
			Food and Agriculture Organization of the United Nations. 
			FAOSTAT Statistical Database. [Rome] 
		        
	Sheet: EFHousing
	GHG emission factors for housing of animals for each emission level e.g., high, mid, low 
		Column: [A] EuropeanUnion28: Countries
		        [B] AnimalHerdtypes: Type of animal e.g., producer or replacement
		        [C,H,M] MCFMM: Methane conversion factor manure [unit] 	
		        [D,I,N] B0: Uncertainty factor for manure methane emissions [unit] 
		        [E,J,O] EF1: Direct N2O emissions from animal housing [kg N-N2O per kg N in manure]
		        [F,K,P] EF2: In-direct N2O emissions from animal housing [kg N-N2O per kg N in manure]
		        [G,L,Q] Frac1: Faction of N2O lost as gaseous form [%]
			IPCC 2006
			Chapter 10: Emissions From Livestock and Manure Management. 
			in IPCC Guidelines for National Greenhouse Gas Inventories 54.

	Sheet: EFGrazing
	GHG emission factors for grassland for each emission level e.g., high, mid, low
		Column: [A] Country: Countries
		        [B,L,V] MCFGR: Methane conversion factor manure [unit] 	
		        [C,M,W] B0G: Uncertainty factor for manure methane emissions [unit] 
                        [D,N,X] EF3: Direct N2O emissions from manure fertilisation [kg N-N2O per kg N in manure]
		        [E,O,Y] EF4: Direct N2O emissions from articial fertilisation [kg N-N2O per kg N in manure]
                        [F,P,Z] EF5: Direct N2O emissions from grazing manure fertilisation [kg N-N2O per kg N in manure]
		        [G,Q,AA] EF6: In-direct N2O emissions from manure fertilisation volatilisation [kg N-N2O per kg N in manure]
                        [H,R,AB] EF7: In-direct N2O emissions from artificial fertilisation volatilisation [kg N-N2O per kg N in manure]
		        [I,S,AC] FracSN: Faction of N2O lost as gaseous form from artificial fertilisation [%]
                        [J,T,AD] FracM: Faction of N2O lost as gaseous form from manure fertilisation [%]
		        [K,U,AE] FracLe: Faction of N2O lost through leeching [%]
		Source: IPCC 2006
			Chapter 11: N2O Emissions From Managed Soils, and CO2 Emissions From Lime and Urea application. 
			in IPCC Guidelines for National Greenhouse Gas Inventories 54.
                         
	Sheet: GrasslandFert
	Fertilisation requirements of grassland
		Column: [A] : Nutrient e.g, nitrogen, phosphorus
		        [B] : Country
		        [C:E] Grassland type: Nutrient requirements [kg per hectare per year]
		Source: Velthof, G. L. et al. 2009
			Integrated Assessment of Nitrogen Losses from Agriculture in EU-27 using MITERRA-EUROPE. 
			J. Environ. Qual. 38, 402–417
                      
	Sheet: CropCoAvailableFMELWhole
	Crop co-products and food product available from the whole grain diet
		Column: [A] : Country
		        [B:EL] Products: Quantity of products available as food and feed [tonnes per year]
		Source: FAO 1996 
			Technical Conversion Factors for Agricultural Commodities. 
			Food and Agriculture Organization of the United Nations.
			Willett, W. et al. 2019
			Food in the Anthropocene: the EAT-Lancet Commission on healthy diets from sustainable food systems. 
			Lancet (London, England) 393, 447–492 
			Gustavsson, J. et al. 2011 
			Global food losses and food waste - Extent, causes and prevention.
			doi:10.1098/rstb.2010.0126.
		     
	Sheet: CropCoAvailableFMELRefined
	Crop co-products and food product available from the refined grain diet
		Column: [A] : Country
		        [B:EL] Products: Quantity of products available as food and feed [tonnes per year]
		Source: FAO 1996 
			Technical Conversion Factors for Agricultural Commodities. 
			Food and Agriculture Organization of the United Nations.
			Willett, W. et al. 2019
			Food in the Anthropocene: the EAT-Lancet Commission on healthy diets from sustainable food systems. 
			Lancet (London, England) 393, 447–492 
			Gustavsson, J. et al. 2011 
			Global food losses and food waste - Extent, causes and prevention.
			doi:10.1098/rstb.2010.0126.

	Sheet: NPHerdType
	Nitrogen and phosphorus retained in meat, milk and eggs
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] Level: Productivity level e.g., High
		        [C] HerdTypes: Type of animal e.g., producer or replacement
                        [D] N: Total nitrogen [kg per animal or place per year] 
		        [E] P: Total phosphorus [kg per animal or place per year]
		Source: Jongbloed, A.W. & P.A. Kemme, 2005
 			De uitscheiding van stikstof en fosfor door varkens, kippen, kalkoenen, pelsdieren, eenden, konijnen en parelhoeders in 2002 en 2006 (in Dutch). 
			Nutrition and Food report 05/I01077, 101 pp. Animal Sciences Group, Lelystad, the Netherlands
      
	Sheet: GrasslandYield
	Grassland yield
		Column: [A] : Nutrient e.g, nitrogen, phosphorus
		        [B] : Country
		        [C:S]  Scenario grassland productivity: Scenario (e.g., Miterra, Plutzar etc.) and grassland productivity yield (e.g., Managed high quality, etc.) [kg DM per ha per year]
		Source: Plutzar, C. et al. 2016
			Changes in the spatial patterns of human appropriation of net primary production (HANPP) in Europe 1990–2006. 
			Reg. Environ. Chang. 16, 1225–1238
			Haberl, H. et al. 2007
			Quantifying and mapping the human appropriation of net primary production in earth’s terrestrial ecosystems. 
			Proc. Natl. Acad. Sci. 104, 12942–12947
			Velthof, G. L. et al. 2009
			Integrated Assessment of Nitrogen Losses from Agriculture in EU-27 using MITERRA-EUROPE. 
			J. Environ. Qual. 38, 402–417
                       
	Sheet: ASFCompEL
	Composition of animal-sourced food from the EAT-LANCET in protein
		Column: [A] Animal category: Animals grouped based on species e.g., poultry, cattle
		        [B:G] Min/Max ASF: Minimum and maximum range of animal-sourced food to satisfy the eat-lancet diet [g protein per day]
		Source: Calculated

	Sheet: Grazing days
	Proportion of the year where grazing occurs
		Column: [A] : Country
		        [B] : Ratio of the year grazing occurs [unit]
		Source: Velthof, G. L. et al. 2009
			Integrated Assessment of Nitrogen Losses from Agriculture in EU-27 using MITERRA-EUROPE. 
			J. Environ. Qual. 38, 402–417
		    
	Sheet: Duration
	Length of time one production round takes
		Column: [A] APS: Animal Production System e.g., Pig
		        [B] Level: Productivity level e.g., High
		        [C] HerdTypes: Type of animal e.g., producer or replacement
                        [D] Duration: length of production round [days]
		Source: van Hal, Ollie 2020
			Upcycling biomass in a circular food system – the role of livestock and fish, 
			216 pages. DOI: https://doi.org/10.18174/524412 

AnimalModelGHG.gms
	Description of model can be found in the source code 
		  
Methods, materials and software:
Software required data: Microsoft excel
Software required model: GAMS (general algebraic modelling system) 33.2.0 CBC Solver. Requires license. https://www.gams.com  

This model is published under the CC BY NC SA


