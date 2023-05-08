# ------- GRAPHS
plotly()
# ------- Potencia importada
plt_P = plot(layout = (2,2), 
    size=(800,800), xlim=[1, 24], xlabel="Hora", ylabel="Potencia activa [MW]", 
    legend=false, margin=2px, bottom_margin = 40px)
for rho in ESC
    P_import = toarray(JuMP.value.(P[1,:,rho]/1e6))
    P_demand = toarray(JuMP.value.(sum(Pload_rho[i,:,rho]/1e6 for i in I)))
    P_PV_inyect = toarray(JuMP.value.(P_PV_total[rho,:]/1e6))
    P_PV_disp = toarray(JuMP.value.(P_PV_total_real[rho,:]/1e6))
    P_WT_inyect = toarray(JuMP.value.(P_WT_total[rho,:]/1e6))
    P_WT_disp = toarray(JuMP.value.(P_WT_total_real[rho,:]/1e6))
    plot!(plt_P, T, P_import, subplot=rho, linewidth=2, color=Dict_season[season[rho]], title=string(season[rho]), label="Import") 
    plot!(plt_P, T, P_demand, subplot=rho, linewidth=2, color=Dict_season[season[rho]], alpha=0.5, label="Demand", linestyle=:dash)
    plot!(plt_P, T, P_PV_inyect, subplot=rho, linewidth=2, color="black", label="PV Inyect")
    plot!(plt_P, T, P_PV_disp, subplot=rho, linewidth=2, color="black", label="PV Real", linestyle=:dash)
    plot!(plt_P, T, P_WT_disp, subplot=rho, linewidth=2, color="blue", label="WT Real", linestyle=:dash)
    plot!(plt_P, T, P_WT_inyect, subplot=rho, linewidth=2, color="blue", label="WT Inyect")
end
display(plt_P)

plt_Q = plot(layout = (2,2), 
    size=(800,800), xlim=[1, 24], xlabel="Hora", ylabel="Potencia reactiva [MVAr]", 
    legend=false, margin=2px, bottom_margin = 40px)
for rho in ESC
    Q_import = toarray(JuMP.value.(Q[1,:,rho]/1e6))
    Q_demand = toarray(JuMP.value.(sum(Qload_rho[i,:,rho]/1e6 for i in I)))
    Q_inyect = toarray(JuMP.value.(Q_AME_total[rho,:]/1e6))
    Q_PV_disp = toarray(JuMP.value.(P_PV_total_real[rho,:]*tg0/1e6))
    Q_WT_disp = toarray(JuMP.value.(P_WT_total_real[rho,:]*tg0/1e6))
    plot!(plt_Q, T, Q_import, subplot=rho, linewidth=2, color=Dict_season[season[rho]], title=string(season[rho]), label="Import") 
    plot!(plt_Q, T, Q_demand, subplot=rho, linewidth=2, color=Dict_season[season[rho]], alpha=0.5, label="Demand", linestyle=:dash)
    plot!(plt_Q, T, Q_inyect, subplot=rho, linewidth=2, color="black", label="Inyect")
    plot!(plt_Q, T, Q_PV_disp, subplot=rho, linewidth=2, color="orange", label="PV Real", alpha=0.6, linestyle=:dash)
    plot!(plt_Q, T, Q_WT_disp, subplot=rho, linewidth=2, color="blue", label="WT Real",  alpha=0.6, linestyle=:dash)
end
display(plt_Q)

# ------- Voltaje
plt_V = plot(layout = (2,2), 
    size=(800,800), xlim=[1, 24], xlabel="Hora", ylabel="Voltaje [p.u.]", 
    legend=false, margin=2px, bottom_margin = 40px)

for rho in ESC
    for i in I
        volt = toarray(sqrt.(JuMP.value.(v[i,:,rho]))/VB)
        plot!(plt_V, T, volt, subplot=rho, linewidth=2, label=string("User ", i), title=string(season[rho]))
    end
end
display(plt_V)

# ------- Corriente
plt_I = plot(layout = (2,2), 
    size=(800,800), xlim=[1, 24], xlabel="Hora", ylabel="Corriente [A]", 
    legend=false, margin=2px, bottom_margin = 40px)

for rho in ESC
    for i in I
        current = toarray(sqrt.(U[i,:,rho]))
        plot!(plt_I, T, current, subplot=rho, linewidth=2, label=string("User ", i), title=string(season[rho]))
    end
end
display(plt_I)

# ------- Precio
plt_spot = plot(size=(500,500), xlim=[1, 24], xlabel="Hora", ylabel="Precio [USD/MWh]", 
legend=false, margin=2px, bottom_margin = 40px)
for rho in ESC
    plot!(plt_spot, T, p_spot[rho,:]*1e6, linewidth=2, color=Dict_season[season[rho]], title="Precio energia", label=season[rho])
end
display(plt_spot)

# ------- Perdidas de potencia
plt_losses = plot(size=(700,400), xlim=[1, 24], xlabel="Hora", ylabel="Potencia [kWh]", 
legend=false, margin=2px, bottom_margin = 40px)
for rho in ESC
    plot!(plt_losses, T, P_losses[rho,:]*1e-3, linewidth=2, color=Dict_season[season[rho]], title="Energia perdida", label=season[rho])
end
display(plt_losses)

# ------- Perdidas de dinero
money_loss = p_spot .* P_losses
plt_moneylosses = plot(size=(700,400), xlim=[1, 24], xlabel="Hora", ylabel="Dinero [USD]", 
legend=false, margin=2px, bottom_margin = 40px)
for rho in ESC
    plot!(plt_moneylosses, T, money_loss[rho,:], linewidth=2, color=Dict_season[season[rho]], title="Dinero perdido", label=season[rho])
end
display(plt_moneylosses)

# ------- GD
plt_PV = plot(layout = (2,2), 
    size=(800,800), xlim=[1, 24], xlabel="Hora", ylabel="Potencia activa [W] PV", 
    legend=false, margin=2px, bottom_margin = 40px)

for rho in ESC
    for i in PV_installed
        P_PV_iny = toarray(JuMP.value.(P_PV[i,:,rho]))
        P_PV_curt = toarray(JuMP.value.(P_PV_cur[i,:,rho]))
        P_PV_real = toarray(JuMP.value.(sum(G_PV_rho[w,:,rho]*xpv[i,w] for w in W)))
        plot!(plt_PV, T, P_PV_iny, subplot=rho, linewidth=2, label=string("User ", i), title=string(season[rho]))
        plot!(plt_PV, T, P_PV_curt, subplot=rho, linewidth=2, label=string("User ", i, " (APC)"), title=string(season[rho]))
        plot!(plt_PV, T, P_PV_real, subplot=rho, linewidth=2, label=string("User ", i, " (disp)"), linestyle=:dash, title=string(season[rho]))
    end
end
display(plt_PV)

plt_WT = plot(layout = (2,2), 
    size=(800,800), xlim=[1, 24], xlabel="Hora", ylabel="Potencia activa [W] WT", 
    legend=false, margin=2px, bottom_margin = 40px)

for rho in ESC
    for i in WT_installed
        P_WT_iny = toarray(JuMP.value.(P_WT[i,:,rho]))
        P_WT_curt = toarray(JuMP.value.(P_WT_cur[i,:,rho]))
        P_WT_real = toarray(JuMP.value.(sum(G_WT_rho[w,:,rho]*xwt[i,w] for w in W)))
        plot!(plt_WT, T, P_WT_iny, subplot=rho, linewidth=2, label=string("User ", i), title=string(season[rho]))
        plot!(plt_WT, T, P_WT_curt, subplot=rho, linewidth=2, label=string("User ", i, " (APC)"), title=string(season[rho]))
        plot!(plt_WT, T, P_WT_real, subplot=rho, linewidth=2, label=string("User ", i, " (disp)"), linestyle=:dash, title=string(season[rho]))
    end
end
display(plt_WT)

# ------- RPC
plt_RPC = plot(layout = (2,2), 
    size=(800,800), xlim=[1, 24], xlabel="Hora", ylabel="Potencia reactiva [kVAr]", 
    legend=false, margin=2px, bottom_margin = 40px)

for rho in ESC
    for i in SVC_installed
        Q_AME_SVC = toarray(JuMP.value.(Q_SVC[i,:,rho]))/1e3
        plot!(plt_RPC, T, Q_AME_SVC, subplot=rho, linewidth=2, label=string("User ", i), title=string(season[rho]))
    end
    
    for i in PV_installed
        Q_AME_PV = toarray(JuMP.value.(Q_PV[i,:,rho]))/1e3
        plot!(plt_RPC, T, Q_AME_PV, subplot=rho, linewidth=2, label=string("User ", i), title=string(season[rho]))
    end
    
    for i in WT_installed
        Q_AME_WT = toarray(JuMP.value.(Q_WT[i,:,rho]))/1e3
        plot!(plt_RPC, T, Q_AME_WT, subplot=rho, linewidth=2, label=string("User ", i), title=string(season[rho]))
    end

    for i in CB_installed
        Q_AME_CB = toarray(JuMP.value.(Q_CB[i,:,rho]))/1e3
        plot!(plt_RPC, T, Q_AME_CB, subplot=rho, linewidth=2, label=string("User ", i), title=string(season[rho]))
    end
end

display(plt_RPC)