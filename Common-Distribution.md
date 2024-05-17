Common Distribution
================
HuaHsin
2024-05-17

Status: Not complete yet!  
Keyword: r/poisson/bionomial/negative binomial.  

## Poisson distribution — Pois(λ)

### Basic

``` r
library(ggplot2)
#dpois(x, lambda, log = FALSE) # PMF or PDF, the probability of observing x events.
#ppois(q, lambda, lower.tail = TRUE, log.p = FALSE) #CDF, the probability of observing fewer than or equal to `q` events.
success <- 0:50
plot(success, dpois(success, lambda=5), type='h', main = "P(X = k | λ = 5)")
plot(success, ppois(success, lambda=5), type='h',  main = "P(X <=  k | λ = 5)")
```

<img src="Common-Distribution_files/figure-gfm/poisson1-1.png" width="50%" /><img src="Common-Distribution_files/figure-gfm/poisson1-2.png" width="50%" />

### When parameter change

What is the relationship between success and lamda? why look like normal
distribution?  

``` r
df.poi <- rbind.data.frame(cbind.data.frame(lambda=0.2, success=success, prob = dpois(success, lambda=0.2)),
                           cbind.data.frame(lambda=0.5, success=success, prob = dpois(success, lambda=0.5)),
                           cbind.data.frame(lambda=1, success=success, prob = dpois(success, lambda=1)),
                           cbind.data.frame(lambda=2, success=success, prob = dpois(success, lambda=2)),
                           cbind.data.frame(lambda=5, success=success, prob = dpois(success, lambda=5)),
                           cbind.data.frame(lambda=10, success=success, prob = dpois(success, lambda=10)),
                           cbind.data.frame(lambda=20, success=success, prob = dpois(success, lambda=20)),
                           cbind.data.frame(lambda=50, success=success, prob = dpois(success, lambda=50)))
df.poi$lambda <- as.factor(df.poi$lambda)
ggplot(df.poi,aes(x=success,y=prob,group=lambda))+
  theme_minimal()+
  labs(title = "Poisson Distribution",
  subtitle = "relationship of events occurence and parameter")+
  scale_color_brewer(palette="Paired")+
  geom_point(aes(color=lambda),size=2)+
  geom_line(aes(color=lambda),lwd=1)
```

<img src="Common-Distribution_files/figure-gfm/poisson2-1.png" width="50%" />

### Summary and Think

1.  lambda (λ) is the mean number of events within a given interval of
    time or space.  
2.  As λ increases, the asymmetry decreases.  
3.  When the mean of a Poisson distribution is large (\>10), it can be
    approximated by a normal distribution.  
4.  Relationship with binomial? Poisson is a special case of binomial
    and lambda = np.  

## Binomial Distribution — Bin(n,p)

### Basic

mean=np, variance= $np^2$  
have a fixed number of events n, each with a constant probability of
success p  

``` r
n <- 50
prob.success <- 0.2
plot(0:n, dbinom(0:n, size = n, prob = prob.success) , type = "h", main = "P(X = k | p = 0.2)") 
plot(0:n, pbinom(0:n, size = n, prob = prob.success) , type = "h", main = "P(X <= k | p = 0.2)") 
#rbinom
```

<img src="Common-Distribution_files/figure-gfm/binomial 1 -1.png" width="50%" /><img src="Common-Distribution_files/figure-gfm/binomial 1 -2.png" width="50%" />

### When parameter change

What is the relationship between size and success? why look like normal
distribution?  

``` r
num.of.trial <- 0:n
df.bin <- rbind.data.frame(cbind.data.frame(p.s=0.01, N=num.of.trial, prob = dbinom(0:n, size = n, prob = 0.01)),
                           cbind.data.frame(p.s=0.1, N=num.of.trial, prob = dbinom(0:n, size = n, prob = 0.1)),
                           cbind.data.frame(p.s=0.2, N=num.of.trial, prob = dbinom(0:n, size = n, prob = 0.2)),
                           cbind.data.frame(p.s=0.5, N=num.of.trial, prob = dbinom(0:n, size = n, prob = 0.5)),
                           cbind.data.frame(p.s=0.8, N=num.of.trial, prob = dbinom(0:n, size = n, prob = 0.8)),
                           cbind.data.frame(p.s=0.99, N=num.of.trial, prob = dbinom(0:n, size = n, prob = 0.99)))
df.bin$p.s <- as.factor(df.bin$p.s)
ggplot(df.bin,aes(x=N,y=prob,group=p.s))+
  theme_minimal()+
  labs(title = "Binomial Distribution",
       subtitle = "relationship of success events and success chance",
       ledgend.title = "ds")+
  scale_color_brewer(palette="Paired")+
  geom_point(aes(color=p.s),size=2)+
  geom_line(aes(color=p.s),lwd=1)
```

<img src="Common-Distribution_files/figure-gfm/binomial 2 -1.png" width="50%" />

### Summary and Think

1.  Across different success chance, Identical probability when success
    chance is 0.01 and 0.99.  
2.  Symmetric distribute of single binomial bell shape.  

## Negative Binomial Distribution — NB(r,p)

dnbinom(x, size, prob, mu, log = FALSE) pnbinom(q, size, prob, mu,
lower.tail = TRUE, log.p = FALSE) qnbinom(p, size, prob, mu, lower.tail
= TRUE, log.p = FALSE) rnbinom(n, size, prob, mu)

## Reference

<https://www.geeksforgeeks.org/poisson-distribution-in-r/>  
<https://www.geeksforgeeks.org/binomial-distribution-in-r-programming/>  
<https://rpruim.github.io/s341/S19/from-class/MathinRmd.html>  
