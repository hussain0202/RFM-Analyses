library(dplyr)
r_sales<-sales
View(r_sales)

r_sales$order_date<- as.Date(r_sales$order_date, "%Y-%m-%d")

analysis_date <- max(r_sales$order_date)
rfm_df <- r_sales %>% 
  group_by(cust_id) %>% 
  dplyr::summarise(Recency = as.integer(analysis_date- max(order_date)), Frequency = n(), Monetary = sum(total))

nrow(rfm_df)
View(rfm_df)

library(gridExtra)

#distribution of the three quantities calculated here.

r <- ggplot(rfm_df) +geom_density(aes(x= Recency))
f <- ggplot(rfm_df) +geom_density(aes(x = Frequency))
m <- ggplot(rfm_df) +geom_density(aes(x = Monetary))
View(m)
grid.arrange(r, f, m, nrow = 3)

summary(rfm_df)


rfm_df$R_score <- 0

rfm_df$R_score[rfm_df$Recency >= 277.0] <- 1
rfm_df$R_score[rfm_df$Recency >= 187.0 & rfm_df$Recency <277.0] <- 2
rfm_df$R_score[rfm_df$Recency >= 133.0 & rfm_df$Recency <187.0] <- 3
rfm_df$R_score[rfm_df$Recency < 133.0] <- 4

rfm_df$F_score<- 0

rfm_df$F_score[rfm_df$Frequency >=4] <- 4
rfm_df$F_score[rfm_df$Frequency <4 & rfm_df$Frequency >= 2.0] <- 3
rfm_df$F_score[rfm_df$Frequency <2.0 & rfm_df$Frequency >= 1.0] <- 2
rfm_df$F_score[rfm_df$Frequency <1.0] <- 1

rfm_df$M_score <- 0

rfm_df$M_score[rfm_df$Monetary >= 2348.5] <- 4
rfm_df$M_score[rfm_df$Monetary < 2348.5 & rfm_df$Monetary >= 467.9] <- 3
rfm_df$M_score[rfm_df$Monetary >= 127.5 & rfm_df$Monetary < 467.9] <- 2
rfm_df$M_score[rfm_df$Monetary <127.5] <- 1


rfm_df <- rfm_df %>% mutate(RFM_score = 100 *R_score +10 * F_score + M_score)


rfm_df$Segment <- "0"
rfm_df$Segment[which(rfm_df$RFM_score %in% c(444,434,443, 344, 442, 244, 424, 441  ))] <-"Loyalists"
rfm_df$Segment[which(rfm_df$RFM_score %in% c(332,333,342, 343, 334, 412,413,414,431,432,441,421,422,423, 424, 433 ))] <- "Potential Loyalists"
rfm_df$Segment[which(rfm_df$RFM_score %in% c(233,234, 241,311, 312, 313,314,321,322,323,324, 331,  341))] <- "Promising"
rfm_df$Segment[which(rfm_df$RFM_score %in% c(124, 133, 134, 142, 143, 144, 214,224,234, 242, 243, 232 ))] <- "Hesitant"
rfm_df$Segment[which(rfm_df$RFM_score %in% c(122, 123,131 ,132, 141, 212, 213, 221, 222, 223, 231 ))] <- "Need attention"
rfm_df$Segment[which(rfm_df$RFM_score %in% c(111, 112, 113, 114, 121, 131, 211, 311, 411 ))] <-"Detractors"

table(rfm_df$Segment)

library(plotrix)
x <- table(rfm_df$Segment)
View(x)
piepercent<- round(100*x/sum(x), 1)
lbls = paste(names(x), " ", piepercent,"%")
pie(x, labels = lbls, main = "Pie chart for Customer Segments", explode = 0.1)