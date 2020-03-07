\       this example has a relative branch in Big Delay
$mSecDly       500                \ milliseconds Delay value for Big Delay
$mSecCnt      2666                \ milliseconds Count value for Small Delay

            0x00FF    imm         \ push GP_out data (FF)
            0x0032    imm         \ push GP_out address (32)
                      io!         \ store AA to I/O address 30
                     
%LoopStrt   0x00AA    imm         \ push GP_out data (AA)
            0x0030    imm         \ push GP_out address (30)
                      io!         \ store AA to I/O address 30
                     
            0x01F4    imm         \ Push 0D500 on the stack
            %BigDly   scall       \ call Big Delay

            0x0055    imm         \ push GP_out data (55)
            0x0030    imm         \ push GP_out address (30)
                      io!         \ store 55 to I/O address 30
                     
            $mSecDly  imm         \ Push $mSecDly on the stack
            %BigDly   scallr      \ call %BigDly
             
            %LoopStrt ubranch     \ branch to %LoopStrt
  
%SmallDly   0x0000    imm         \ Small DELAY subroutine Push 0000
                      invert          
                      +
                      dup
            %RetSD    0branch     \ branch to %RetSD
            %SmallDly ubranch     \ ubranch to %SmallDly
%RetSD                pexit       \ return from sub with stack pop

%BigDly     0x0001    imm         \ Big DELAY subroutine Push 0001
                      -           \ Subtract 1 from BigDly loopcount
            
            $mSecCnt  imm         \ push 0d2666 (1 millisecond)
            %SmallDly scall       \ call %SmallDly

                      dup         \ dup BigDly loopcount
            0x0000    imm         \ push 0 on stack
                      =           \ compare BigDly loopcount to 0
            %BigDly   0branchr    \ branch to %BigDly if loopcount not 0
%RetBD                pexit       \ return from sub with stack pop
