$xloc_addr 0x1F0
$yloc_addr 0x1F1
$frame_delay  13


              0x0000        imm    \ push x initial loc
  
%Loop                       dup
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
              0x0017    0branchr    \ branchr to skip
              0x0011    ubranchr     \ ubranchr -5 to Small Delay 
                        pexit       \ return from sub with stack pop

%ScreenDelay  0x0000    imm         \ Big DELAY subroutine Push 0000
                        invert          
                        +
                        dup
              
                2666    imm        \ push 0D2666 (1 millisecond)
              0x0011    scallr     \ callr -12 Small delay
              0x0020    0branchr    \ branchr to skip
              0x0018    ubranchr   \ ubranchr -7 to Big Delay
                        pexit      \ return from sub with stack pop
