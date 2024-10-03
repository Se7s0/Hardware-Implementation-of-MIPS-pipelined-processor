//alu testbench

`timescale 1ps/1ps
//for adjusting of delay
//where it means {delay time unit/delay rounding}
//delay is adjusted by multiplying the delay time with the delay time unit 
//and rounding of the output to the nearest delay rounding 

module alutestbench;

	//Inputs
	reg[31:0] rsdata;
        reg[31:0] rtdataOrextimm;
	reg[3:0] ALUctrl;

	//Outputs for testbench
	wire[31:0] ALUResult;
	wire zero;

	

	//Instantiation of Unit Under Test
	alu uut (
		.rsdata(rsdata),
		.rtdataOrextimm(rtdataOrextimm),
		.ALUctrl(ALUctrl),
		
		//Outputs for testbench
		.ALUResult(ALUResult),
		.zero(zero)
		);

initial
begin

#200; //AND
rsdata=1;
rtdataOrextimm=0;
ALUctrl=0;

#200; //OR
rsdata=1;
rtdataOrextimm=0;
ALUctrl=1;

#200; //ADD
rsdata=5;
rtdataOrextimm=6;
ALUctrl=2;

#200; //SUB
rsdata=5;
rtdataOrextimm=5;
ALUctrl=6;

#200; //SLT
rsdata=5;
rtdataOrextimm=6;
ALUctrl=7;


end

endmodule

