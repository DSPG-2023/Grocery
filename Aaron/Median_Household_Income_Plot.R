## Function that takes the big dataframe as an argument ##


plot_median_household <- function(df) {

  library(dplyr)
  library(ggplot2)

  ## Filtering County df for variable Median Household Income

  reduced_df <- df %>% filter(variable=="B19013_001")

  ## Quick math for graph scaling figure and margin of error bars

  max1 <- max(reduced_df$estimate) + (min(reduced_df$estimate)/3)

  ymin <- reduced_df$estimate - reduced_df$moe
  ymax <- reduced_df$estimate + reduced_df$moe

  ## Make plot object

  p <- reduced_df %>%
    ggplot(aes(x = NAME, y = estimate, fill = NAME)) +
    geom_bar(stat = 'identity') +
    geom_errorbar(ymin = ymin, ymax = ymax) +
    ggtitle("Median Household Income") +
    scale_x_discrete(labels = NULL, breaks = NULL) +
    scale_y_continuous(limits = c(0, max1), breaks = seq(0, max1, by = 10000)) +
    labs(x = NULL)

## Convert to plotly object

  plot <- plotly::ggplotly(p)

## Show plot

  return(plot)

}


## Test Function ##

median_household_plot <- plot_median_household(result_df)

median_household_plot
