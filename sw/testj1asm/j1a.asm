

             00AA    imm         \ push GP_out data (AA)
             0030    imm         \ push GP_out address (30)
                     io!         \ store AA to I/O address 30

             0055    imm         \ push GP_out data (55)
             0030    imm         \ push GP_out address (30)
                     io!         \ store 55 to I/O address 30
             
             0000    ubranch     \ branch to 0000
