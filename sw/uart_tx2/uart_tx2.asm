
            0x00FF    imm         \ push GP_out data (FF)
            0x0032    imm         \ push GP_out address (32)
                      io!         \ store AA to I/O address 30
                     
            0x00FF    imm         \ push GP_out data (FF)
            0x0030    imm         \ push GP_out address (30)
                      io!         \ store FF to I/O address 30
                    

            0x0000    imm         \ push GP_out data (00)
            0x0030    imm         \ push GP_out address (30)
                      io!         \ store 00 to I/O address 30 
                      
            0x00AA    imm         \ push UART_TX_DATA data (AA)
            0x0000    imm         \ push UART_TX_DATA address (00)
                      io!         \ store AA to I/O address 30
                      
             20        imm          \ push 20
            0x0019    scall        \ call DELAY       

            0x00CC    imm         \ push UART_TX_DATA data (CC)
            0x0000    imm         \ push UART_TX_DATA address (00)
                      io!         \ store AA to I/O address 30
                      
            20        imm          \ push 20
            0x0019    scall        \ call DELAY
                     
            0x0004    ubranch     \ branch to 0004
  
            0x0000    imm         \ DELAY subroutine Push 0000
                      invert          
                      +
                      dup
            0x001F    0branch     \ branch to skip
            0x0019    ubranch     \ ubranch to DELAY
                      pexit       \ return from sub with stack pop

