
## ---- Appendix plot. The upper plot (a) shows the basis functions for the restricted cubic splines approach - 
##     using 5 knots placed at 5%, 27.5%, 50%, 72.5% and 95% quantiles, and the lower plot 
##     (b) shows the basis functions for a 2nd degree B-splines using 4 equidistant knots; 
##      2 inner knots plus the boundaries, placed on 0, 0.33, 0.66, 1 values. 




### 
### Assuming a uniformally distributed continuous variable x [0,1]
x= seq.int(0, 1, length.out = 100)


### We calculate the knots positions based on Harrel's suggestion for 5 knots.

knots.x.4 = quantile(x, probs = c(0.05,0.275,0.5,0.725,0.95))

x.4 <- rcspline.eval (seq(0,1, .01),knots =knots.x.4, inclx =T)


autoplot.zoo =  zoo(x.4)
index(autoplot.zoo)= (index(autoplot.zoo)-1)/100

p4 = autoplot(autoplot.zoo, facet = NULL) + geom_line(size=1.5)+theme_bw()+xlab("")+
  geom_vline(xintercept = knots.x.4, linetype =2)+ 
  scale_color_discrete(name = "Basis \n functions",labels = c(expression(B[1]), expression(B[2]), expression(B[3]), expression(B[4])))+
  theme(plot.title    = element_text(hjust = 0.5,size = 26,face = "bold.italic"),
        plot.subtitle = element_text(hjust = 0.5,size = 18,face = "bold.italic"),
        axis.text.x.bottom  = element_text(angle = 0, vjust = 0.5, size=20),
        axis.text.y.left    = element_text(angle = 0, vjust = 0.5, size=20),
        plot.margin = unit(c(0,0,0,0), "cm"),
        panel.spacing = unit(0, "lines"),
        strip.text = element_text(face="bold", size=16, hjust = 0.5),
        axis.title.y = element_text(size = 30),
        axis.title.x = element_text(size = 18),
        axis.text.y = element_text(face="bold",  size=18),
        legend.key.size = unit(1.5, "cm"),
        legend.key.width = unit(1.5,"cm"),
        legend.text=element_text(size=20, hjust = 0), 
        legend.title =element_text(size=28, hjust = 0.5),
        legend.position = "right") + 
  annotate("text",x = 0.1,y=0.9, size = 16, label = "a")+ylim(c(0,1))

p4

### B-splines basis-functions 
## The calculation is based on splines2 bSpline function. 


knots <-  c(0.33,0.66)


bsMat <- data.frame(splines2::bSpline(x,Boundary.knots = c(0,1), knots = knots, degree = 2, intercept = TRUE))

bsMat2.df= data.frame( Value= c(bsMat$X1,bsMat$X2,bsMat$X3,bsMat$X4,
                                bsMat$X5), 
                       `Basis function ID` =rep(paste("Basis",1:5),
                                                each = dim(bsMat)[1]),
                       x = x)

bsMat2.plot = ggplot(bsMat2.df, aes(Value,x = x, color= Basis.function.ID))+ geom_line(size=2)+
  theme_bw()+  ylab("")+ 
  scale_color_discrete(name = "Basis \n functions",labels = c(expression(B[1]), expression(B[2]), expression(B[3]), expression(B[4]), expression(B[5]), expression(B[6]), expression(B[7]), expression(B[8])))+
  geom_vline(xintercept = knots, linetype =2)+
  theme(plot.title    = element_text(hjust = 0.5,size = 26,face = "bold.italic"),
        plot.subtitle = element_text(hjust = 0.5,size = 18,face = "bold.italic"),
        axis.text.x.bottom  = element_text(angle = 0, vjust = 0.5, size=20),
        axis.text.y.left    = element_text(angle = 0, vjust = 0.5, size=20),
        plot.margin = unit(c(0,0,0,0), "cm"),
        panel.spacing = unit(0, "lines"),
        strip.text = element_text(face="bold", size=16, hjust = 0.5),
        axis.title.y = element_text(size = 30),
        axis.title.x = element_text(size = 30),
        axis.text.y = element_text(face="bold",  size=18),
        legend.key.size = unit(1.5, "cm"),
        legend.key.width = unit(1.5,"cm"),
        legend.text=element_text(size=20, hjust = 0), 
        legend.title =element_text(size=28, hjust = 0.5),
        legend.position = "right") + 
  annotate("text",x = 0.1,y=0.9, size = 16, label = "b")+ylim(c(0,1))



grid.arrange(p4, bsMat2.plot)
