
# how to use gbif with R: https://www.youtube.com/watch?v=RACfDLBIL8A

# comparison gbif dataset for Antigone rubicunda (eine Reiher art)  
# https://www.gbif.org/species/9295466
# GBIF.org (09 June 2021) GBIF Occurrence Download https://doi.org/10.15468/dl.6m2srw

library(raster)

#gbif_antigone <- xmlParse(file= "data/gbif/antigone_rubicunda/dataset/4fa7b334-ce0d-4e88-aaae-2e0c138d049e.xml")
#str(gbif_antigone)
#plot(gbif_antigone)

antigone_occ = read.table("data/gbif/antigone_rubicunda/occurrence.txt")

# trying rgbif
# https://damariszurell.github.io/HU-GCIB/1_Data.html
# https://cran.r-project.org/web/packages/rgbif/rgbif.pdf

# Check out the number of occurrences found in GBIF:
occ_count()

# number of observations:
occ_count(basisOfRecord='OBSERVATION')

# number of occurrences reported for Germany:
occ_count(country=isocodes[grep("Germany", isocodes$name), "code"])

# number of observations reported for Germany:
occ_count(country=isocodes[grep("Germany", isocodes$name), "code"],basisOfRecord='OBSERVATION')

# adjusted for antigone
# Check for synonyms
name_suggest(q='Antigone rubicunda', rank='species') # -> no synonyms


# get info on species name
name_antigone = name_lookup(query = "Antigone rubicunda", rank = "species")
name_antigone$hierarchies
name_indonesia = name_lookup("Indonesia")
name_indonesia

# Check number of records
#occ_search(scientificName = "Antigone rubicunda", limit = 10)

# downloading and plotting
# gbif_antigone <- occ_search(scientificName = "Antigone rubicunda",return='data', limit=500)
antigone_key <- name_suggest('Antigone rubicunda')$data[1]
antigone_key
# dat <- occ_search(taxonKey = occ_key, limit = 3, hasCoordinate = TRUE)
# head( elevation(dat$data, username = user) )

#dat$data
#str(dat)
#plot(dat)

# ?rgbif
#points(gbif_antigone$decimalLongitude, gbif_antigone$decimalLatidute, col = "red")
#str(gbif_antigone)
#head(gbif_antigone)

# example use uf dataset_metrics
#dataset_metrics(uuid='863e6d6b-f602-4495-ac30-881482b6f799')

# Fetch aggregated density maps of GBIF occurrences
antigone_map = map_fetch(taxonKey = 9295466, year = 1950:2000)
plot(antigone_map)

#mvt_fetch(taxonKey = 166389564)

nrow(species)

# drop Amaurornis moluccanus/Amaurornis moluccana (#33)
# drop Threskiornis molucca/Threskiornis moluccus (#526)
species = species[-c(33,526),]

for (i in 1:nrow(species)) {
  print(i)
  print(species$species[i])
  species$key[i] = name_suggest(species$species[i])$data[1]
}

test_key = species$key[60][[1]]
str(test_key)

# country = "Indonesia",
test_map2 = map_fetch(taxonKey = 9295466)
test_map
plot(test_map)
plot(test_map2, add = T)
test_map = map_fetch(taxonKey = 2480498)
                     