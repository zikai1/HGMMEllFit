#pragma once


void ModelFPixel(int n, double *p, double *dx, double *dy, double h,
	double *wf, double *gmm_f_mu, double *gmm_f_var);


void GaussTransformForEllipse(int ng, double *wg, double *gmm_g_mu, double *gmm_g_var, int nf, double *wf, double *gmm_f_mu, double *gmm_f_var, double &cost, double *grad);