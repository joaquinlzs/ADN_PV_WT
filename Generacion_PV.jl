# ---------------------------- G E N E R A C I O N    P V ---------------------------- #
g_PV_ver = [0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.01 0.13 0.35 0.58 0.77 0.89 0.93 0.91 0.83 0.68 0.49 0.26 0.07 0.01 0.00 0.00]
g_PV_oto = [0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.02 0.23 0.53 0.71 0.82 0.86 0.84 0.71 0.51 0.24 0.03 0.00 0.00 0.00 0.00 0.00]
g_PV_inv = [0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.08 0.30 0.57 0.74 0.83 0.82 0.73 0.54 0.27 0.04 0.00 0.00 0.00 0.00 0.00]
g_PV_pri = [0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.05 0.29 0.56 0.76 0.88 0.96 1.00 0.96 0.84 0.67 0.44 0.18 0.03 0.00 0.00 0.00]

G_PV_rho = Array{Float64}(undef, length(lista_PV), 24, size(rho)[1])
G_PV_rho[:, :, 1] = lista_PV*g_PV_ver 
G_PV_rho[:, :, 2] = lista_PV*g_PV_oto
G_PV_rho[:, :, 3] = lista_PV*g_PV_inv
G_PV_rho[:, :, 4] = lista_PV*g_PV_pri