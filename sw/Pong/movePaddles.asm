$ball_xloc_addr 0x1F0                    \ ball x location address
$bal_yloc_addr 0x1F1                    \ ball y location address
$p_left_loc_addr  0x1F2             \ left paddle y location address
$p_right_loc_addr 0x1F3             \ right paddle y location address

$ball_xloc_addr_SRAM 4096         \ ball x location SRAM address
$ball_dx_addr_SRAM   4097         \ ball x velocity
$ball_yloc_addr_SRAM 4098         \ ball y location SRAM address
$ball_dy_addr_SRAM   4099         \ ball y velocity

$joystick_status_addr   0x0040 		\ joystick status address
$left_paddle_up         0x0001      \ left paddle up indicator
$left_paddle_down       0x0002      \ left paddle down indicator
$right_paddle_up        0x0004      \ right paddle down indicator
$right_paddle_down        0x0008      \ right paddle up indicator
	
$dy_paddle	 0x0003	        	    \ paddle movement velocity
	
$Fsem_addr 0x033                    \ Frame sync semaphore address
$Fsem_set  0x0001                   \ Frame sync semaphore set value
$Fsem_clr  0x0000                   \ Frame sync semaphore clr value

$ball_x_min  30                       \
$ball_x_max  1260
                

                        600         imm    \ INITIAL ball x location
                                    dup
            $ball_xloc_addr         imm    \ ball x location address
                                    io!
            $ball_xloc_addr_SRAM    imm     \ ball x SRAM location
                                    !       \ write location to memory
                                    
                             2      imm     \ INITIAL x velocity
            $ball_dx_addr_SRAM      imm     \ x velocity SRAM adress
                                    !       \ write value to mem
                  
                        600         imm    \ INITIAL ball y location
                        dup
            $ball_yloc_addr         imm    \ ball y location address
            $ball_yloc_addr_SRAM    imm     \ ball y SRAM location
                                    !       \ write location to memory
                                    
                                    
                        0x0000      imm     \ initial right paddle postion
                                    dup
            $p_right_loc_addr       imm     \ right paddle position
                                    io!
             
                      0x0000        imm     \ initial left paddle postion
                                    dup
            $p_left_loc_addr        imm     \ left paddle position
                                    io!
                
%Loop           %WaitFsem           scall   \ wait for Frame semaphone
                %GetLeftJoystick    scall   \ get leftstick status

                $left_paddle_up     imm     \ push left paddle up indicator
                                    =       \ compare
                %SkipLeftUp         0branch \ skip
                %MoveLeftPaddleUp   scall   \

%SkipLeftUp     %GetLeftJoystick    scall   \ get leftstick status
                $left_paddle_down   imm     \ push left paddle up indicator
                                    =       \ compare
                %SkipLeftDown       0branch \ skip
                %MoveLeftPaddleDown scall   \
		
<<<<<<< HEAD
%SkipLeftDown   		            over

		%GetRightJoystick           scall
=======
%SkipLeftDown   		    over    \ start operations on right paddle
		%GetRightJoystick   scall
>>>>>>> master
		
		$right_paddle_up            imm     \ push right paddle up indicator
                                    =	    \ compare
		%SkipRightUp	            0branch \ skip
		%MoveRightPaddleUp          scall   \
		
%SkipRightUp    %GetRightJoystick   scall   \ get right stick status
		$right_paddle_down          imm     \ push right paddle up indicator
                                    =       \ compare
		%SkipRightDown              0branch \ skip
		%MoveRightPaddleDown        scall  \

%SkipRightDown			            over       \ swap left joystick addr back to top of stack

            \\ Ball
             $ball_dx_addr_SRAM       imm     \
                                      @imm    \ get x velocity
                                      
             $ball_xloc_addr_SRAM    imm    \ push ball x location SRAM address
                                     @imm   \ get xloc value

                                     +       \ add delta x to xloc
                                     dup     \
                                     dup     \

                                     
             $ball_xloc_addr_SRAM    imm     \ push ball x location SRAM address
                                     !       \ write new location back to SRAM
             $ball_x_loc_addr        imm     \ push VGA x loc address
                                     io!     \ write new location value to vga
                                     
                                     dup
             $ball_x_max             imm
                                     <
            %SwitchBallX             0branch \ Switch direction if x loc is not less than X maximum
             $ball_x_min             imm     \
                                     <       \
            %SkipSwitchBallX         0branch \ Skip switch ball direction if x loc is not less than X max
             %SwitchBallX            scall  \
             
             

<<<<<<< HEAD
%SkipSwitchBallX    $Fsem_set           imm     \ push Fsem set value
                    $Fsem_addr          imm     \ push Fsem address
                                        io!     \ write/set Fsem
                    %Loop               ubranch    \
=======
%SkipRightDown			    over    \ swap left joystick addr back to top of stack
		$Fsem_set           imm     \ push Fsem set value
                $Fsem_addr          imm     \ push Fsem address
                                    io!     \ write/set Fsem
                %Loop               ubranch    \
>>>>>>> master



                   \\ Wait for Fsem clear
%WaitFsem       $Fsem_addr      imm     \ push Fsem address
                                io@     \ read Fsem
                $Fsem_clr       imm     \ push Fsem clr value
                                =       \ check if Fsem clr
                %WaitFsem       0branch \ continue to wait for Fsem clear
                                exit    \ return - Fsem clr

	

%GetLeftJoystick   $joystick_status_addr	imm     \ push joystick status reg address
					        io@     \ get joystick status
                    0x0003	                imm     \ push bit mask to get left paddle signals
                                                and     \ and with bit mask
                                                exit    \ leave result on stack


%GetRightJoystick   $joystick_status_addr	imm     \ push joystick status reg address
					        io@	\ get joystick status
                    0x000c	                imm     \ push bit mask to get right paddle signals
                                                and     \ and with bit mask
                                                exit    \ leave result on stack
                                    
                                    
%MoveLeftPaddleUp   $dy_paddle              imm     \ push joystick movement vector
                                            +       \ add to left paddle postion
                                            dup     \
                    $p_left_loc_addr        imm     \ left paddle position
                                            io!
                                            exit    \
                                            
                                            
%MoveLeftPaddleDown $dy_paddle              imm     \ push joystick movement vector
                                            invert  \ invert for subtraction
                                            +       \ add to left paddle postion
                                            dup     \
                    $p_left_loc_addr        imm     \ left paddle position
                                            io!     \
                                            exit    \
                    
%MoveRightPaddleUp   $dy_paddle             imm     \ push joystick movement vector
                                            +       \ add to right paddle postion
                                            dup     \
                    $p_right_loc_addr       imm     \ right paddle position
                                            io!
                                            exit    \


%MoveRightPaddleDown $dy_paddle             imm     \ push joystick movement vector
                                            invert  \ invert for subtraction
                                            +       \ add to right paddle postion
                                            dup     \
                    $p_right_loc_addr       imm     \ right paddle position
                                            io!     \
                                            exit    \
