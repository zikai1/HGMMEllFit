#include "gmmed.hpp"

#include "mex.h"


#include <iostream>

using namespace std;

void GaussTransformForEllipse(int ng, double *wg, double *gmm_g_mu, double *gmm_g_var, int nf, double *wf, double *gmm_f_mu, double *gmm_f_var, double &cost, double *grad)
{

	double w_g, mu_g[2], var_g[4];
	double w_f, mu_f[2], var_f[4];
	double mu_fg[2], var_fg[4];

	cost = 0;


	for (int i = 0; i < ng; i++)
	{
		w_g = wg[i];
		mu_g[0] = gmm_g_mu[i], mu_g[1] = gmm_g_mu[i + ng];
		int idx_g = 4 * i;
		var_g[0] = gmm_g_var[idx_g + 0], var_g[1] = gmm_g_var[idx_g + 2];
		var_g[2] = gmm_g_var[idx_g + 1], var_g[3] = gmm_g_var[idx_g + 3];

		double L2_t = 0, grad_t[2] = { 0,0 };


		for (int j = 0; j < nf; j++)
		{
			w_f = wf[j];
			mu_f[0] = gmm_f_mu[j], mu_f[1] = gmm_f_mu[j + nf];

			int idx_f = 4 * j;
			var_f[0] = gmm_f_var[idx_f + 0], var_f[1] = gmm_f_var[idx_f + 2];
			var_f[2] = gmm_f_var[idx_f + 1], var_f[3] = gmm_f_var[idx_f + 3];


			mu_fg[0] = mu_g[0] - mu_f[0], mu_fg[1] = mu_g[1] - mu_f[1];
			for (int k = 0; k < 4; k++)
				var_fg[k] = var_f[k] + var_g[k];

			double det_varfg = var_fg[0] * var_fg[3] - var_fg[1] * var_fg[2];
			double inv_varfg[4] = { var_fg[3], -var_fg[1], -var_fg[2], var_fg[0] };
			for (int k = 0; k < 4; k++)
				inv_varfg[k] /= det_varfg;

			double temp = inv_varfg[0] * mu_fg[0] * mu_fg[0] + (inv_varfg[1] + inv_varfg[2])*mu_fg[0] * mu_fg[1] + inv_varfg[3] * mu_fg[1] * mu_fg[1];

			//mexPrintf("%.2f, %.2f\n", det_varfg, mu_fg[1]);

			//double cost_t = w_g*w_f*exp(-0.5*temp) / sqrt(det_varfg);
			double cost_t = w_g*w_f*exp(-0.5*temp);

			//mexPrintf("%.2f, %.2f\n", det_varfg, mu_fg[1]);
			L2_t += cost_t;
			grad_t[0] += -1 * cost_t * (mu_fg[0] * inv_varfg[0] + mu_fg[1] * inv_varfg[2]);
			grad_t[1] += -1 * cost_t * (mu_fg[0] * inv_varfg[1] + mu_fg[1] * inv_varfg[3]);

		}

		//mexPrintf("cpp: %.8f\n", L2_t);
		grad[i] = grad_t[0], grad[i + ng] = grad_t[1];
		cost += L2_t;

       }
	

}