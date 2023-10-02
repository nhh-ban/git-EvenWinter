# ----------------------
# BAN400 - Assignment
# Problem 2
# ----------------------

# Loading packages --------
library(tidyverse)



# Problem 2 --------

## Importing data to memory --------
raw_data <- readLines('raw/suites_dw_Table1.txt', warn = F)


## Cleaning up data --------

# Storing variable descriptions in separate text file.
raw_data[(1:11)] %>% 
  writeLines('processed/variable_descriptions.csv')

# Tidying data.
raw_data %>% 
  .[-(14)] %>%                   # Removing separator line.
  .[-(1:12)] %>%                 # Removing variable descriptions.
  gsub(" ", "", .) %>%           # Removing empty spaces.
  gsub("\\|", ",", .) %>%        # Replacing vertical bars with commas.
  writeLines('processed/tidy_galaxy.csv')  # Creating new, tidied csv file. 

# Creating data frame from new, tidied data.
tidy_galaxy <- read_csv('processed/tidy_galaxy.csv')



# Problem 3 --------


## Creating plot --------

# Creating a plot to analyse sample distribution. 
sample_analysis_plot <- tidy_galaxy %>% 
  ggplot() +
  
  # Making a scatter plot with log_m26 (log of indicative galaxy mass) on the
  # x axis, and a_26 (galaxy diameter) on the y axis. The points are
  # colored according to m_b (absolute magnitude) values.
  geom_point(aes(x = log_m26, y = a_26, color = m_b)) +
  
  # Changing title, and axis labels.
  labs(title = "Galaxy Diameter and Indicative Mass",
       x = "log of Indicative Galaxy Mass",
       y = "Galaxy Diamater"
  ) +
  
  # Changing color gradient.
  scale_color_gradient(low = "red", high = "yellow", 
                       name = "Absolute\nMagnitude") +
  
  # Starting the x axis at 0 to highlight the under-representation of smaller
  # (lower massed) galaxies. 
  coord_cartesian(xlim = c(0, NA)) +
  
  # Adding more tick marks to y axis. 
  scale_y_continuous(breaks = seq(0, 100, by = 10))
  
# Saving plot
ggsave("results/sample_analysis_plot.png")


## Displaying plot + answer --------

# Displaying plot. 
sample_analysis_plot 

# The plot clearly shows that that no galaxies with a log of indicative mass of
# less than approximately 5 are represented in the data set. The reason for this
# might be that smaller objects generally have a more faint absolute magnitude,
# making them more difficult to detect and observe. The plot also seems to
# substantiate the assumption.






