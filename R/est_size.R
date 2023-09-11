
#' Expected Sample Sizes in Small Areas
#'
#' @param data1  Data frame consisting var1 area membership variable, var 2 the study variable....
#' @param data2   Data frame consisting var1 area membership variable, var 2 the study variable....
#' @param D   a vector consisting list of area
#' @param n1  sample size selected at first occasion
#' @param n2 sample size selected at second occasion
#' @param sim   Number of bootstrap replication to obtain standard error
#'
#' @return The expected sample sizes in different areas
#' @export
#'
#' @examples  est_size(data.frame(var1=c(rep(1,60),rep(2,20),rep(3,20)), var2=rnorm(100,4)),
#'data.frame(var1=c(rep(1,30),rep(2,40),rep(3,30)), var2=rnorm(100,4)), c(1,2,3), 30, 30,100)
est_size<-function(data1,data2, D, n1,n2, sim){
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
  estimated_sample_sizes=data.frame(Sample_size_current=m_n_2, Sample_size_combined=m_n_c)
  print(estimated_sample_sizes)
  
  
  
  
  
}





