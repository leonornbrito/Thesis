•	Title of the dataset: 
Data and R code for the paper The potential of future foods for sustainable and healthy diets

•	Creator(s) with affiliation(s):
Alejandro Parodi 1 - ORCID 0000-0003-1351-138X
Adrian Leip 2 – ORCID 0000-0001-7616-5029
Imke J.M. De Boer 1 - ORCID 0000-0002-0675-7528
Petronella M. Slegers 3 – ORCID 0000-0002-2464-7517
Friederike Ziegler 4 – ORCID 0000-0001-7547-7039
Elisabeth H.M. Temme 5 – ORCID 0000-0002-0164-0662
Mario Herrero 6 – ORCID 0000-0002-7741-5090
Hanna Tuomisto 7 – ORCID 0000-0003-1640-490X
Hugo Valin 8 – ORCID 0000-0002-0618-773X
Corina E. Van Middelaar 1 – ORCID 0000-0002-6835-998X
Joop J.A. Van Loon 8 - ORCID 0000-0002-4260-0501
Hannah H.E. Van Zanten 1 - ORCID 0000-0002-5262-5518

1  Animal Production Systems Group, Wageningen University & Research, Wageningen, The Netherlands. 
2  European Commission, Joint Research Centre, Ispra, Italy. 
3  Operations Research and Logistics, Wageningen University & Research, Wageningen, The Netherlands. 
4  Agrifood and Bioscience, RISE Research Institutes of Sweden, Gothenburg, Sweden. 
5  National Institute for Public Health and the Environment (RIVM), Bilthoven, The Netherlands. 
6  Commonwealth Scientific and Industrial Research Organisation (CSIRO), St Lucia, Queensland, Australia. 
7  Department of Agricultural Sciences, Faculty of Agriculture and Forestry, University of Helsinki, Helsinki, Finland. 
7  Helsinki Institute of Sustainability Science (HELSUS), University of Helsinki, Helsinki, Finland. 
7  Natural Resources Institute Finland (Luke), Helsinki, Finland. 
8 Ecosystems Services and Management Program, International Institute for Applied Systems Analysis, Laxenburg, Austria.
9 Laboratory of Entomology, Wageningen University & Research, Wageningen, The Netherlands. 

•	Description (short, 2-3 sentences)
Contains data and R code for analysis and visualizations of the study The potential of future foods for sustainable and healthy diets

•	Keywords
Future foods, GHG, land use, protein, minerals, vitamins, LCA, diets, livestock, seafood

•	Related publication
Parodi, A., Leip, A., De Boer, I. J. M., Slegers, P. M., Ziegler, F., Temme, E. H., ... & Van Zanten, H. H. E. (2018). The potential of future foods for sustainable and healthy diets. Nature Sustainability, 1(12), 782-789. https://doi.org/10.1038/s41893-018-0189-7 

•	Spatial coverage (if applicable)
Not applicable
•	Temporal coverage (if applicable)
Not applicable

•	License
This dataset is published under the CC BY-SA (Attribution ShareAlike) license.


---------------------------------------------------------------------------


This dataset contains the following files:

1. Parodi et al. 2018_FutureFoods.R
   Contains R code for data analysis and visualizations

2. Nutritional_ff.csv
   Nutrient content of diverse future foods

4. Envimpacts_ff.csv
   Environmental impacts of diverse future foods and seafood

5. Leip_impacts.csv
   Environmental impacts of diverse animal-source foods and plant-source foods.

6. requirements.csv
   Daily requirements of diverse humans


Explanation of columns in each dataset:

Nutritional_ff.csv
#[1] Component - Name of the component or nutrient
#[2] Units - Units in which the value is shown
#[3] Author - Last name and year of the source revised to extract the value
#[4] Species - Type of food
#[5] Weight - Dry weight or fresh weight
#[6] Feed - Additional information about the value extracted including type of diet, treatment, source.
#[7] Typefood - Future foods or animal source foods
#[8] Value - Nutrient value for component specified in column [1] in units specified in column [2]. Some nutrients contain NA values because data was not available for those nutrients in the cited studies.
#[9] concatenate - concatenate of Author_Species_Weight_Typefood


Envimpacts_ff.csv
#[1] Study - Study from which the data was extracted (Author and year)
#[2] Functional_unit - Functional unit in which the environmental impact is expressed
#[3] Typeweight - Fresh or dry weight
#[4] Species - Name of the food
#[5] Feed_or_place - Additional specification regarding the type of species
#[6] Impact - Type of environmental impact and units (Global warming potential, Land use and Energy use)
#[7] Impact_dm_edible - Value of the impact
#[8] Watercontent - Water content in % relative to the fresh weight. It is used to calculate the impact per dry matter product.

Leip_impacts.csv
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


#Explanation of acronyms in column [3] 'Source'.
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



requirements.csv
#[1] Component - Name of the nutrient & units
#[2] Requirement - Value for each nutrient requirement on a daily basis

...

Methods, materials and software:
Sofware: 
R version 4.0.3 (2020-10-10)
RStudio version desktop 1.3.1093 “Apricot Nasturtium
...
