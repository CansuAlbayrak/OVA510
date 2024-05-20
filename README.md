# WANDERLUST: Seyahat Tutkusu
Wanderlust, Dünyayı dolaşmak, farklı ülkeler gezmek, yeni yerler keşfetmek için 
karşı konulmaz bir istek duymak anlamında Almanca kökenli bir ifade. Ben de Veri 
Görselleştirme dersimin poster ödevi vesilesiyle, 11 yaşımda İngiltere’ye dil 
öğrenimi için gittiğim 1 aylık seyahatim ile tohumları atılan Wanderlust’ımın 
bugün beni getirdiği yere dair sizleri verisel bir seyahate çıkaracağım.

Bu çalışmada temel veri seti olarak elimde 1998 yılından itibaren sahip olduğum 
ve bir tanesi 2032 yılına kadar geçerliliği süren 4 farklı pasaportumun üzerindeki 
vizeler ile giriş çıkışlarımı gösteren ülke damgalarını kullandım. Bunlara ek olarak 
damga basmayan bazı ülkeler (Küba gibi) veya bir ülkeden diğerine geçişler (özellikle 
Avrupa içerisinde) gibi durumlarda ise tuttuğum gezi günlüklerimden faydalandım. Bu 
kaynaklar sonucunda elimde 1998 ve 2024 yılları arasında gerçekleştirdiğim 78 seyahate 
dair seyahat ettiğim ülke, ay, yıl ve kalış süresi gösteren veri setini, bu bilgilere 
dayanarak seyahat edilen mevsim ve kıta bilgilerini de ekleyerek zenginleştirdim. Aynı 
zamanda yine bu veri setine seyahat edilen ay ve yıla göre
https://tr.investing.com/currencies/usd-try-historical-data sitesinden faydalanarak 
ilgili döneme ait Dolar/Türk Lirası döviz kurunu ekledim. (2004 yılı öncesi döviz 
kurlarını sonraki yıllarla karşılaştırılabilir olması ve veri analizini kolaylaştırmak 
açısından 6 sıfır atarak kullandım)

# Grafikler
## Yaşlara Göre Kümülatif Gezilen Ülke ve Kıta Sayıları

```

install.packages("ggplot2")
install.packages("dplyr")
install.packages("reshape2")
library(ggplot2)
library(reshape2)
library(dplyr)

x <- line$Yaş
y1 <- c(1, 4, 4, 4, 4, 4, 4, 4, 4, 7, 11, 19, 19, 22, 24, 25, 29, 38, 39, 41, 43, 43, 43, 45, 45, 48, 49)
y2 <- c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4)
#Combine data into a data frame
data <- data.frame(
  Yaş = x,
  y1 = y1,
  y2 = y2)

#Convert data to long format using melt from reshape2
data_long <- melt(data, id.vars = "Yaş", variable.name = "Line", value.name = "Value")

#Plotting with ggplot2
ggplot(data_long, aes(x = Yaş, y = Value, fill = Line)) +
  geom_area(alpha = 0.4, position = "identity") +
  geom_line(aes(color = Line), size = 1) +
  scale_fill_manual(values = c("y1" = "#CC9933", "y2" = "#669933"), 
                    labels = c("Ülke", "Kıta"),
                    breaks = c("y1", "y2"),
                    name = NULL) +
  scale_color_manual(values = c("y1" = "#CC9933", "y2" = "#669933"), 
                     labels = c("Ülke", "Kıta"),
                     breaks = c("y1", "y2"),
                     name = NULL) +
  labs(x = "Yaş", y = "Ülke ve Kıta", title = "Yaşlara Göre Toplam Gezilen Ülke ve Kıta Sayıları") +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14), # Center the plot title and adjust size
    panel.grid.major = element_blank(),
    axis.text.x = element_text(size = 10),
    legend.text = element_text(size = 12) ) +
  xlim(10, 40)  # Limit x-axis between 10 and 40


```


![image](https://github.com/CansuAlbayrak/OVA510/assets/170354634/02c8d3a2-b7a4-4a6a-aae5-a500d63cc7a7)

İlk yurtdışı seyahatimi 1998 yılında 11 yaşımdayken  bir aylığına dil öğrenmek için gittiğim İngiltere’ye yaptım. 1 sene sonra Hollanda, Fransa ve Belçika’yı da görme fırsatı elde ettim fakat grafikten de görülebileceği üzere takip eden 6 sene boyunca üniversiteye başladığım döneme kadar tekrar yurtdışına çıkma şansım olmadı. Üniversite öğrencisi olduğum 18-22 yaş dönemi aralığında uluslararası bir sivil toplum örgütü aracılığıyla Avrupa’nın bir çok yerinde insan hakları alanında projelere katılma ve böylelikle de yeni yerler gezme görme şansını elde ettim.  20'li yaşlarımın ortalarından itibaren hedefim her zaman yaşım kadar ülke görmüş olmaktı. Grafiğin bitiş noktası olan 37 yaşımda 48 farklı ülkeyi gezme şansını oldu. 

## Ziyaret Edilen 48 ülke ve her ülkede geçirilen toplam süreler


```

install.packages("ggplot2")
install.packages("dplyr")
install.packages("magick")
library(ggplot2)
library(dplyr)
library(magick)

#Define continent colors
continent_colors <- c("Avrupa" = "#f9a65a", "Amerika" = "#d77fb3", 
                      "Afrika" = "#79c36a", "Asya" = "#599ad3")

#Map colors to Kıta based on the dataset
bar_plot_veri$color <- continent_colors[bar_plot_veri$Kıta]

#Arrange data by gün in descending order using dplyr's arrange function
bar_plot_veri <- dplyr::arrange(bar_plot_veri, desc(gün))

#Convert Ülke to a factor with reversed levels for descending order in the plot
bar_plot_veri$Ülke <- factor(bar_plot_veri$Ülke, levels = rev(bar_plot_veri$Ülke))

#Create the bar plot using ggplot with sorted data
ggplot(bar_plot_veri, aes(x = gün, y = Ülke, fill = Kıta)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(
    name = "Kıtalar",  
    values = continent_colors,  
    labels = c("Afrika", "Amerika", "Asya", "Avrupa")  
  ) +
  labs(x = "Gün", y = "", title = "Ülkelerde Geçirilen Süreler") +
  theme_minimal() +
  #Customize x-axis breaks and labels
  scale_x_continuous(
    breaks = seq(0, max(bar_plot_veri$gün), by = 7),  # Set breaks every 7 days
    labels = seq(0, max(bar_plot_veri$gün), by = 7)  # Set labels as multiples of 7 days
  ) +
  theme(plot.title = element_text(hjust = 0.5))# Center the plot title horizontally


```


![image](https://github.com/CansuAlbayrak/OVA510/assets/170354634/b0efb957-bab2-4e50-8c47-f5c9f1296258)

Bazı ülkeleri defalarca ziyaret edip daha uzun süreler geçirirken, bazı ülkelere sadece tek günlük ziyaretler gerçekleştirebildim. Hollanda’yı en uzun süre kalınan yer yapan şey akrabaların ve arkadaşların sağladığı konaklama imkanları oldu.  Coğrafi yakınlık, dolayısıyla ulaşım kolaylığı nedeniyle en çok ziyaret ettiğim ve en uzun süre zaman geçirdiğim kıta Avrupa kıtası olmakla beraber keşif dürtüsü diğer kıtaları da merak edip yollara düşmeme sebep oldu.

## En Çok Gezilen Kıta: Avrupa Haritası


```

install.packages("sf")
install.packages("rnaturalearth")
install.packages("rnaturalearthdata")
install.packages("ggplot2")
install.packages("ggpattern")

library(ggplot2)
library(sf)
library(rnaturalearth)
library(dplyr)
library(ggpattern)


#Retrieve world map data
world <- ne_countries(scale = "medium", returnclass = "sf")

#Define countries of Europe
countries_of_europe <- c("United Kingdom", "Germany", "Austria", "Belgium", "Bosnia and Herzegovina", "Czechia", 
                         "Denmark", "Finland", "France", "Croatia", "Netherlands", "Spain", "Sweden", "Switzerland", 
                         "Italy", "Cyprus", "Hungary", "North Macedonia", "Malta", "Poland", "Portugal", "Romania", 
                         "Republic of Serbia", "Slovakia", "Slovenia", "Ukraine", "Greece", "Latvia", "Lithuania", "Russia")

#Filter world map data for Europe
europe <- world[world$admin %in% countries_of_europe, ]

#Create a column for nudging the y-axis and fill pattern
europe <- europe %>%
  mutate(nudge_y = case_when(
    admin == "Bosnia and Herzegovina" ~ -0.5,
    admin == "Republic of Serbia" ~ -0.1,
    TRUE ~ 0
  ),
  fill_color = case_when(
    admin == "Latvia" ~ "transparent",
    admin == "Lithuania" ~ "transparent",
    TRUE ~ "#FF6600"
  ),
  pattern = case_when(
    admin == "Latvia" ~ "stripe", 
    admin == "Lithuania" ~ "stripe",
    TRUE ~ "none"
  ))

#Plot world map and zoom into Europe
ggplot() +
  geom_sf(data = world, fill = "#d3d3d3") +
  geom_sf_pattern(data = europe, aes(fill = fill_color, pattern = pattern), 
                  pattern_density = 0.1, pattern_spacing = 0.01, pattern_fill = "#669900") + # Adjust pattern_density
  geom_sf_label(data = europe, aes(label = admin), nudge_y = europe$nudge_y, size = 2.5, color = "#663300", fontface = "bold") +
  scale_fill_identity() + 
  scale_pattern_identity() +
  theme_void() +
  coord_sf(xlim = c(-10, 40), ylim = c(35, 70))  # Adjust viewport to focus on Europe


```

![image](https://github.com/CansuAlbayrak/OVA510/assets/170354634/d5cfb01b-146a-458b-91df-25bcff973cba)

En çok ülkesini görme şansı elde ettiğim ve yıllar içerisinde en çok zaman geçirdiğim kıta Avrupa olduğu için burada ziyaret ettiğim ülkeleri gösteren bu haritayı oluşturdum. Çizgili gösterilen yerler de önümüzdeki hafta ziyaret etmeyi planladığım ülkeler.

## Hangi 10yılda hangi mevsimlerde seyahat edilmiş ve hangi kıtalar için hangi mevsimler tercih edilmiş


```

İnstall.packages(“dplyr”)
install.packages("networkD3")
library(networkD3)
library(dplyr)

#connection data frame 
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

#node data frame
nodes <- data.frame(
  name=c(as.character(links$source), 
         as.character(links$target)) %>% unique()
)

#With networkD3 connection must be provided using id
links$IDsource <- match(links$source, nodes$name)-1 
links$IDtarget <- match(links$target, nodes$name)-1



#prepare color scale
my_color <- 'd3.scaleOrdinal() .domain(["1990lar", "2000ler", "2010lar", "2020ler",
              "İlkbahar", "Yaz","Sonbahar", "Kış", 
              "Asya", "Avrupa", "Afrika", "Amerika"]) .range(["#B19CD9", "lightblue","pink", "orange", 
              "#00ff7f", "yellow" , "#994900", "white", 
    "#599ad3", "#f9a65a", "#79c36a", "#d77fb3"])'

#Make the Network
p <- sankeyNetwork(Links = links, Nodes = nodes, Source = "IDsource", Target = "IDtarget", fontSize = 14, nodeWidth = 12,
                   Value = "value", NodeID = "name", colourScale=my_color)
P


```

![image](https://github.com/CansuAlbayrak/OVA510/assets/170354634/a6bc77eb-1f76-490f-a666-05163d6bfb6e)

 90'lı yıllarda, yani hala lise öğrencisi olduğum zamanlarda tek seçeneğim yaz ve sömestr tatillerinde (kış) seyahat etmekti. 2000'li yıllarda üniversite döneminde daha çok kışın seyahat etmiş olmamın sebebi ise, okulların açık olduğu dönemde yürüttüğümüz projeler ile seyahat etmiş olmam. Güney Amerika seyahtlerini planlarken de Türkiye’de kış veya sonbahar mevsimi soğuklarından kaçıp oralardaki sıcak havanın tadını çıkarmayı seçtiğim de bu grafikten anlaşılabiliyor.

 ## Yıllara göre ortalama kur ve ortalama yurtdışında kalınan süre değişimleri


```

library(ggplot2)
library(dplyr)

# Calculate average XR and gün per year
exchange_avg <- nokta %>%
  group_by(Yıl) %>%
  summarise(AvgXR = mean(XR),
            Avggün = mean(gün))

# Define a vector of new values
ülke <- c("1", "3","0","0","0","0","0","1", "1", "4","8", "9", "1", "3", "2","2", "6", "10", 
          "1", "4","3", "6","0", "2", "2", "5", "3")


# Add a new column with the new values
exchange_avg$new_column <- ülke


# Plotting both lines on the same plot
ggplot(exchange_avg, aes(x = Yıl)) +
  geom_line(aes(y = AvgXR, color = "Average Exchange Rate"), size = 1.2) +
  geom_line(aes(y = Avggün, color = "Average Days"), linetype = "dashed", size = 1.2) +
  labs(x = "", y = "", title = "Yıllara Göre Ortalama Kur ve Yurtdışında Ortalama Kalınan Gün") +
  scale_color_manual(values = c("blue", "orange"), 
                     labels = c("Ortalama Kur ($)", "Ortalama Kalış"),
                     breaks = c("Average Exchange Rate", "Average Days") ,
name = NULL) +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title


```


![image](https://github.com/CansuAlbayrak/OVA510/assets/170354634/ddae7697-e2d3-4969-9829-165985615500)

Yandaki grafikten de anlaşılacağı üzere dolar kuru ve seyahat süreleri arasında anlamlı bir korelasyon bulunmuyor.  2007- 2011 yılları arasına denk gelen 20'li yaşlarımda projelerin kaynakları, interrail ve couchsurfing gibi seyahat imkanlarından faydalanmış olmam bu etkilenmeme durumunu açıklayabilir. Aynı zamanda iş hayatına atıldığım 2011 yılı sonrasında ‘yıllık izin süremin’ yurtdışında ortalama kalış süresine kur değişimlerine nazaran daha çok etki etmiş olabileceği görülüyor.





