library(ggplot2)
library(dplyr)
library(stringr)
library(plotly)


decennialList = c("White" = "P1_003N", "Black" = "P1_004N", "American Indian/Alaskan Native" = "P1_005N",
             "Asian" = "P1_006N", "Native Hawaiian/Pacific Islander" = "P1_007N", "Other" = "P1_008N",
             "Total" = "P2_001N", "Hispanic/Latino" = "P2_002N", "Not_Hispanic/Latino" = "P2_003N")

plot_race_ethnicity <- function(df) {

  library(dplyr)
  library(ggplot2)

  ## Filtering decennial df for race/ethnicity

  reduced_df <- df %>% filter(variable %in% c("White", "Black", "American Indian/Alaskan Native",
                                              "Asian","Native Hawaiian/Pacific Islander", "Other"))

  p <- reduced_df %>%
    ggplot(aes(x = NAME, y = value, fill = variable)) +
    geom_bar(stat = "identity", position = "fill") +
    xlab("County") +
    ylab("Race/Ethnicity") +
    coord_flip()

  plot <- plotly::ggplotly(p)

  return(plot)

}

## Test Function ##

race_ethnicity_plot <- plot_race_ethnicity(decennial_df)

race_ethnicity_plot

