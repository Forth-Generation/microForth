
            0x00FF    imm         \ push GP_out data (FF)
            0x0032    imm         \ push GP_out address (32)
                      io!         \ store FF to I/O address 32
                     
            0x00AA    imm         \ push GP_out data (AA)
            0x0030    imm         \ push GP_out address (30)
                      io!         \ store AA to I/O address 30
                     
            0x0010    imm         \ Push 0d16 on the stack   
            0x0011    scall       \ call Delay

            0x0055    imm         \ push GP_out data (55)
            0x0030    imm         \ push GP_out address (30)
                      io!         \ store 55 to I/O address 30
                     
            0x010    imm         \ Push 0D16 on the stack         
            0x0011    scall       \ call Delay
             
            0x0004    ubranch     \ branch to 0004
  
            0x0000    imm         \ DELAY subroutine Push 0000
                      invert          
                      +
                      dup
            0x0017    0branch     \ branch to skip
            0x0011    ubranch     \ ubranch to Delay
                      pexit       \ return from sub with stack pop
