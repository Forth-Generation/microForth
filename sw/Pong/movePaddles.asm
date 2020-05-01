$p_left_loc_addr  0x1F2             \ left paddle y location address
$p_right_loc_addr 0x1F3             \ right paddle y location address


$joystick_status_addr   0x0040 		\ joystick status address
$left_paddle_up         0x0001      \ left paddle up indicator
$left_paddle_down       0x0002      \ left paddle down indicator
$right_paddle_up        0x0004      \ right paddle down indicator
$right_paddle_down        0x0008      \ right paddle up indicator
	
$dy_paddle	 0x0003	        	    \ paddle movement velocity
	
$Fsem_addr 0x033                    \ Frame sync semaphore address
$Fsem_set  0x0001                   \ Frame sync semaphore set value
$Fsem_clr  0x0000                   \ Frame sync semaphore clr value


                
                                
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
		
%SkipLeftDown   		    swap    \ start operations on right paddle
		%GetRightJoystick   scall
		
		$right_paddle_up    imm     \ push right paddle up indicator
				    =	    \ compare
		%SkipRightUp	    0branch \ skip
		%MoveRightPaddleUp  scall   \
		
%SkipRightUp    %GetRightJoystick   scall   \ get right stick status
		$right_paddle_down  imm     \ push right paddle up indicator
			            =       \ compare
		%SkipRightDown      0branch \ skip
		%MoveRightPaddleDown scall  \

%SkipRightDown			    swap    \ swap left joystick addr back to top of stack
		$Fsem_set           imm     \ push Fsem set value
                $Fsem_addr          imm     \ push Fsem address
                                    io!     \ write/set Fsem
                %Loop               ubranch    \



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
