#include "mex.h"
#include "gmmed.hpp"

#include "iostream"
using namespace std;
void mexFunction(int nlhs,       mxArray *plhs[],
		 int nrhs, const mxArray *prhs[])        
{
    if(nlhs<1)
    {
        mexErrMsgTxt("There is only one output parameter.");
    }
    if(nrhs!=6)
    {
        mexErrMsgTxt("There are six input parameters.");
    }
    
    // Get the data;
    double *wg = (double *)mxGetPr(prhs[0]);
    double *gmm_g_mu = (double *)mxGetPr(prhs[1]);
    double *gmm_g_var = (double *)mxGetPr(prhs[2]);
    double *wf = (double *)mxGetPr(prhs[3]);
    double *gmm_f_mu = (double *)mxGetPr(prhs[4]);
    double *gmm_f_var = (double *)mxGetPr(prhs[5]);
    
    int ng = (int)mxGetM(prhs[1]);
    int nf = (int)mxGetM(prhs[4]);
    
    
    // Outputdata
    // mexPrintf("%d, %d\n", ng, nf);
    plhs[0] = mxCreateDoubleMatrix(1,1,mxREAL);
    plhs[1] = mxCreateDoubleMatrix(ng,2,mxREAL);// rows:ng cols:2
    
    double *_w = (double *)mxGetPr(plhs[0]);
    double *grad = (double *)mxGetPr(plhs[1]);
    double cost;
    GaussTransformForEllipse(ng, wg, gmm_g_mu, gmm_g_var, 
            nf, wf, gmm_f_mu, gmm_f_var, cost, grad);
    _w[0] = cost;
}
