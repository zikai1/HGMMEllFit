#include "mex.h"
#include<stdexcept>
#include<cmath>
#include <iostream>
#include <utility>

using namespace std;


/* compute the point density */
void density_comp(double* data,double* h,int M,double* density)
{
    int i,j,k;
    double sum,diff,distance,temp;
    double h2=(*h)*(*h);
    
    
    for(i=0;i<M;i++){
        sum=0;
        temp=0;
        for(j=0;j<M;j++){
            
            // the distance between two points
            distance=0;
            for(k=0;k<2;k++){
                diff=*(data+i+k*M)-*(data+j+k*M);
                diff=diff*diff;
                distance+=diff;
            }
            temp=exp(-0.5*distance); 
            sum=sum+(1.0/M)*exp(-0.5*distance/(h2))/h2; // note that int/int is int, omit the decimals
            //mexPrintf("density: %f,%f\n",h2,sum);
            
        }
        //store the point density
        *(density+i)=sum;
        
    }
}









// Input parameters
#define In_x   prhs[0]// data points
#define In_y   prhs[1]// bandwidth 

//Output parameter
#define Out_x   plhs[0]// density of each data point


void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  if (nrhs!=2)
  {
      mexErrMsgTxt("There are two input parameters (data (matrix) h(bandwidth)).");
  }
  if(nlhs!=1)
  {
      mexErrMsgTxt("Output parameter is matrix(array) class pointer only.");
  }
  double *data, *h, *density;
  int M;// point number
  
  M=mxGetM(In_x);
  
  Out_x=mxCreateDoubleMatrix(M,1,mxREAL);
  
  // assign pointers to the input parameters
  data=mxGetPr(In_x);
  h=mxGetPr(In_y);
  
  // assign pointers to the output parameter
  density=mxGetPr(Out_x);
  
  // Do the actual computations in the subroutine
  
  density_comp(data,h,M,density);
  
  return;

}