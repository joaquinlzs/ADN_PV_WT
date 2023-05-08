# Potencia efectivamente consumida por los usuarios finales. Analizamos perdidas
P_consumida = Array{Float64}(undef, 4, 24)
demand = JuMP.value.(Pload_rho)
for rho in ESC
    local aux = []
    for t in T
        push!(aux, sum(demand[i,t,rho] for i in I))
    end
    P_consumida[rho,:] = aux
end

# Perdidas por efecto Joule a lo largo de la red
P_losses = Array{Float64}(undef, 4, 24)
loss = JuMP.value.(r .*u)
for rho in ESC
    local aux = []
    for t in T
        push!(aux, sum(loss[i,t,rho] for i in I))
    end
    P_losses[rho,:] = aux
end

# Potencia importada desde la red principal a la red de distribucion
P_importada = Array{Float64}(undef, 4, 24)
for rho in ESC
    P_importada[rho,:] = JuMP.value.(P[1,:,rho]) .+ JuMP.value.(r[1]*u[1,:,rho])
end

# Potencia generada localmente por toda la GD
P_generada = P_PV_total + P_WT_total

# Balance de potencia activa total en la red
balance = round(sum(P_consumida .+ P_losses .- P_importada .- P_generada))


#-------------------------------------------------------------------------------------------------

# Analisis de las perdidas
P_losses_rho = []
money_loss_rho = []
money_loss = P_losses .* p_spot
for rho in ESC
    push!(P_losses_rho, sum(P_losses[rho,:]))
    push!(money_loss_rho, sum(money_loss[rho,:]))
end

P_losses_total_year = P_losses_rho' * rho * 365
money_loss_total_total_year = money_loss_rho' * rho * 365