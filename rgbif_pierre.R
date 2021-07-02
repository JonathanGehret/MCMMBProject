# rgbif_pierre code:
#How to retrieve GBIF data from R:
#  https://data-blog.gbif.org/post/downloading-long-species-lists-on-gbif/
  
sp1 <- "NAME of your species"
sp1_id <- taxize::get_gbifid_(sci = sp1, method = "backbone")
sp1_id <- sp1_id[[1]]

# Some controls: accepted names and plant kingdom
sp1_id <- sp1_id[which(sp1_id$matchtype == "EXACT" &
                         sp1_id$status == "ACCEPTED" &
                         sp1_id$kingdom == "Plantae"), ]


# Downloading occurrences from GBIF using this taxon key
sp1_gbif <- occ_download(pred_in("taxonKey", sp1_id$usagekey),
                         format = "SIMPLE_CSV",
                         user = "",
                         pwd = "",
                         email = "")

# Retrieve download
sp1_download <- occ_download_get(
  key = as.character(sp1_gbif),
  path = "your_path/",
  overwrite = TRUE)

sp1_dat <- occ_download_import(sp1_download) %>%
  dplyr::filter(occurrenceStatus == "PRESENT") %>%
  dplyr::select(species, decimalLongitude, decimalLatitude) %>%
  dplyr::filter(!is.na(decimalLongitude))
