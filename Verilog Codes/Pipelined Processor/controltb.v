//control testbench

`timescale 1ps/1ps
//for adjusting of delay
//where it means {delay time unit/delay rounding}
//delay is adjusted by multiplying the delay time with the delay time unit 
//and rounding of the output to the nearest delay rounding 

module controltestbench;

		//Inputs
		reg [5:0] Opcode; 
                reg [5:0] Func; 
                reg Zero;
	        

		//Outputs for testbench
		
                wire PCSrc;
		wire[3:0] ALUctrl;
		wire[6:0] tempp;

	

	//Instantiation of Unit Under Test
	ctrlmain uut (
		.Opcode(Opcode),
		.Func(Func),
		.Zero(Zero),
		
		//Outputs for testbench
		.PCSrc(PCSrc),
		.tempp(tempp),
		.ALUctrl(ALUctrl)
		);

initial
begin

#200; //ADD
Opcode=0;
Func=16;
Zero=0;

#200; //SUB
Opcode=0;
Func=18;
Zero=0;

#200; //AND
Opcode=0;
Func=20;
Zero=0;

#200; //OR
Opcode=0;
Func=21;
Zero=0;

#200; //SLT
Opcode=0;
Func=42;
Zero=0;

#200; //LW
Opcode=35;
Func=0;
Zero=0;

#200; //SW
Opcode=43;
Func=0;
Zero=0;

#200; //BEQ
Opcode=4;
Func=0;
Zero=1;

#200; //ADDI
Opcode=8;
Func=0;
Zero=0;

#200; //JUMP
Opcode=2;
Func=0;
Zero=0;



end

endmodule

