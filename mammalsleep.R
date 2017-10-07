library(faraway)
## summarize dataset
str(mammalsleep) 
summary(mammalsleep) 
head(mammalsleep)
plot(mammalsleep)

complete = na.omit(mammalsleep)
cor(complete)
fit= lm(sleep ~ body+brain + nondream + dream + lifespan + gestation + predation + exposure + danger,
        data = complete)
fit1= lm(sleep ~ body+brain + lifespan + gestation + predation + exposure + danger,
         data = complete)
vif(fit1)
## to use bestglm to select variables
Xy=complete[,c("body","brain","lifespan","gestation","predation","exposure","danger","sleep")]
bestAIC = bestglm(Xy,IC="AIC")
bestAIC
summary(bestAIC)
bestBIC = bestglm(Xy,IC="BIC")
bestBIC
summary(bestBIC)
dreamreg=complete[,c("body","brain","lifespan","gestation","predation","exposure","danger","dream")]
bestbicdream = bestglm(dreamreg,IC="BIC")
bestbicdream
summary(bestbicdream)
nondreamreg=complete[,c("body","brain","lifespan","gestation","predation","exposure","danger","nondream")]
bestbicnondream = bestglm(nondreamreg,IC="BIC")
bestbicnondream
summary(bestbicnondream)

## added value plot
# regression without predation
sleep_dang_gest = lm(sleep~ gestation + danger, data = complete)
e1 = resid(sleep_dang_gest)

# regression without sleep
predate_dang_gest = lm(predation ~ gestation + danger, data = complete)
e2 = resid(predate_dang_gest)

plot(e1,e2)
#################################

best = lm(sleep~ gestation + predation + danger, data= complete)
plot(best)

#### remove 3 outliers and 1 high leverage point
short_complete = complete[-c(5,7,33,42),]
short_best = lm(sleep~ gestation + predation + danger, data = short_complete)
summary(short_best)

