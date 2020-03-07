$xloc_addr 0x1000
$yloc_addr 0x1001
$frame_delay  13


              0x0000        imm    \ push x initial loc
  
  %Loop                     dup
              $xloc_addr    imm    \ push write x loc address
                            io!

               500          imm    \ push y initial loc
              $yloc_addr    imm    \ push write y loc address
                            io! 
                                    
              $frame_delay   imm    \ push delay value
              %ScreenDelay  scall  \ call screen delay
              0x0001        imm    \ increment x loc by 1
                            +
                            dup
              1260          imm     \ push screen width 
                            =       \ compare location to screen width
              %Loop         0branch \ restart loop if not at edge of screen
              




              0x0000    imm         \ Small DELAY subroutine Push 0000
                        invert
                        +
                        dup
              0x0002    0branchr    \ branchr to skip
              0x0FFB   ubranchr     \ ubranchr -5 to Small Delay 
                        pexit       \ return from sub with stack pop

 %ScreenDelay 0x0000    imm         \ Big DELAY subroutine Push 0000
                        invert          
                        +
                        dup
              
              0x0A6A    imm        \ push 0D2666 (1 millisecond)
              0x0011    scallr     \ callr -12 Small delay
              0x0002    0branchr    \ branchr to skip
              0x0FF9    ubranchr   \ ubranchr -7 to Big Delay
                        pexit      \ return from sub with stack pop