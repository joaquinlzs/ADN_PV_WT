# -------------------------------- Etiquetas para la impresion
lbl_time = []
for t in T
    push!(lbl_time, string("t=", t-1))
end

lbl_user = [[]]
for i in I
    push!(lbl_user[1], string("User ", i))
end

# -------------------------------- Creacion de archivos
# Variable P
filename = string("Resultados Excel/", code, "_P.xlsx")
gap = 2
XLSX.openxlsx(filename, mode="w") do xf
    sheet = xf[1]
    XLSX.rename!(sheet, "P(i,t,rho)")
    cont = 0
    for rho in ESC
        aux = Vector()
        for t in T
            push!(aux, JuMP.value.(P[:,t,rho]))
        end
        XLSX.writetable!(sheet, aux, lbl_time, anchor_cell=XLSX.CellRef(string("B", (users+gap)*cont+1)))
        XLSX.writetable!(sheet, lbl_user, ["Usuarios"], anchor_cell=XLSX.CellRef(string("A", (users+gap)*cont+1))) 
        cont += 1
    end
end

# Variable Q
filename = string("Resultados Excel/", code, "_Q.xlsx")
gap = 2
XLSX.openxlsx(filename, mode="w") do xf
    sheet = xf[1]
    XLSX.rename!(sheet, "Q(i,t,rho)")
    cont = 0
    for rho in ESC
        aux = Vector()
        for t in T
            push!(aux, JuMP.value.(Q[:,t,rho]))
        end
        XLSX.writetable!(sheet, aux, lbl_time, anchor_cell=XLSX.CellRef(string("B", (users+gap)*cont+1)))
        XLSX.writetable!(sheet, lbl_user, ["Usuarios"], anchor_cell=XLSX.CellRef(string("A", (users+gap)*cont+1))) 
        cont += 1
    end
end

# Variable V
filename = string("Resultados Excel/", code, "_V.xlsx")
gap = 2
XLSX.openxlsx(filename, mode="w") do xf
    sheet = xf[1]
    XLSX.rename!(sheet, "v(i,t,rho)")
    cont = 0
    for rho in ESC
        aux = Vector()
        for t in T
            push!(aux, JuMP.value.(v[:,t,rho]))
        end
        XLSX.writetable!(sheet, aux, lbl_time, anchor_cell=XLSX.CellRef(string("B", (users+gap)*cont+1)))
        XLSX.writetable!(sheet, lbl_user, ["Usuarios"], anchor_cell=XLSX.CellRef(string("A", (users+gap)*cont+1))) 
        cont += 1
    end
end

# Variable U
filename = string("Resultados Excel/", code, "_U.xlsx")
gap = 2
XLSX.openxlsx(filename, mode="w") do xf
    sheet = xf[1]
    XLSX.rename!(sheet, "u(i,t,rho)")
    cont = 0
    for rho in ESC
        aux = Vector()
        for t in T
            push!(aux, JuMP.value.(u[:,t,rho]))
        end
        XLSX.writetable!(sheet, aux, lbl_time, anchor_cell=XLSX.CellRef(string("B", (users+gap)*cont+1)))
        XLSX.writetable!(sheet, lbl_user, ["Usuarios"], anchor_cell=XLSX.CellRef(string("A", (users+gap)*cont+1))) 
        cont += 1
    end
end

# Variable Saturacion de lineas
filename = string("Resultados Excel/", code, "_Saturation.xlsx")
gap = 2
XLSX.openxlsx(filename, mode="w") do xf
    sheet = xf[1]
    XLSX.rename!(sheet, "saturation(i,t,rho)")
    cont = 0
    for rho in ESC
        aux = Vector()
        for t in T
            push!(aux, JuMP.value.(saturation[:,t,rho]))
        end
        XLSX.writetable!(sheet, aux, lbl_time, anchor_cell=XLSX.CellRef(string("B", (users+gap)*cont+1)))
        XLSX.writetable!(sheet, lbl_user, ["Usuarios"], anchor_cell=XLSX.CellRef(string("A", (users+gap)*cont+1))) 
        cont += 1
    end
end

# Parametro Load
filename = string("Resultados Excel/", code, "_Pload.xlsx")
gap = 2
XLSX.openxlsx(filename, mode="w") do xf
    sheet = xf[1]
    XLSX.rename!(sheet, "Load_rho(i,t,rho)")
    cont = 0
    for rho in ESC
        aux = Vector()
        for t in T
            push!(aux, JuMP.value.(Pload_rho[:,t,rho]))
        end
        XLSX.writetable!(sheet, aux, lbl_time, anchor_cell=XLSX.CellRef(string("B", (users+gap)*cont+1)))
        XLSX.writetable!(sheet, lbl_user, ["Usuarios"], anchor_cell=XLSX.CellRef(string("A", (users+gap)*cont+1))) 
        cont += 1
    end
end

# Perdidas
filename = string("Resultados Excel/", code, "_losses.xlsx")
gap = 2
XLSX.openxlsx(filename, mode="w") do xf
    sheet = xf[1]
    XLSX.rename!(sheet, "Losses(rho,t)")
    cont = 0
    aux = Vector()
    for t in T
        push!(aux, JuMP.value.(P_losses[:,t]))
    end
    XLSX.writetable!(sheet, aux, lbl_time, anchor_cell=XLSX.CellRef(string("B", (users+gap)*cont+1)))
    XLSX.writetable!(sheet, [season], ["Usuarios"], anchor_cell=XLSX.CellRef(string("A", (users+gap)*cont+1))) 
    cont += 1
end
        

# Costos 
lbl_cost = ["INV Lineas", "INV Trafo", "INV PV", "INV WT", "INV SVC", "INV OLTC", "INV CB", "INV Total", "OPR year", "OPR OyM year", "Costo total descontado"]
aux = []
push!(aux, JuMP.value.(INV_L))
push!(aux, JuMP.value.(INV_TR))
push!(aux, JuMP.value.(INV_PV))
push!(aux, JuMP.value.(INV_WT))
push!(aux, JuMP.value.(INV_SVC))
push!(aux, JuMP.value.(INV_OLTC))
push!(aux, JuMP.value.(INV_CB))
push!(aux, JuMP.value.(INV_TOTAL))
push!(aux, JuMP.value.(OPR_TOTAL_rho))
push!(aux, JuMP.value.(OPR_om))
push!(aux, JuMP.value.(INV_TOTAL + DF*(OPR_TOTAL_rho+OPR_om)))

filename = string("Resultados Excel/", code, "_Costos.xlsx")
XLSX.openxlsx(filename, mode="w") do xf
    sheet = xf[1]
    XLSX.rename!(sheet, "Costos")
    cont = 0
    XLSX.writetable!(sheet, aux, lbl_cost, anchor_cell=XLSX.CellRef(string("B", 1)))
end

# Penetracion renovables
lbl_PENRE = [season..., "Ponderado"]
aux = []
for rho in ESC
    push!(aux, JuMP.value.(penetration_RE[rho]))
end
push!(aux, JuMP.value.(penetration_RE' * rho))

filename = string("Resultados Excel/", code, "_Penetracion.xlsx")
XLSX.openxlsx(filename, mode="w") do xf
    sheet = xf[1]
    XLSX.rename!(sheet, "Penetracion RE")
    cont = 0
    XLSX.writetable!(sheet, aux, lbl_PENRE, anchor_cell=XLSX.CellRef(string("B", 1)))
end

# Inyeccion de GD
filename = string("Resultados Excel/", code, "_P_PV.xlsx")
gap = 2
XLSX.openxlsx(filename, mode="w") do xf
    sheet = xf[1]
    XLSX.rename!(sheet, "P_PV(rho,t)")
    cont = 0
    aux = Vector()
    for t in T
        push!(aux, JuMP.value.(P_PV_total[:,t]))
    end
    XLSX.writetable!(sheet, aux, lbl_time, anchor_cell=XLSX.CellRef(string("B", (users+gap)*cont+1)))
    XLSX.writetable!(sheet, [season], ["Usuarios"], anchor_cell=XLSX.CellRef(string("A", (users+gap)*cont+1))) 
    cont += 1
end

filename = string("Resultados Excel/", code, "_P_WT.xlsx")
gap = 2
XLSX.openxlsx(filename, mode="w") do xf
    sheet = xf[1]
    XLSX.rename!(sheet, "P_WT(rho,t)")
    cont = 0
    aux = Vector()
    for t in T
        push!(aux, JuMP.value.(P_WT_total[:,t]))
    end
    XLSX.writetable!(sheet, aux, lbl_time, anchor_cell=XLSX.CellRef(string("B", (users+gap)*cont+1)))
    XLSX.writetable!(sheet, [season], ["Usuarios"], anchor_cell=XLSX.CellRef(string("A", (users+gap)*cont+1))) 
    cont += 1
end