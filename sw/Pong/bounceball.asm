$xloc_addr 0x1F0                    \ ball x location address
$yloc_addr 0x1F1                    \ ball y location address
$Fsem_addr 0x033                    \ Frame sync semaphore address
$Fsem_set  0x0001                   \ Frame sync semaphore set value
$Fsem_clr  0x0000                   \ Frame sync semaphore clr value


              $Fsem_set     imm     \ push Fsem set value
              $Fsem_addr    imm     \ push Fsem address
                            io!     \ write/set Fsem

              0x0000        imm     \ push x initial loc

%Loop         %WaitFsem     scall   \ wait for Frame semaphone
                            dup
              $xloc_addr    imm     \ push write x loc address
                            io!

               500          imm     \ push y initial loc
              $yloc_addr    imm     \ push write y loc address
                            io! 
                                    
              0x0001        imm     \ increment x loc by 1
                            +
                            dup
              1260          imm     \ push screen width 
                            =       \ compare location to screen width
              %Loop         0branch \ restart loop if not at edge of screen


                   \\ Wait for Fsem clear
%WaitFsem     $Fsem_addr    imm     \ push Fsem address
                            io@     \ read Fsem
              $Fsem_clr     imm     \ push Fsem clr value
                            =       \ check if Fsem clr
              %WaitFsem     0branch \ continue to wait for Fsem clear
                            exit    \ return - Fsem clr
