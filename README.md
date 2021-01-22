# 1. Motivation
Traditional methods mainly rely on the least-squares principle for ellipse fitting, however, as Gauss-Markov theorem pointed, they are sensitive to outliers. To solve this problem, we propose a novel method for robust ellipse fitting using hierarchical Gaussian mixture models. The method consists of two layers, where the first layer aims to locating ellipses through region growing, and the second one further improves the fitting accuracy. Since we combine distance and density to decide correct ellipses, the method is quite robust against noise and outliers. 

![outlier](https://github.com/zikai1/HGMMEllFit/blob/main/outlier.png)

# 2. How to use
For easy use, the code is implemented by MATLAB. 
- Download the code by 
git clone https://github.com/zikai1/HGMMEllFit
- Complie the cpp files in the HGMM_make directory in MATLAB to generate mex files. 
- Add the mex files by "addpath(genpath('.\HGMMEllFit\HGMM_make'))" .
- Run the demo file "demo.m" to generate ellipse fitting results in outlier-contained cases.
