# ------- VARIABLES AUXILIARES PARA VISUALIZACION DE RESULTADOS
# Limpiar corrientes de negativos
U = JuMP.value.(u)
for i in I
    for t in T
        for rho in ESC
            if U[i, t, rho] < 0
                U[i, t, rho] = 0
            end
        end
    end
end

# Reforzamiendo de lineas
capacity_L = xl .* lista_L'
capacity_L_vec = []
for i in 1:size(capacity_L)[1]
    push!(capacity_L_vec,JuMP.value.(sum(capacity_L[i,:])))
end

# Saturacion de lineas
saturation = round.(sqrt.(max.(JuMP.value.(u),0)) ./ capacity_L_vec, digits=3)

#----- Instalación de infraestructura
# Usuarios que instalaron GD
PV_installed = []
for i in I
    if sum(JuMP.value.(xpv[i,:])) >= 1
        push!(PV_installed,i)
    end
end

WT_installed = []
for i in I
    if sum(JuMP.value.(xwt[i,:])) >= 1
        push!(WT_installed,i)
    end
end

# Usuarios que instalaron SVC
SVC_installed = []
for i in I
    if sum(JuMP.value.(xsvc[i,:])) >= 1
        push!(SVC_installed,i)
    end
end

# Usuarios que instalaron CB
CB_installed = []
for i in I
    if sum(JuMP.value.(xcb[i,:])) >= 1
        push!(CB_installed,i)
    end
end

#----- Inyeccion de potencia activa y reactiva
# P total inyectada
P_PV_total = Array{Float64}(undef, size(rho)[1], 24)
for rho in ESC
    local aux = []
    for t in T
        push!(aux,(sum(JuMP.value.(P_PV[i,t,rho]) for i in I)))
    end
    P_PV_total[rho,:] = aux
end

P_WT_total = Array{Float64}(undef, size(rho)[1], 24)
for rho in ESC
    local aux = []
    for t in T
        push!(aux,(sum(JuMP.value.(P_WT[i,t,rho]) for i in I)))
    end
    P_WT_total[rho,:] = aux
end

# Total generacion PV disponible (se use o no)
P_PV_total_real = Array{Float64}(undef, size(rho)[1], 24)
for rho in ESC
    local aux = []
    for t in T
        push!(aux, sum(JuMP.value.(sum(G_PV_rho[w,t,rho]*xpv[j,w] for w in W)) for j in I))
    end
    P_PV_total_real[rho,:] = aux
end

P_WT_total_real = Array{Float64}(undef, size(rho)[1], 24)
for rho in ESC
    local aux = []
    for t in T
        push!(aux, sum(JuMP.value.(sum(G_WT_rho[w,t,rho]*xwt[j,w] for w in W)) for j in I))
    end
    P_WT_total_real[rho,:] = aux
end

# Q total inyectada
Q_AME_total = Array{Float64}(undef, size(rho)[1], 24)
for rho in ESC
    local aux = []
    for t in T
        push!(aux,(sum(JuMP.value.(Q_PV[i,t,rho] + Q_WT[i,t,rho] + Q_SVC[i,t,rho] + Q_CB[i,t,rho]) for i in I)))
    end
    Q_AME_total[rho,:] = aux
end

#----- penetracion RE
penetration_RE = []
for rho in ESC
    push!(penetration_RE, (sum(P_PV_total[rho,:] + P_WT_total[rho,:]))/(sum(Pload_rho[:,:,rho])))
end