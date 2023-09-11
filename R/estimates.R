#' Title
#'
#' @param data1  Data frame consisting var1 area membership variable, var 2 the study variable....
#' @param data2   Data frame consisting var1 area membership variable, var 2 the study variable....
#' @param D   a vector consisting list of areas in numeric form
#' @param n1  sample size selected at first occasion
#' @param n2 sample size selected at second occasion
#' @param Si The weight parameter for synthetic estimator  (by defualt si=0.5) 
#' @param lmda_1 The weight parameter used in Strategy 2 and Strategy 3 (by default lmda_1=0.5)
#' @param strategy  The strategy used for estimation  (by default it will provide result under direct_s1)
#' @param sim   Number of bootstrap replication to obtain standard error
#'
#' @return The values of estimates, standard errors and 95% C.I 
#' @export
#'
#' @examples  
#' #Example 1: Result with strategy=direct_s1 
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4)), c(1,2,3),
#' 30, 30,0.3,0.5, strategy='direct_s1',100)
#' #Example 2 Result with strategy=direct_s1  
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='direct_s2',100)
#'#Example 3 Result with strategy=weighted_s1  
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='weighted_s1',100)
#'#Example 4 Result with strategy=weighted_s2 
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='weighted_s2',100)
#'#Example 5 Result with strategy=poststratified_s1  
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), weight_1=runif(100), stratum_1=c(rep(1,50), rep(2,50))),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), weight_2=runif(100), stratum_2=c(rep(1,50), rep(2,50))), c(1,2,3), 30, 30,0.3,0.5, strategy='poststratified_S1',100)
#'#Example 6 Result with strategy=poststratified_s2 
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), weight_1=runif(100), stratum_1=c(rep(1,50), rep(2,50))),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), weight_2=runif(100), stratum_2=c(rep(1,50), rep(2,50))), c(1,2,3), 30, 30,0.3,0.5, strategy='poststratified_S2',100)
#'#Example 7 Result with strategy=regression_s2
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='regression_s2',100)
#'#Example 8 Result with strategy=ratio_s2
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='ratio_s2',100)
#'#Example 9 Result with strategy=composite_regression_s2
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_regression_s2',100)
#'#Example 10 Result with strategy=composite_ratio_s2
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_ratio_s2',100)
#'#Example 11 Result with strategy=regression_s3
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='regression_s3',100)
#'#Example 12 Result with strategy=ratio_s3
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='ratio_s3',100)
#'#Example 13 Result with strategy=composite_regression_s3
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_regression_s3',100)
#'#Example 14 Result with strategy=composite_ratio_s3
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_ratio_s3',100)
#'#Example 15 Result with strategy=regression_s4
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='regression_s4',100)
#'#Example 16 Result with strategy=ratio_s4
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='ratio_s4',100)
#'#Example 17 Result with strategy=composite_regression_s4
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_regression_s4',100)
#'#Example 18 Result with strategy=composite_ratio_s4
#' estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
#'data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_ratio_s4',100)
estimate<-function(data1,data2, D, n1,n2, Si=0.5, lmda_1=0.5, strategy='direct_s1', sim='500'){
  
  ee_n_2<-c();ee_n_c<-c();
  for (j in 1:sim){
    sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
    sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
    CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
    area_2=sample_2$var1
    area_c=CDS$var1
    n_2<-numeric();n_c<-numeric()
    D=c(1,2,3)
    for(i in D){
      n_2=c(n_2, nrow(sample_2[area_2==i,]))
      n_c=c(n_c, nrow(CDS[area_c==i,]))
    }
    ee_n_2<-rbind(n_2, ee_n_2)
    ee_n_c<-rbind(n_c, ee_n_c)
  }
  m_n_2<-numeric()
  m_n_c<-numeric()
  
  for(i in 1:length(D)){
    m_n_2<-c(m_n_2, mean(ee_n_2[,i]))
    m_n_c<-c(m_n_c, mean(ee_n_c[,i]))
  }
  t_v=qt((1-0.05)/2 + .5, max(1,m_n_c-1))   # tend to t_v if sample size is big enough
  
   T_b<-c()
  if (strategy=='direct_s1'){
    ee_t_b<-c()
    for(j in 1:sim){
      sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
      sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
      CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
      t_b<-numeric(); T_b<-c()
      for(i in D){
        T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
        t_b=c(t_b, sum(CDS[CDS$area_1==i,]$Y_1)/nrow(CDS[CDS$area_1==i,]))
      }
      ee_t_b<-rbind(t_b, ee_t_b)
    }
    M_t_b<-numeric()
    B_t_b<-numeric()
    for(i in 1:length(D)){
      B_t_b<-c(B_t_b, mean(ee_t_b[,i]))
      M_t_b<-c(M_t_b, mean((ee_t_b[,i]-T_b[i])^2))
    }
    direct_S1=data.frame(estimates=B_t_b,STD=sqrt(M_t_b), Lower_C.I=B_t_b-t_v*sqrt(M_t_b),Upper_C.I=B_t_b+t_v*sqrt(M_t_b))
    return(direct_S1)
  }
   #######################################################################
   if (strategy=='direct_s2'){
     ee_t_b_s2<-c()
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       t_b_1<-numeric();t_b_2<-numeric(); T_b<-c()
       for(i in D){
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_b_1=c(t_b_1, sum(sample_1[sample_1$area_1==i,]$Y_1)/nrow(sample_1[sample_1$area_1==i,]))
         t_b_2=c(t_b_2, sum(sample_2[sample_2$area_2==i,]$Y_2)/nrow(sample_2[sample_2$area_2==i,]))
       }
       t_b_s2=lmda_1*t_b_1+(1-lmda_1)*t_b_2
       ee_t_b_s2<-rbind(t_b_s2, ee_t_b_s2)
     }
     M_t_b_s2<-numeric()
     B_t_b_s2<-numeric()
     for(i in 1:length(D)){
       B_t_b_s2<-c(B_t_b_s2, mean(ee_t_b_s2[,i]))
       M_t_b_s2<-c(M_t_b_s2, mean((ee_t_b_s2[,i]-T_b[i])^2))
     }
     direct_S2=data.frame(estimates=B_t_b_s2,STD=sqrt(M_t_b_s2), Lower_C.I=B_t_b_s2-t_v*sqrt(M_t_b_s2),
                          Upper_C.I=B_t_b_s2+t_v*sqrt(M_t_b_s2))
     return(direct_S2)
   }
   #######################################################################  
   #######################################################################
   ########################################################
   if (strategy=='weighted_s1'){
     ee_t_w<-c()
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       t_w<-numeric(); T_b<-c()
       for(i in D){
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_w=c(t_w, sum(CDS[CDS$area_1==i,]$weight_1*CDS[CDS$area_1==i,]$Y_1)/sum(CDS[CDS$area_1==i,]$weight_1))
       }
       ee_t_w<-rbind(t_w, ee_t_w)
     }
     M_t_w<-numeric()
     B_t_w<-numeric()
     for(i in 1:length(D)){
       B_t_w<-c(B_t_w, mean(ee_t_w[,i]))
       M_t_w<-c(M_t_w, mean((ee_t_w[,i]-T_b[i])^2))
     }
     weighted_S1=data.frame(estimates=B_t_w,STD=sqrt(M_t_w), Lower_C.I=B_t_w-t_v*sqrt(M_t_w),Upper_C.I=B_t_w+t_v*sqrt(M_t_w))
     return(weighted_S1)
   }
   #######################################################################
   if (strategy=='weighted_s2'){
     ee_t_w_s2<-c()
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       t_w_1<-numeric();t_w_2<-numeric(); T_b<-c()
       for(i in D){
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_w_1=c(t_w_1, sum(sample_1[sample_1$area_1==i,]$weight_1*sample_1[sample_1$area_1==i,]$Y_1)/sum(sample_1[sample_1$area_1==i,]$weight_1))
         t_w_2=c(t_w_2, sum(sample_2[sample_2$area_2==i,]$weight_2*sample_2[sample_2$area_2==i,]$Y_2)/sum(sample_2[sample_2$area_2==i,]$weight_2))
       }
       t_w_s2=lmda_1*t_w_1+(1-lmda_1)*t_w_2
       ee_t_w_s2<-rbind(t_w_s2, ee_t_w_s2)
     }
     M_t_w_s2<-numeric()
     B_t_w_s2<-numeric()
     for(i in 1:length(D)){
       B_t_w_s2<-c(B_t_w_s2, mean(ee_t_w_s2[,i]))
       M_t_w_s2<-c(M_t_w_s2, mean((ee_t_w_s2[,i]-T_b[i])^2))
     }
     weighted_S2=data.frame(estimates=B_t_w_s2,STD=sqrt(M_t_w_s2), Lower_C.I=B_t_w_s2-t_v*sqrt(M_t_w_s2),
                            Upper_C.I=B_t_w_s2+t_v*sqrt(M_t_w_s2))
     return(weighted_S2)
   }
   ####################################################################### 
   if (strategy=='poststratified_S1'){
     ee_t_ps<-c()
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       t_ps<-numeric(); T_b<-c()
       for(i in D){
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_ps=c(t_ps, (sum(CDS[CDS$area_1==i&CDS$stratum_1==1,]$Y_1)
                       +sum(CDS[CDS$Y_1==i&CDS$Y_1==2,]$Y_1))/nrow(CDS[CDS$area_1==i,]))
       }
       ee_t_ps<-rbind(t_ps, ee_t_ps)
     }
     
     B_t_ps<-numeric()
     M_t_ps<-numeric()
     for(i in 1:length(D)){
       B_t_ps<-c(B_t_ps, mean(ee_t_ps[,i]))
       M_t_ps<-c(M_t_ps, mean((ee_t_ps[,i]-T_b[i])^2))
     }
     poststratified_S1=data.frame(estimates=B_t_ps,STD=sqrt(M_t_ps),
                                  Lower_C.I=B_t_ps-t_v*sqrt(M_t_ps),Upper_C.I=B_t_ps+t_v*sqrt(M_t_ps))
     return(poststratified_S1)
   }
   ##############################################################
   #######################################################################
   if (strategy=='poststratified_S2'){
     ee_t_ps_s2<-c()
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       t_ps_1<-numeric();t_ps_2<-numeric(); T_b<-c();t_ps_s2=c()
       for(i in D){
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_ps_1=c(t_ps_1, (sum(sample_1[sample_1$area_1==i&sample_1$stratum_1==1,]$Y_1)
                           +sum(sample_1[sample_1$area_1==i&sample_1$stratum_1==2,]$Y_1))/nrow(sample_1[sample_1$area_1==i,]))
         t_ps_2=c(t_ps_2, (sum(sample_2[sample_2$area_2==i&sample_1$stratum_2==2,]$Y_2)
                           +sum(sample_2[sample_2$area_2==i&sample_2$stratum_2==2,]$Y_2))/nrow(sample_2[sample_2$area_2==i,]))
       }
       t_ps_s2=lmda_1*t_ps_1+(1-lmda_1)*t_ps_2
       ee_t_ps_s2<-rbind(t_ps_s2, ee_t_ps_s2)
     }
     
     B_t_ps_s2<-numeric()
     M_t_ps_s2<-numeric()
     for(i in 1:length(D)){
       B_t_ps_s2<-c(B_t_ps_s2, mean(ee_t_ps_s2[,i]))
       M_t_ps_s2<-c(M_t_ps_s2, mean((ee_t_ps_s2[,i]-T_b[i])^2))
     }
     poststratified_S2=data.frame(estimates=B_t_ps_s2,STD=sqrt(M_t_ps_s2),
                                  Lower_C.I=B_t_ps_s2-t_v*sqrt(M_t_ps_s2),Upper_C.I=B_t_ps_s2+t_v*sqrt(M_t_ps_s2))
     return(poststratified_S2)
   }
   ##############################################################
   ########################################################
   if (strategy=='regression_s2'){
     B1=cov(data2$Y_2,data2$X_2)/var(data2$X_2)
     ee_t_b_s2_reg<-c()
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       t_b_1<-numeric();t_b_2<-numeric(); T_b<-c(); M_x=c()
       tx_b_1<-numeric();tx_b_2<-numeric()
       for(i in D){
         M_x=c(M_x,mean(data2$X_2))
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_b_1=c(t_b_1, sum(sample_1[sample_1$area_1==i,]$Y_1)/nrow(sample_1[sample_1$area_1==i,]))
         t_b_2=c(t_b_2, sum(sample_2[sample_2$area_2==i,]$Y_2)/nrow(sample_2[sample_2$area_2==i,]))
         tx_b_2=c(tx_b_2, sum(sample_2[sample_2$area_2==i,]$X_2)/nrow(sample_2[sample_2$area_2==i,]))
       }
       t_syn_reg=t_b_2+B1*(M_x-tx_b_2)
       t_b_s2_reg=lmda_1*t_b_1+(1-lmda_1)*t_syn_reg
       ee_t_b_s2_reg<-rbind(t_b_s2_reg, ee_t_b_s2_reg)
     }
     M_t_b_s2_reg<-numeric()
     B_t_b_s2_reg<-numeric()
     for(i in 1:length(D)){
       B_t_b_s2_reg<-c(B_t_b_s2_reg, mean(ee_t_b_s2_reg[,i]) )
       M_t_b_s2_reg<-c(M_t_b_s2_reg, mean((ee_t_b_s2_reg[,i]-T_b[i])^2))
     }
     regression_S2=data.frame(estimates=B_t_b_s2_reg,STD=sqrt(M_t_b_s2_reg), Lower_C.I=B_t_b_s2_reg-t_v*sqrt(M_t_b_s2_reg),
                              Upper_C.I=B_t_b_s2_reg+t_v*sqrt(M_t_b_s2_reg))
     return(regression_S2)
   }
   ########################################################
   if (strategy=='ratio_s2'){
     ee_t_b_s2_r<-c()
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       t_b_1<-numeric();t_b_2<-numeric(); T_b<-c(); M_x=c()
       tx_b_1<-numeric();tx_b_2<-numeric()
       for(i in D){
         M_x=c(M_x,mean(data2$X_2))
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_b_1=c(t_b_1, sum(sample_1[sample_1$area_1==i,]$Y_1)/nrow(sample_1[sample_1$area_1==i,]))
         t_b_2=c(t_b_2, sum(sample_2[sample_2$area_2==i,]$Y_2)/nrow(sample_2[sample_2$area_2==i,]))
         tx_b_2=c(tx_b_2, sum(sample_2[sample_2$area_2==i,]$X_2)/nrow(sample_2[sample_2$area_2==i,]))
       }
       t_syn_r=t_b_2*(M_x/tx_b_2)
       t_b_s2_r=lmda_1*t_b_1+(1-lmda_1)*t_syn_r
       ee_t_b_s2_r<-rbind(t_b_s2_r, ee_t_b_s2_r)
     }
     M_t_b_s2_r<-numeric()
     B_t_b_s2_r<-numeric()
     for(i in 1:length(D)){
       B_t_b_s2_r<-c(B_t_b_s2_r, mean(ee_t_b_s2_r[,i]) )
       M_t_b_s2_r<-c(M_t_b_s2_r, mean((ee_t_b_s2_r[,i]-T_b[i])^2))
     }
     ratio_S2=data.frame(estimates=B_t_b_s2_r,STD=sqrt(M_t_b_s2_r), Lower_C.I=B_t_b_s2_r-t_v*sqrt(M_t_b_s2_r),
                         Upper_C.I=B_t_b_s2_r+t_v*sqrt(M_t_b_s2_r))
     return(ratio_S2)
   }
   ########################################################
   if (strategy=='composite_regression_s2'){
     B1=cov(data2$Y_2,data2$X_2)/var(data2$X_2)
     ee_t_b_s2_com_reg<-c()
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       t_b_1<-numeric();t_b_2<-numeric(); T_b<-c(); M_x=c()
       tx_b_1<-numeric();tx_b_2<-numeric()
       for(i in D){
         M_x=c(M_x,mean(data2$X_2))
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_b_1=c(t_b_1, sum(sample_1[sample_1$area_1==i,]$Y_1)/nrow(sample_1[sample_1$area_1==i,]))
         t_b_2=c(t_b_2, sum(sample_2[sample_2$area_2==i,]$Y_2)/nrow(sample_2[sample_2$area_2==i,]))
         tx_b_2=c(tx_b_2, sum(sample_2[sample_2$area_2==i,]$X_2)/nrow(sample_2[sample_2$area_2==i,]))
       }
       t_syn_reg=t_b_2+B1*(M_x-tx_b_2)
       t_com_reg=Si*t_b_2+(1-Si)*t_syn_reg
       t_b_s2_com_reg=lmda_1*t_b_1+(1-lmda_1)*t_com_reg
       ee_t_b_s2_com_reg<-rbind(t_b_s2_com_reg, ee_t_b_s2_com_reg)
     }
     M_t_b_s2_com_reg<-numeric()
     B_t_b_s2_com_reg<-numeric()
     for(i in 1:length(D)){
       B_t_b_s2_com_reg<-c(B_t_b_s2_com_reg, mean(ee_t_b_s2_com_reg[,i]) )
       M_t_b_s2_com_reg<-c(M_t_b_s2_com_reg, mean((ee_t_b_s2_com_reg[,i]-T_b[i])^2))
     }
     composite_regression_S2=data.frame(estimates=B_t_b_s2_com_reg,STD=sqrt(M_t_b_s2_com_reg), Lower_C.I=B_t_b_s2_com_reg-t_v*sqrt(M_t_b_s2_com_reg),
                                        Upper_C.I=B_t_b_s2_com_reg+t_v*sqrt(M_t_b_s2_com_reg))
     return(composite_regression_S2)
   }
   ########################################################
   if (strategy=='composite_ratio_s2'){
     ee_t_b_s2_com_r<-c()
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       t_b_1<-numeric();t_b_2<-numeric(); T_b<-c(); M_x=c()
       tx_b_1<-numeric();tx_b_2<-numeric()
       for(i in D){
         M_x=c(M_x,mean(data2$X_2))
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_b_1=c(t_b_1, sum(sample_1[sample_1$area_1==i,]$Y_1)/nrow(sample_1[sample_1$area_1==i,]))
         t_b_2=c(t_b_2, sum(sample_2[sample_2$area_2==i,]$Y_2)/nrow(sample_2[sample_2$area_2==i,]))
         tx_b_2=c(tx_b_2, sum(sample_2[sample_2$area_2==i,]$X_2)/nrow(sample_2[sample_2$area_2==i,]))
       }
       t_syn_r=t_b_2*(M_x/tx_b_2)
       t_com_r=Si*t_b_2+(1-Si)*t_syn_r
       t_b_s2_com_r=lmda_1*t_b_1+(1-lmda_1)*t_com_r
       ee_t_b_s2_com_r<-rbind(t_b_s2_com_r, ee_t_b_s2_com_r)
     }
     M_t_b_s2_com_r<-numeric()
     B_t_b_s2_com_r<-numeric()
     for(i in 1:length(D)){
       B_t_b_s2_com_r<-c(B_t_b_s2_com_r, mean(ee_t_b_s2_com_r[,i]) )
       M_t_b_s2_com_r<-c(M_t_b_s2_com_r, mean((ee_t_b_s2_com_r[,i]-T_b[i])^2))
     }
     composite_ratio_S2=data.frame(estimates=B_t_b_s2_com_r,STD=sqrt(M_t_b_s2_com_r), Lower_C.I=B_t_b_s2_com_r-t_v*sqrt(M_t_b_s2_com_r),
                                   Upper_C.I=B_t_b_s2_com_r+t_v*sqrt(M_t_b_s2_com_r))
     return(composite_ratio_S2)
   }
   ########################################################
   if (strategy=='regression_s3'){
     ee_t_b_s3_reg<-c()
     B1=cov(data2$Y_2,data2$X_2)/var(data2$X_2)
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       T_b<-c(); M_x=c()
       t_b_1<-numeric();t_b_2<-numeric();tx_b_1<-numeric();tx_b_2<-numeric()
       for(i in D){
         M_x=c(M_x,mean(data2$X_2))
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_b_1=c(t_b_1, sum(sample_1[sample_1$area_1==i,]$Y_1)/nrow(sample_1[sample_1$area_1==i,]))
         t_b_2=c(t_b_2, sum(sample_2[sample_2$area_2==i,]$Y_2)/nrow(sample_2[sample_2$area_2==i,]))
         tx_b_1=c(tx_b_1, sum(sample_1[sample_1$area_1==i,]$X_1)/nrow(sample_1[sample_1$area_1==i,]))
         tx_b_2=c(tx_b_2, sum(sample_2[sample_2$area_2==i,]$X_2)/nrow(sample_2[sample_2$area_2==i,]))
       }
       t_b_s2=lmda_1*t_b_1+(1-lmda_1)*t_b_2
       tx_b_s2=lmda_1*tx_b_1+(1-lmda_1)*tx_b_2
       t_b_s3_reg=t_b_s2+B1*(M_x-tx_b_s2)
       ee_t_b_s3_reg<-rbind(t_b_s3_reg, ee_t_b_s3_reg)
     }
     M_t_b_s3_reg<-numeric()
     B_t_b_s3_reg<-numeric()
     for(i in 1:length(D)){
       B_t_b_s3_reg<-c(B_t_b_s3_reg, mean(ee_t_b_s3_reg[,i]) )
       M_t_b_s3_reg<-c(M_t_b_s3_reg, mean((ee_t_b_s3_reg[,i]-T_b[i])^2))
     }
     regression_s3=data.frame(estimates=B_t_b_s3_reg,STD=sqrt(M_t_b_s3_reg), Lower_C.I=B_t_b_s3_reg-t_v*sqrt(M_t_b_s3_reg),
                              Upper_C.I=B_t_b_s3_reg+t_v*sqrt(M_t_b_s3_reg))
     return(regression_s3)
   }
   ########################################################
   if (strategy=='ratio_s3'){
     ee_t_b_s3_r<-c()
     B1=cov(data2$Y_2,data2$X_2)/var(data2$X_2)
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       T_b<-c(); M_x=c();t_b_1<-numeric();t_b_2<-numeric();tx_b_1<-numeric();tx_b_2<-numeric()
       for(i in D){
         M_x=c(M_x,mean(data2$X_2))
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_b_1=c(t_b_1, sum(sample_1[sample_1$area_1==i,]$Y_1)/nrow(sample_1[sample_1$area_1==i,]))
         t_b_2=c(t_b_2, sum(sample_2[sample_2$area_2==i,]$Y_2)/nrow(sample_2[sample_2$area_2==i,]))
         tx_b_1=c(tx_b_1, sum(sample_1[sample_1$area_1==i,]$X_1)/nrow(sample_1[sample_1$area_1==i,]))
         tx_b_2=c(tx_b_2, sum(sample_2[sample_2$area_2==i,]$X_2)/nrow(sample_2[sample_2$area_2==i,]))
       }
       t_b_s2=lmda_1*t_b_1+(1-lmda_1)*t_b_2
       tx_b_s2=lmda_1*tx_b_1+(1-lmda_1)*tx_b_2
       t_b_s3_r=t_b_s2*(M_x/tx_b_s2)
       ee_t_b_s3_r<-rbind(t_b_s3_r, ee_t_b_s3_r)
     }
     M_t_b_s3_r<-numeric()
     B_t_b_s3_r<-numeric()
     for(i in 1:length(D)){
       B_t_b_s3_r<-c(B_t_b_s3_r, mean(ee_t_b_s3_r[,i]) )
       M_t_b_s3_r<-c(M_t_b_s3_r, mean((ee_t_b_s3_r[,i]-T_b[i])^2))
     }
     ratio_s3=data.frame(estimates=B_t_b_s3_r,STD=sqrt(M_t_b_s3_r), Lower_C.I=B_t_b_s3_r-t_v*sqrt(M_t_b_s3_r),
                         Upper_C.I=B_t_b_s3_r+t_v*sqrt(M_t_b_s3_r))
     return(ratio_s3)
   }
   ########################################################
   if (strategy=='composite_regression_s3'){
     ee_t_b_s3_com_reg<-c()
     B1=cov(data2$Y_2,data2$X_2)/var(data2$X_2)
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       T_b<-c(); M_x=c(); t_b_1<-numeric();t_b_2<-numeric();tx_b_1<-numeric();tx_b_2<-numeric()
       for(i in D){
         M_x=c(M_x,mean(data2$X_2))
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_b_1=c(t_b_1, sum(sample_1[sample_1$area_1==i,]$Y_1)/nrow(sample_1[sample_1$area_1==i,]))
         t_b_2=c(t_b_2, sum(sample_2[sample_2$area_2==i,]$Y_2)/nrow(sample_2[sample_2$area_2==i,]))
         tx_b_1=c(tx_b_1, sum(sample_1[sample_1$area_1==i,]$X_1)/nrow(sample_1[sample_1$area_1==i,]))
         tx_b_2=c(tx_b_2, sum(sample_2[sample_2$area_2==i,]$X_2)/nrow(sample_2[sample_2$area_2==i,]))
         
       }
       t_b_s2=lmda_1*t_b_1+(1-lmda_1)*t_b_2
       tx_b_s2=lmda_1*tx_b_1+(1-lmda_1)*tx_b_2
       t_b_s3_reg= t_b_s2+B1*(M_x-tx_b_s2)
       t_b_s3_com_reg=Si*t_b_s2+(1-Si)*t_b_s3_reg
       ee_t_b_s3_com_reg<-rbind(t_b_s3_com_reg, ee_t_b_s3_com_reg)
     }
     M_t_b_s3_com_reg<-numeric()
     B_t_b_s3_com_reg<-numeric()
     for(i in 1:length(D)){
       B_t_b_s3_com_reg<-c(B_t_b_s3_com_reg, mean(ee_t_b_s3_com_reg[,i]) )
       M_t_b_s3_com_reg<-c(M_t_b_s3_com_reg, mean((ee_t_b_s3_com_reg[,i]-T_b[i])^2))
     }
     composite_regression_s3=data.frame(estimates=B_t_b_s3_com_reg,STD=sqrt(M_t_b_s3_com_reg), Lower_C.I=B_t_b_s3_com_reg-t_v*sqrt(M_t_b_s3_com_reg),
                                        Upper_C.I=B_t_b_s3_com_reg+t_v*sqrt(M_t_b_s3_com_reg))
     return(composite_regression_s3)
   }
   ########################################################
   if (strategy=='composite_ratio_s3'){
     ee_t_b_s3_com_r<-c()
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       T_b<-c(); M_x=c(); t_b_1<-numeric();t_b_2<-numeric();tx_b_1<-numeric();tx_b_2<-numeric()
       for(i in D){
         M_x=c(M_x,mean(data2$X_2))
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_b_1=c(t_b_1, sum(sample_1[sample_1$area_1==i,]$Y_1)/nrow(sample_1[sample_1$area_1==i,]))
         t_b_2=c(t_b_2, sum(sample_2[sample_2$area_2==i,]$Y_2)/nrow(sample_2[sample_2$area_2==i,]))
         tx_b_1=c(tx_b_1, sum(sample_1[sample_1$area_1==i,]$X_1)/nrow(sample_1[sample_1$area_1==i,]))
         tx_b_2=c(tx_b_2, sum(sample_2[sample_2$area_2==i,]$X_2)/nrow(sample_2[sample_2$area_2==i,]))
       }
       t_b_s2=lmda_1*t_b_1+(1-lmda_1)*t_b_2
       tx_b_s2=lmda_1*tx_b_1+(1-lmda_1)*tx_b_2
       t_b_s3_r=t_b_s2*(M_x/tx_b_s2)
       t_b_s3_com_r=Si*t_b_s2+(1-Si)*t_b_s3_r
       ee_t_b_s3_com_r<-rbind(t_b_s3_com_r, ee_t_b_s3_com_r)
     }
     M_t_b_s3_com_r<-numeric()
     B_t_b_s3_com_r<-numeric()
     for(i in 1:length(D)){
       B_t_b_s3_com_r<-c(B_t_b_s3_com_r, mean(ee_t_b_s3_com_r[,i]) )
       M_t_b_s3_com_r<-c(M_t_b_s3_com_r, mean((ee_t_b_s3_com_r[,i]-T_b[i])^2))
     }
     composite_ratio_s3=data.frame(estimates=B_t_b_s3_com_r,STD=sqrt(M_t_b_s3_com_r), Lower_C.I=B_t_b_s3_com_r-t_v*sqrt(M_t_b_s3_com_r),
                                   Upper_C.I=B_t_b_s3_com_r+t_v*sqrt(M_t_b_s3_com_r))
     return(composite_ratio_s3)
   }   
   ######################################################## Strategy #4 
   if (strategy=='regression_s4'){
     ee_t_b_s4_reg<-c()
     B1=cov(data2$Y_2,data2$X_2)/var(data2$X_2)
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       T_b<-c(); M_x=c()
       t_b<-numeric();tx_b<-numeric();
       for(i in D){
         M_x=c(M_x,mean(data2$X_2))
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_b=c(t_b, sum(CDS[CDS$area_1==i,]$Y_1)/nrow(CDS[CDS$area_1==i,]))
         tx_b=c(tx_b, sum(CDS[CDS$area_1==i,]$X_1)/nrow(CDS[CDS$area_1==i,]))
       }
       t_b_s4_reg=t_b+B1*(M_x-tx_b)
       ee_t_b_s4_reg<-rbind(t_b_s4_reg, ee_t_b_s4_reg)
     }
     M_t_b_s4_reg<-numeric()
     B_t_b_s4_reg<-numeric()
     for(i in 1:length(D)){
       B_t_b_s4_reg<-c(B_t_b_s4_reg, mean(ee_t_b_s4_reg[,i]) )
       M_t_b_s4_reg<-c(M_t_b_s4_reg, mean((ee_t_b_s4_reg[,i]-T_b[i])^2))
     }
     regression_s4=data.frame(estimates=B_t_b_s4_reg,STD=sqrt(M_t_b_s4_reg), Lower_C.I=B_t_b_s4_reg-t_v*sqrt(M_t_b_s4_reg),
                              Upper_C.I=B_t_b_s4_reg+t_v*sqrt(M_t_b_s4_reg))
     return(regression_s4)
   }
   ########################################################
   if (strategy=='ratio_s4'){
     ee_t_b_s4_r<-c()
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       t_b<-numeric(); T_b<-c(); M_x=c();tx_b<-c()
       for(i in D){
         M_x=c(M_x,mean(data2$X_2))
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_b=c(t_b, sum(CDS[CDS$area_1==i,]$Y_1)/nrow(CDS[CDS$area_1==i,]))
         tx_b=c(tx_b, sum(CDS[CDS$area_1==i,]$X_1)/nrow(CDS[CDS$area_1==i,]))
       }
       
       t_b_s4_r=t_b*(M_x/tx_b)
       ee_t_b_s4_r<-rbind(t_b_s4_r, ee_t_b_s4_r)
     }
     M_t_b_s4_r<-numeric()
     B_t_b_s4_r<-numeric()
     for(i in 1:length(D)){
       B_t_b_s4_r<-c(B_t_b_s4_r, mean(ee_t_b_s4_r[,i]) )
       M_t_b_s4_r<-c(M_t_b_s4_r, mean((ee_t_b_s4_r[,i]-T_b[i])^2))
     }
     ratio_s4=data.frame(estimates=B_t_b_s4_r,STD=sqrt(M_t_b_s4_r), Lower_C.I=B_t_b_s4_r-t_v*sqrt(M_t_b_s4_r),
                         Upper_C.I=B_t_b_s4_r+t_v*sqrt(M_t_b_s4_r))
     return(ratio_s4)
   }
   ########################################################
   if (strategy=='composite_regression_s4'){
     ee_t_b_s4_com_reg<-c()
     B1=cov(data2$Y_2,data2$X_2)/var(data2$X_2)
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       t_b<-numeric(); T_b<-c(); M_x=c()
       tx_b<-numeric()
       for(i in D){
         M_x=c(M_x,mean(data2$X_2))
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_b=c(t_b, sum(CDS[CDS$area_1==i,]$Y_1)/nrow(CDS[CDS$area_1==i,]))
         tx_b=c(tx_b, sum(CDS[CDS$area_1==i,]$X_1)/nrow(CDS[CDS$area_1==i,]))
         
       }
       t_b_s4_reg=t_b+B1*(M_x-tx_b)
       t_b_s4_com_reg=Si*t_b+(1-Si)*t_b_s4_reg
       ee_t_b_s4_com_reg<-rbind(t_b_s4_com_reg, ee_t_b_s4_com_reg)
     }
     M_t_b_s4_com_reg<-numeric()
     B_t_b_s4_com_reg<-numeric()
     for(i in 1:length(D)){
       B_t_b_s4_com_reg<-c(B_t_b_s4_com_reg, mean(ee_t_b_s4_com_reg[,i]) )
       M_t_b_s4_com_reg<-c(M_t_b_s4_com_reg, mean((ee_t_b_s4_com_reg[,i]-T_b[i])^2))
     }
     composite_regression_s4=data.frame(estimates=B_t_b_s4_com_reg,STD=sqrt(M_t_b_s4_com_reg), Lower_C.I=B_t_b_s4_com_reg-t_v*sqrt(M_t_b_s4_com_reg),
                                        Upper_C.I=B_t_b_s4_com_reg+t_v*sqrt(M_t_b_s4_com_reg))
     return(composite_regression_s4)
   }
   ########################################################
   if (strategy=='composite_ratio_s4'){
     ee_t_b_s4_com_r<-c()
     for(j in 1:sim){
       sample_1=data1[sample(1:nrow(data1),n1, replace=FALSE),]
       sample_2=data2[sample(1:nrow(data2),n2, replace=FALSE),]
       CDS=data.frame(rbind(as.matrix(sample_1), as.matrix(sample_2)))
       t_b<-numeric(); T_b<-c(); M_x=c()
       tx_b<-numeric()
       for(i in D){
         M_x=c(M_x,mean(data2$X_2))
         T_b=c(T_b, sum(data2[data2$area_2==i,]$Y_2)/nrow(data2[data2$area_2==i,]))
         t_b=c(t_b, sum(CDS[CDS$area_1==i,]$Y_1)/nrow(CDS[CDS$area_1==i,]))
         tx_b=c(tx_b, sum(CDS[CDS$area_1==i,]$X_1)/nrow(CDS[CDS$area_1==i,]))
       }
       
       t_b_s4_r=t_b*(M_x/tx_b)
       t_b_s4_com_r=Si*t_b+(1-Si)*t_b_s4_r
       ee_t_b_s4_com_r<-rbind(t_b_s4_com_r, ee_t_b_s4_com_r)
     }
     M_t_b_s4_com_r<-numeric()
     B_t_b_s4_com_r<-numeric()
     for(i in 1:length(D)){
       B_t_b_s4_com_r<-c(B_t_b_s4_com_r, mean(ee_t_b_s4_com_r[,i]) )
       M_t_b_s4_com_r<-c(M_t_b_s4_com_r, mean((ee_t_b_s4_com_r[,i]-T_b[i])^2))
     }
     composite_ratio_s4=data.frame(estimates=B_t_b_s4_com_r,STD=sqrt(M_t_b_s4_com_r), Lower_C.I=B_t_b_s4_com_r-t_v*sqrt(M_t_b_s4_com_r),
                                   Upper_C.I=B_t_b_s4_com_r+t_v*sqrt(M_t_b_s4_com_r))
     return(composite_ratio_s4)
   }   
   
   
}
