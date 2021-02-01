Robust Ellipse Fitting Using Hierarchical Gaussian Mixture Models (Matlab package)
	      


This package provides Matlab code with examples for the HGMM algorithm. 


1) INSTALLATION

Unpack the HGMM distribution archive.

Run HGMM_make (in Matlab) to mex-compile some CPP files.  You can use the command "mex -setup" to set the compiling, 
either by VS2019 or  MinGW64 Compiler (C). 


Then put the compiled MEX files into the directory HGMM. 


2) EXAMPLES

Run 'demo.m' to see examples. 

Please see examples including outliers or not in the 'demo' directory for the details.

3) Parameters
There are mainly three parameters in our method, to get better performance, some suggestions are provided:
a. The bandwidth h, which acts as a smoothing parameter. We suggest $h\in [4, 1]$ for the outer fitting, and $h\in [0.9, 0.6]$ for the inner fitting.
b. The point number N in the growing region. When the ellipse is quite large, we suggest slightly tuning N higher.
c. The neighborhood number $\epsilon$ in the growing region. If there are a large part of outliers, we suggest using a larger $\epsilon$ to improve the fitting accuracy.


4) Q&A
If you have any questions, please send me an e-mail: zhaomingyang16@mails.ucas.ac.cn. Any questions are welcome!
-----------------------------------------------------------------------


