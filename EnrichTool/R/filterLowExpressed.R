# This function removes genes that have very low counts.
# Basically, it checks how many counts each gene has in total,
# and if the count is too small, we drop that gene.
# You can change the minimum count if you want (default is 10).


filterLowExpressed <- function(count_data, min_count = 10) {

  # remove genes that don't have enough counts
  keep <- rowSums(count_data) >= min_count
  
  # keep only the rows that passed the filter
  filtered_data <- count_data[keep, ]
  
  return(filtered_data)
}
