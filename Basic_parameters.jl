# Escenarios
season = ["Verano", "Otono", "Invierno", "Primavera"]
Dict_season = Dict([("Verano", "orange"), ("Otono", "brown"), ("Invierno", "blue"), ("Primavera", "green")]) 

# Parametros basicos de la red
VB = 12600           # Voltaje base de la red [V]
tmax = 24             # Bloques de tiempo diarios

# Evaluacion de proyecto
Tmax = 20            # Horizonte de evaluacion del proyecto
Tint = 0.08          # Tasa de descuento
Tr = [tr for tr in 0:Tmax]  # Horizonte de evaluacion del proyecto
DF = sum(1/(1+Tint)^t for t in collect(0:Tmax))

# OLTC Operation
taps = 16            # Numero de taps que tiene el OLTC
Vmin_OLTC = 0.95     # Voltaje minimo que alcanza el OLTC
Vmax_OLTC = 1.05     # Voltaje maximo que alcanza el OLTC
rango_OLTC = [i-(div(taps,2)+1) for i in 1:(taps+1)]    # Numero total de taps
step_OLTC = (Vmax_OLTC - Vmin_OLTC)/taps                # Paso de cada tap

# GD
pf = 0.9             # Factor de potencia minimo permitido a la GD
tg0 = sqrt((1/pf^2) - 1)    # Relacion entre P y Q

# AME
CB_max = 6           # Cantidad maxima de CB permitidos por bus

# Penalizacion
u_factor = 0.8       # Capacidad relativa apartir de la cual se considera sobrecarga
v_thr_min = 0.94*VB  # Umbral minimo de voltaje
v_thr_max = 1.06*VB  # Umbral maximo de voltaje

# ---------------------------- F A C T O R E S ---------------------------- #
# Big-M y k
M = 1e5                     # Big-M
k = 1e3                     # Factor miles




