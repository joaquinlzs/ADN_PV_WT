# ---------------------------- C A N D I D A T O S ---------------------------- #
lista_L = [75, 200, 300, 500, 700, 2000]    # A                             
lista_TR = [476, 635, 794]                  # A (6, 8 y 10 MVA en base a 12.k66 kV)     
lista_PV = [1, 2, 3, 4, 5, 6]*100*k          # de 100 a 600 kWp                     
lista_WT = [1, 2, 3, 4, 5, 6]*100*k          # de 100 a 600 kWp                     
lista_SVC = [300000, 600000]                # VAr inductivo                      
lista_CB = 30000                            # VAr                                 

costo_L = 500*lista_L                       # 500 $/A  
costo_L[1] = 0
costo_TR = [10800, 14000, 17200]            # 1600 $/MVA + 1200               
costo_PV = 1510*(lista_PV/1000)*0.7         # $1510 /kWp                           
costo_WT = 1230*(lista_WT/1000)             # $1230 /kWp                               
costo_SVC = 100*(lista_SVC/1000)            # $100 / kVAr                              
costo_OLTC = 1                              # $1                                           
costo_CB = 5*(lista_CB/1000)                # $5 /kVAr                                  

base_L = 1
base_TR = lista_TR[1] 

# AME
CB_max = 6                                  # Cantidad maxima de CB permitidos por bus
