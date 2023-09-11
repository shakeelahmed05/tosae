test_that("estimates", {
  ###Direct S1
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4)),
                        data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4)), c(1,2,3),
                         30, 30,0.3,0.5, strategy='direct_s1',100)$estimates[1], 0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4)),
                      data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4)), c(1,2,3),
                      30, 30,0.3,0.5, strategy='direct_s1',100)$estimates[1], max(rnorm(100,4)))
  ###Direct S2
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4)),
                      data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4)), c(1,2,3),
                      30, 30,0.3,0.5, strategy='direct_s2',100)$estimates[1], 0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4)),
                      data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4)), c(1,2,3),
                      30, 30,0.3,0.5, strategy='direct_s2',100)$estimates[1], max(rnorm(100,4)))
  #Test 3 Result with strategy=weighted_s1  
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='weighted_s1',100)$estimates[1], 0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), weight_1=runif(100)),
                      data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='weighted_s1',100)$estimates[1], max(rnorm(100,4)))
  #Test 4 Result with strategy=weighted_s2 
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='weighted_s2',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), weight_1=runif(100)),
                      data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='weighted_s2',100)$estimates[1],max(rnorm(100,4)))
  #Test 5 Result with strategy=poststratified_s1  
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), weight_1=runif(100), stratum_1=c(rep(1,50), rep(2,50))),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), weight_2=runif(100), stratum_2=c(rep(1,50), rep(2,50))), c(1,2,3), 30, 30,0.3,0.5, strategy='poststratified_S1',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), weight_1=runif(100), stratum_1=c(rep(1,50), rep(2,50))),
                      data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), weight_2=runif(100), stratum_2=c(rep(1,50), rep(2,50))), c(1,2,3), 30, 30,0.3,0.5, strategy='poststratified_S1',100)$estimates[1],max(rnorm(100,4)))
  #Test 6 Result with strategy=poststratified_s2 
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), weight_1=runif(100), stratum_1=c(rep(1,50), rep(2,50))),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), weight_2=runif(100), stratum_2=c(rep(1,50), rep(2,50))), c(1,2,3), 30, 30,0.3,0.5, strategy='poststratified_S2',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), weight_1=runif(100), stratum_1=c(rep(1,50), rep(2,50))),
                      data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), weight_2=runif(100), stratum_2=c(rep(1,50), rep(2,50))), c(1,2,3), 30, 30,0.3,0.5, strategy='poststratified_S2',100)$estimates[1],max(rnorm(100,4)))
  #Test 7 Result with strategy=regression_s2
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='regression_s2',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='regression_s2',100)$estimates[1],max(rnorm(100,4)))
  #Test 8 Result with strategy=ratio_s2
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='ratio_s2',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
                      data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='ratio_s2',100)$estimates[1],max(rnorm(100,4)))
  ##Test 9 Result with strategy=composite_regression_s2
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_regression_s2',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
                      data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_regression_s2',100)$estimates[1],max(rnorm(100,4)))
  ##Test 10 Result with strategy=composite_ratio_s2
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_ratio_s2',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_ratio_s2',100)$estimates[1], max(rnorm(100,4)))
  ##Test 11 Result with strategy=regression_s3
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='regression_s3',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
                      data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='regression_s3',100)$estimates[1],max(rnorm(100,4)))
  ##Test 12 Result with strategy=ratio_s3
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='ratio_s3',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='ratio_s3',100)$estimates[1],max(rnorm(100,4)))
   ##Test 13 Result with strategy=composite_regression_s3
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_regression_s3',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
                      data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_regression_s3',100)$estimates[1],max(rnorm(100,4)))
  #'#Example 14 Result with strategy=composite_ratio_s3
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_ratio_s3',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
                      data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_ratio_s3',100)$estimates[1],max(rnorm(100,4)))
  ##Test 15 Result with strategy=regression_s4
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='regression_s4',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='regression_s4',100)$estimates[1],max(rnorm(100,4)))
   ##Test 16 Result with strategy=ratio_s4
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='ratio_s4',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
 data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='ratio_s4',100)$estimates[1],max(rnorm(100,4)))
   ##Test 17 Result with strategy=composite_regression_s4
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_regression_s4',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_regression_s4',100)$estimates[1],max(rnorm(100,4)))
   ##Test 18 Result with strategy=composite_ratio_s4
  expect_gte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
  data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_ratio_s4',100)$estimates[1],0)
  expect_lte(estimate(data.frame(area_1=c(rep(1,60),rep(2,20),rep(3,20)), Y_1=rnorm(100,4), X_1=rnorm(100,10), weight_1=runif(100)),
                      data.frame(area_2=c(rep(1,30),rep(2,40),rep(3,30)), Y_2=rnorm(100,4), X_2=rnorm(100,10), weight_2=runif(100)), c(1,2,3), 30, 30,0.3,0.5, strategy='composite_ratio_s4',100)$estimates[1],max(rnorm(100,4)))
 
})
