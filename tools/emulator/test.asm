  0x00FF    imm         \ push GP_out data (FF)
          0x0032    imm         \ push GP_out address (32)
                       io!         \ store AA to I/O address 30
 
             0x00AA    imm         \ push GP_out data (AA)
             0x0030    imm         \ push GP_out address (30)
                       io!         \ store AA to I/O address 30
 
             0x01F4   imm         \ Push 0D500 on the stack   
          0x0018    scall       \ call Big Delay
             0x0055    imm         \ push GP_out data (55)
             0x0030    imm         \ push GP_out address (30)
                       io!         \ store 55 to I/O address 30
 
             0x01F4    imm         \ Push 0D500 on the stack         
             0x0018    scall       \ call Big Delay
             0x0004    ubranch     \ branch to 0004
             0x0000    imm         \ Small DELAY subroutine Push 0000
                       invert          
                       +
                       dup
             0x0017    0branch     \ branch to skip
             0x0011    ubranch     \ ubranch to Small Delay
                       exit       \ return from sub with stack pop
             0x0000    imm         \ Big DELAY subroutine Push 0000
                       invert          
                       +
                       dup
             0x0A6A    imm        \ push 0D2666 (1 millisecond)
             0x0011    scall      \ call Small delay
             0x0020   0branch     \ branch to skip
             0x0018    ubranch    \ ubranch to Big Delay
                       exit      \ return from sub with stack pop