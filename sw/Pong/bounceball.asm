\
\  Program to bounce/reflect ball off of bounding box walls
\    going right dX = -dX when ball is > right
\    going left -dX =  dX when ball is < left
\    going up    dY = -dY when ball is > top
\    going up   -dY =  dY when ball is < bottom
\


$vxloc_addr 0x1F0                   \ VGA ball x location address
$vyloc_addr 0x1F1                   \ VGA ball y location address
$Fsem_addr  0x033                   \ Frame sync semaphore address
$Fsem_set   0x0001                  \ Frame sync semaphore set value
$Fsem_clr   0x0000                  \ Frame sync semaphore clr value

$xadd       0x000A                  \ x add (move right) signed 14.2 value 0A = 2.5
$xsub       0xFFF6                  \ x sub (move left)  signed 14.2 value
$yadd       0x000A                  \ y add (move up)    signed 14.2 value 0A = 2.5
$ysub       0xFFF6                  \ y sub (move down)  signed 14.2 value

$xmin            0                  \ min x val of ball {left}
$xmax         1263                  \ max x val of ball {right}
$ymin            0                  \ min y val of ball {bottom}
$ymax         1007                  \ max y val of ball {top}
$b0mask     0x0001                  \ bit 0 mask
$b1mask     0x0002                  \ bit 1 mask


              %SetFsem      scall   \ set Fsem                 ( )

%MoveUR       %WaitFsem     scall   \ wait until Fsem=0        ( )

              %AddX         scall   \ move xloc Right          ( TurnStat{0000_0000_0000_000X} )
              %AddY         scall   \ move yloc Up             ( TurnStat{0000_0000_0000_00YX} )




                   \\ Wait for Frame semaphore clear
%WaitFsem     $Fsem_addr    imm     \ push Fsem address
                            io@     \ read Fsem
              $Fsem_clr     imm     \ push Fsem clr value
                            =       \ check if Fsem == Fsem_clr
              %WaitFsem     0branch \ continue to wait for Fsem clear
                            exit    \ return - Fsem clr


                   \\ Set Frame semaphore
%SetFsem      $Fsem_set     imm     \ push Fsem set value
              $Fsem_addr    imm     \ push Fsem address
                            io!RET  \ write/set Fsem


                   \\ Add to xloc (go Right)
                   \\ TOS exit value TurnStat ( {0=ltRight/1=gtRight} )
%AddX         %xloc         imm     \ push address of xloc     ( %xloc )
                            @       \ fetch xloc               ( xloc )
              $xadd         imm     \ push xadd                ( xadd,xloc )
                            +       \                          ( xloc+xadd )
              %xloc         imm     \ push address of xloc     ( %xloc,xloc+xadd )
                            !ad     \ write new xloc to xloc   ( xloc+xadd )
                            2/      \ shift right              ( xloc+xadd >> 1 )
                            2/      \ shift right              ( xloc+xadd >> 2 )
              $vxloc_addr   imm     \ push VGA x loc address   ( xloc_add,xloc+xadd )
                            io!ad   \ write new xloc to VGA    ( xloc+xadd >> 2 )
              $xmax         imm     \ push xmax                ( xmax,new xloc )
                            swap    \                          ( new xloc,xmax )
                            <       \ xmax < xloc ?            ( 0xFFFF(lt)/0x0000(gt) )
              $b0mask       imm     \ push b0mask              ( b0mask,lt/gt )
                            andRET  \                          ( TurnStat{0000_0000_0000_000X} )


                   \\ Add to yloc (go Up)
                   \\ TOS enter value TurnStat ( 0000_0000_0000_000R )
                   \\ TOS exit  value TurnStat ( 0000_0000_0000_00TR )
%AddY         %yloc         imm     \ push address of yloc     ( %yloc,TurnStat )
                            @       \ fetch yloc               ( yloc,TurnStat )
              $yadd         imm     \ push yadd                ( yadd,yloc,TurnStat )
                            +       \                          ( yloc+yadd,TurnStat )
              %yloc         imm     \ push address of yloc     ( %yloc,yloc+yadd,TurnStat )
                            !ad     \ write new yloc to yloc   ( yloc+yadd,TurnStat )
                            2/      \ shift right              ( yloc+yadd >> 1,TurnStat )
                            2/      \ shift right              ( yloc+yadd >> 2,TurnStat )
              $vyloc_addr   imm     \ push VGA y loc address   ( yloc_add,yloc+yadd,TurnStat )
                            io!ad   \ write new yloc to VGA    ( yloc+yadd >> 2,TurnStat )
              $ymax         imm     \ push ymax                ( ymax,new yloc,TurnStat )
                            swap    \                          ( new yloc,ymax,TurnStat )
                            <       \ ymax < yloc ?            ( 0xFFFF(lt)/0x0000(gt),TurnStat )
              $b1mask       imm     \ push b0mask              ( b1mask,lt/gt,TurnStat )
                            and     \                          ( 0x0002(lt)/0x0000(gt),0000_0000_0000_000X )
                            orRET   \                          ( TurnStat{0000_0000_0000_00YX} )


                   \\ Sub from xloc (go Left)
                   \\ TOS exit value TurnStat ( {0=gtLeft/1=ltLeft} )
%SubX         %xloc         imm     \ push address of xloc     ( %xloc )
                            @       \ fetch xloc               ( xloc )
              $xsub         imm     \ push xsub                ( xsub,xloc )
                            +       \                          ( xloc+xsub )
              %xloc         imm     \ push address of xloc     ( %xloc,xloc+xsub )
                            !ad     \ write new xloc to xloc   ( xloc+xsub )
                            2/      \ shift right              ( xloc+xsub >> 1 )
                            2/      \ shift right              ( xloc+xsub >> 2 )
              $vxloc_addr   imm     \ push VGA x loc address   ( xloc_add,xloc+xsub )
                            io!ad   \ write new xloc to VGA    ( xloc+xsub >> 2 )
              $xmin         imm     \ push xmin                ( xmin,new xloc )
                            <       \ xmin < xloc ?            ( 0xFFFF(lt)/0x0000(gt) )
              $b0mask       imm     \ push b0mask              ( b0mask,lt/gt )
                            andRET  \                          ( TurnStat{0000_0000_0000_000X} )


                   \\ Sub from yloc (go Down)
                   \\ TOS enter value TurnStat ( 0000_0000_0000_000X )
                   \\ TOS exit  value TurnStat ( 0000_0000_0000_00YX )
%SubY         %yloc         imm     \ push address of yloc     ( %yloc,TurnStat )
                            @       \ fetch yloc               ( yloc,TurnStat )
              $ysub         imm     \ push ysub                ( ysub,yloc,TurnStat )
                            +       \                          ( yloc+ysub,TurnStat )
              %yloc         imm     \ push address of yloc     ( %yloc,yloc+ysub,TurnStat )
                            !ad     \ write new yloc to yloc   ( yloc+ysub,TurnStat )
                            2/      \ shift right              ( yloc+ysub >> 1,TurnStat )
                            2/      \ shift right              ( yloc+ysub >> 2,TurnStat )
              $vyloc_addr   imm     \ push VGA y loc address   ( yloc_add,yloc+ysub,TurnStat )
                            io!ad   \ write new yloc to VGA    ( yloc+ysub >> 2,TurnStat )
              $ymin         imm     \ push ymin                ( ymin,new yloc,TurnStat )
                            <       \ ymin < yloc ?            ( 0xFFFF(lt)/0x0000(gt),TurnStat )
              $b1mask       imm     \ push b0mask              ( b1mask,lt/gt,TurnStat )
                            and     \                          ( 0x0002(lt)/0x0000(gt),0000_0000_0000_000X )
                            orRET   \                          ( TurnStat{0000_0000_0000_00YX} )

%xloc         0x0000        <dword> \ xloc variable  signed 14.2 value
%yloc         0x0000        <dword> \ yloc variable  signed 14.2 value