		noop			
	0x7FFF  imm  		\ Push 0x7FFF
		drop		\ Pop stack

	        noop
	        noop

	1       imm		\ Push 1
	2	imm		\ Push 2
	3       imm		\ Push 3
	4	imm		\ Push 4
	5	imm		\ Push 5
		drop		\ Pop
		drop		\ Pop
		drop		\ Pop
		drop		\ Pop
		drop		\ Pop

		noop		
		noop		   
		noop		

	1	imm		\ Push 5
		noop
		drop		\ Pop

	0	ubranch		\ Start Over
