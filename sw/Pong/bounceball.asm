\
\  Program to bounce/reflect ball off of bounding box walls
\    going right dX = -dX when ball is > right
\    going left -dX =  dX when ball is < left
\    going up    dY = -dY when ball is > top
\    going up   -dY =  dY when ball is < bottom
\


$vxloc_addr 0x1F0                      \ VGA ball x location address
$vyloc_addr 0x1F1                      \ VGA ball y location address
$Fsem_addr  0x033                      \ Frame sync semaphore address
$Fsem_set   0x0001                     \ Frame sync semaphore set value
$Fsem_clr   0x0000                     \ Frame sync semaphore clr value

$xadd       0x000A                     \ x add (move right) signed 14.2 value 0A = 2.5
$xsub       0xFFF6                     \ x sub (move left)  signed 14.2 value
$yadd       0x000A                     \ y add (move up)    signed 14.2 value 0A = 2.5
$ysub       0xFFF6                     \ y sub (move down)  signed 14.2 value

$xmin            0                     \ min x val of ball {left}
$xmax         1263                     \ max x val of ball {right}
$ymin            0                     \ min y val of ball {bottom}
$ymax         1007                     \ max y val of ball {top}
$b0mask     0x0001                     \ bit 0 mask
$b1mask     0x0002                     \ bit 1 mask


%MoveUR       %SetFsem      scall      \ set Fsem                 ( )
              %WaitFsem     scall      \ wait until Fsem=0        ( )
              %AddX         scall      \ move xloc Right          ( TurnStat )
              %GoRightU     0branchr   \ keep Right if TurnStat=0 ( )
                   \\ hit Right wall - X move left
              %AddY         scall      \ move yloc Up             ( TurnStat )
              %MoveUL       0branchr   \ go UL if TurnStat=0      ( )
              %MoveDL       ubranchr   \ hit UR corner - go DL    ( )
                   \\ didn't hit Right wall
%GoRightU     %AddY         scall      \ move yloc Up             ( TurnStat )
              %MoveUR       0branchr   \ go UR if TurnStat=0      ( )
              %MoveDR       ubranchr   \ hit Top wall - go DR     ( )


%MoveUL       %SetFsem      scall      \ set Fsem                 ( )
              %WaitFsem     scall      \ wait until Fsem=0        ( )
              %SubX         scall      \ move xloc Left           ( TurnStat )
              %GoLeftU      0branchr   \ keep Left if TurnStat=0  ( )
                   \\ hit Left wall - X move Right
              %AddY         scall      \ move yloc Up             ( TurnStat )
              %MoveUL       0branchr   \ go UL if TurnStat=0      ( )
              %MoveDR       ubranchr   \ hit UL corner - go DR    ( )
                   \\ didn't hit Left wall
%GoLeftU      %AddY         scall      \ move yloc Up             ( TurnStat )
              %MoveUL       0branchr   \ go UL if TurnStat=0      ( )
              %MoveDL       ubranchr   \ hit Top wall - go DL     ( )


%MoveDR       %SetFsem      scall      \ set Fsem                 ( )
              %WaitFsem     scall      \ wait until Fsem=0        ( )
              %AddX         scall      \ move xloc Right          ( TurnStat )
              %GoRightD     0branchr   \ keep Right if TurnStat=0 ( )
                   \\ hit Right wall - X move left
              %SubY         scall      \ move yloc Down           ( TurnStat )
              %MoveDL       0branchr   \ go UL if TurnStat=0      ( )
              %MoveUR       ubranchr   \ hit LR corner - go UR    ( )
                   \\ didn't hit Right wall
%GoRightD     %SubY         scall      \ move yloc Down           ( TurnStat )
              %MoveDR       0branchr   \ go DR if TurnStat=0      ( )
              %MoveUR       ubranchr   \ hit Bottom wall - go UR  ( )


%MoveDL       %SetFsem      scall      \ set Fsem                 ( )
              %WaitFsem     scall      \ wait until Fsem=0        ( )
              %SubX         scall      \ move xloc Left           ( TurnStat )
              %GoLeftD       0branchr  \ keep Left if TurnStat=0  ( )
                   \\ hit Left wall - X move Right
              %SubY         scall      \ move yloc Down           ( TurnStat )
              %MoveDR       0branchr   \ go DR if TurnStat=0      ( )
              %MoveUR       ubranchr   \ hit LL corner - go UR    ( )
                   \\ didn't hit Left wall
%GoLeftD      %SubY         scall      \ move yloc Down           ( TurnStat )
              %MoveDL       0branchr   \ go DL if TurnStat=0      ( )
              %MoveUL       ubranchr   \ hit Bottom wall - go UL  ( )



                   \\ Wait for Frame semaphore clear
%WaitFsem     $Fsem_addr    imm        \ push Fsem address
                            io@        \ read Fsem
              $Fsem_clr     imm        \ push Fsem clr value
                            =          \ check if Fsem == Fsem_clr
              %WaitFsem     0branch    \ continue to wait for Fsem clear
                            exit       \ return - Fsem clr


                   \\ Set Frame semaphore
%SetFsem      $Fsem_set     imm        \ push Fsem set value
              $Fsem_addr    imm        \ push Fsem address
                            io!RET     \ write/set Fsem & exit


                   \\ Add to xloc (go Right)
                   \\ TOS exit value TurnStat ( {0xFFFF=turn} )
%AddX         %xloc         imm        \ push address of xloc     ( %xloc )
                            @          \ fetch xloc               ( xloc )
              $xadd         imm        \ push xadd                ( xadd,xloc )
                            +          \                          ( xloc+xadd )
              %xloc         imm        \ push address of xloc     ( %xloc,xloc+xadd )
                            !ad        \ write new xloc to xloc   ( xloc+xadd )
                            2/         \ shift right              ( xloc+xadd >> 1 )
                            2/         \ shift right              ( xloc+xadd >> 2 )
              $vxloc_addr   imm        \ push VGA x loc address   ( xloc_add,xloc+xadd )
                            io!ad      \ write new xloc to VGA    ( xloc+xadd >> 2 )
              $xmax         imm        \ push xmax                ( xmax,new xloc )
                            swap       \                          ( new xloc,xmax )
                            <          \ turn if xmax < xloc      ( 0xFFFF(lt)/0x0000(gt) )
                            exit       \ return                   ( TurnStat )


                   \\ Add to yloc (go Up)
                   \\ TOS exit value TurnStat ( {0xFFFF=turn} )
%AddY         %yloc         imm        \ push address of yloc     ( %yloc )
                            @          \ fetch yloc               ( yloc )
              $yadd         imm        \ push yadd                ( yadd,yloc )
                            +          \                          ( yloc+yadd )
              %yloc         imm        \ push address of yloc     ( %yloc,yloc+yadd )
                            !ad        \ write new yloc to yloc   ( yloc+yadd )
                            2/         \ shift right              ( yloc+yadd >> 1 )
                            2/         \ shift right              ( yloc+yadd >> 2 )
              $vyloc_addr   imm        \ push VGA y loc address   ( yloc_add,yloc+yadd )
                            io!ad      \ write new yloc to VGA    ( yloc+yadd >> 2 )
              $ymax         imm        \ push ymax                ( ymax,new yloc )
                            swap       \                          ( new yloc,ymax )
                            <          \ turn if ymax < yloc      ( 0xFFFF(lt)/0x0000(gt) )
                            exit       \ return                   ( TurnStat )


                   \\ Sub from xloc (go Left)
                   \\ TOS exit value TurnStat ( {0xFFFF=turn} )
%SubX         %xloc         imm        \ push address of xloc     ( %xloc )
                            @          \ fetch xloc               ( xloc )
              $xsub         imm        \ push xsub                ( xsub,xloc )
                            +          \                          ( xloc+xsub )
              %xloc         imm        \ push address of xloc     ( %xloc,xloc+xsub )
                            !ad        \ write new xloc to xloc   ( xloc+xsub )
                            2/         \ shift right              ( xloc+xsub >> 1 )
                            2/         \ shift right              ( xloc+xsub >> 2 )
              $vxloc_addr   imm        \ push VGA x loc address   ( xloc_add,xloc+xsub )
                            io!ad      \ write new xloc to VGA    ( xloc+xsub >> 2 )
              $xmin         imm        \ push xmin                ( xmin,new xloc )
                            <          \ turn if xmin < xloc      ( 0xFFFF(lt)/0x0000(gt) )
                            exit       \ return                   ( TurnStat )


                   \\ Sub from yloc (go Down)
                   \\ TOS exit value TurnStat ( {0xFFFF=turn} )
%SubY         %yloc         imm        \ push address of yloc     ( %yloc )
                            @          \ fetch yloc               ( yloc )
              $ysub         imm        \ push ysub                ( ysub,yloc )
                            +          \                          ( yloc+ysub )
              %yloc         imm        \ push address of yloc     ( %yloc,yloc+ysub )
                            !ad        \ write new yloc to yloc   ( yloc+ysub )
                            2/         \ shift right              ( yloc+ysub >> 1 )
                            2/         \ shift right              ( yloc+ysub >> 2 )
              $vyloc_addr   imm        \ push VGA y loc address   ( yloc_add,yloc+ysub )
                            io!ad      \ write new yloc to VGA    ( yloc+ysub >> 2 )
              $ymin         imm        \ push ymin                ( ymin,new yloc )
                            <          \ turn if ymin < yloc      ( 0xFFFF(lt)/0x0000(gt) )
                            exit       \ return                   ( TurnStat )

%xloc         0x0000        <dword>    \ xloc variable  signed 14.2 value
%yloc         0x0000        <dword>    \ yloc variable  signed 14.2 value