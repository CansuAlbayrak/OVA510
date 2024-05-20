install.packages("dplyr")
install.packages("networkD3")
library(networkD3)
library(dplyr)

# connection data frame 
links <- data.frame(
  source=c("1990lar","1990lar","2000ler","2000ler","2000ler","2000ler",
           "2010lar", "2010lar", "2010lar", "2010lar", "2020ler","2020ler",
           "2020ler","2020ler","İlkbahar", "Sonbahar", "Kış", "Sonbahar", "İlkbahar", 
           "Sonbahar", "Kış", "Yaz", "Kış", "Yaz", "İlkbahar", "Sonbahar"), 
  target=c("Kış","Yaz", "İlkbahar", "Yaz", "Sonbahar", "Kış", "İlkbahar", "Yaz", "Sonbahar",
           "Kış", "İlkbahar", "Yaz", "Sonbahar", "Kış","Afrika", "Afrika", "Amerika", "Amerika", 
           "Asya", "Asya", "Asya", "Asya", "Avrupa", "Avrupa", "Avrupa", "Avrupa"), 
  value=c(3,1,3,2,4,14,8,7,15,8,2,3,5,2,3,2,1,4,3,4,2,6,24,7,7,14)
)

# node data frame
nodes <- data.frame(
  name=c(as.character(links$source), 
         as.character(links$target)) %>% unique()
)

# With networkD3 connection must be provided using id
links$IDsource <- match(links$source, nodes$name)-1 
links$IDtarget <- match(links$target, nodes$name)-1



# prepare color scale
my_color <- 'd3.scaleOrdinal() .domain(["1990lar", "2000ler", "2010lar", "2020ler",
              "İlkbahar", "Yaz","Sonbahar", "Kış", 
              "Asya", "Avrupa", "Afrika", "Amerika"]) .range(["#B19CD9", "lightblue","pink", "orange", 
              "#00ff7f", "yellow" , "#994900", "white", 
    "#599ad3", "#f9a65a", "#79c36a", "#d77fb3"])'

# Make the Network
p <- sankeyNetwork(Links = links, Nodes = nodes, Source = "IDsource", Target = "IDtarget", fontSize = 14, nodeWidth = 12,
                   Value = "value", NodeID = "name", colourScale=my_color)
p

