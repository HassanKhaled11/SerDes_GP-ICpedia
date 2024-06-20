// #include "svdpi.h"
#include <stdio.h>
#include "math.h"
#include "DLF.h"
long accum_freq_val, freq_max_val;
long accum_phase_val, phase_max_val;
int freq_gain, phase_gain;
int width;

extern void init_f(int frug, int freq_width, int phug, int phase_width)
{
	freq_max_val = pow(2, freq_width);
	phase_max_val = pow(2, phase_width);
	accum_freq_val = 0;
	accum_phase_val = 0;
	freq_gain = frug;
	phase_gain = phug;
	width = freq_width;
}

extern int accum_freq(int up, int dn)
{
	long current_accum_val = freq_gain * (up - dn) + accum_freq_val;
	if (current_accum_val > freq_max_val)
	{
		accum_freq_val = current_accum_val - freq_max_val;
	}
	else
	{
		accum_freq_val = current_accum_val;
	}
	return accum_freq_val;
}

extern int accum_phase(int up, int dn)
{
	int current_accum_val = 0;
	if (up && !dn)
	{
		current_accum_val = phase_gain * (up - dn) + (accum_freq_val >> (width - 9) & 511) + accum_phase_val; // top 9  010101011101
	}
	else
	{
		current_accum_val = phase_gain * (up - dn) - (accum_freq_val >> (width - 9) & 511) + accum_phase_val;
	}
	if (current_accum_val > phase_max_val)
	{
		accum_phase_val = current_accum_val - phase_max_val;
	}
	else
	{
		accum_phase_val = current_accum_val;
	}
	return accum_phase_val;
}