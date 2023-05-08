# ---------------------------- F U N C I O N E S ---------------------------- #
function P_up(j,t,rho)   #Línea que alimenta a bus j (solo puede ser una)
    list = [P[j,t,rho]]
    return list
end
# ---------
function P_down(j,t,rho) # Lineas alimentadas por el bus j (pueden ser varias)
    bus_down = [k for k in I if ((A[j][k]>0) & (j != k))]
    if isempty(bus_down)
        list = [0]
    else
        list = [P[i,t,rho] for i in bus_down]
    end
    return list
end
# ---------
function Q_up(j,t,rho)   
    list = [Q[j,t,rho]]
    return list
end
# ---------
function Q_down(j,t,rho)
    bus_down = [k for k in I if ((A[j][k]>0) & (j != k))]
    if isempty(bus_down)
        list = [0]
    else
        list = [Q[i,t,rho] for i in bus_down]
    end
    return list
end
# ---------
function V_up(j,t,rho)   # Bus aguas arriba del bus j (solo puede ser uno)
    bus_up = [k for k in I if ((A[k][j]>0) & (j != k))]
    list = [v[i,t,rho] for i in bus_up]
    return list[1]
end

# ---------
function toarray(container)
    list = []
    for i in 1:size(container)[1]
        push!(list, container[i])
    end
    return(list)
end