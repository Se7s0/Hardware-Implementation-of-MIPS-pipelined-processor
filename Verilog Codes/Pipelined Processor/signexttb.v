//signext testbench

`timescale 1ps/1ps
//for adjusting of delay
//where it means {delay time unit/delay rounding}
//delay is adjusted by multiplying the delay time with the delay time unit 
//and rounding of the output to the nearest delay rounding 

module signexttb;

	//Inputs
	reg[16:0] imm;

	//Outputs for testbench
	wire[31:0] extdimm;
	

	//Instantiation of Unit Under Test
	signext uut (
		.imm(imm),

		//Outputs for testbench
		.extdimm(extdimm)
		   );

initial
begin
#10;
imm=3;


end

endmodule