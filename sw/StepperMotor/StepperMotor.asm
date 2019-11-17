               \ milliseconds Count value for Small Delay 

                        0x00FF    imm         \ push GP_out data (FF)
                        0x0032    imm         \ push GP_out address (32)
                                  io!         \ store AA to I/O address 30
                                              
                        0x000A    imm         \ push GP_out data (0A)
                        0x0030    imm         \ push GP_out address (30)
                                  io!         \ store AA to I/O address 30
                                  
                        100  imm         \ Push 0D500 on the stack   
                        0x0024     scall       \ call Big Delay
                        
                        0x0009    imm         \ push GP_out data (0F)
                        0x0030    imm         \ push GP_out address (30)
                                  io!         \ store AA to I/O address 30
                                 
                        100    imm         \ Push 0D500 on the stack   
                        0x0024     scall       \ call Big Delay         
                         
                        0x0005    imm         \ push GP_out data (0A)
                        0x0030    imm         \ push GP_out address (30)
                                  io!         \ store AA to I/O address 30
                                  
                        100  imm         \ Push 0D500 on the stack   
                        0x0024     scall       \ call Big Delay
                        
                        0x0006    imm         \ push GP_out data (0F)
                        0x0030    imm         \ push GP_out address (30)
                                  io!         \ store AA to I/O address 30
                                 
                        100    imm         \ Push 0D500 on the stack   
                        0x0024     scall       \ call Big Delay   
                         
                         
                         
                      
                         
                        0x0004    ubranch     \ branch to 0004
              
              
            
            0x0000    imm         \ Small DELAY subroutine Push 0000
                                  invert          
                                  +
                                  dup
                     0x0023   0branch     \ branch to skip
                     0x001D  ubranch     \ ubranch to Small Delay
              pexit       \ return from sub with stack pop

               0x0000    imm         \ Big DELAY subroutine Push 0000
                                  invert          
                                  +
                                  dup
                        
                         2666     imm         \ push 0D2666 (1 millisecond)
                      0x001D scall       \ call Small delay
                      0x002C    0branch     \ branch to skip
                      0x0024   ubranch     \ ubranch to Big Delay
                pexit       \ return from sub with stack pop