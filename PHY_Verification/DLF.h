/* MTI_DPI */

/*
 * Copyright 2002-2021 Mentor Graphics Corporation.
 *
 * Note:
 *   This file is automatically generated.
 *   Please do not edit this file - you will lose your edits.
 *
 * Settings when this file was generated:
 *   PLATFORM = 'win64'
 */
#ifndef INCLUDED_DLF
#define INCLUDED_DLF

#ifdef __cplusplus
#define DPI_LINK_DECL  extern "C" 
#else
#define DPI_LINK_DECL 
#endif

#include "svdpi.h"



DPI_LINK_DECL DPI_DLLESPEC
int
accum_freq(
    int Up,
    int Dn);

DPI_LINK_DECL DPI_DLLESPEC
int
accum_phase(
    int Up,
    int Dn);

DPI_LINK_DECL DPI_DLLESPEC
void
init_f(
    int frug,
    int freq_width,
    int phug,
    int phase_width);

#endif 