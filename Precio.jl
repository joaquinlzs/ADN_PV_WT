# Precio de la electricidad

p_spot = Array{Float64}(undef, size(rho)[1], 24)
p_spot[1,:] = [101 115 115 115 115 171 177 177 161 64 53 53 53 53 35 35 35 35 35 53 87 112 130 91]/1e6
p_spot[2,:] = [103 112 96 92 92 92 92 98 103 68 84 98 98 88 86 74 98 98 98 245 332 299 202 126]/1e6
p_spot[3,:] = [170 145 134 127 117 117 118 158 158 124 67 67 71 76 68 67 67 72 198 331 340 331 331 232]/1e6
p_spot[4,:] = [106 139 132 125 122 123 123 216 69 35 35 35 35 35 35 35 35 35 35 55 216 358 358 357]/1e6