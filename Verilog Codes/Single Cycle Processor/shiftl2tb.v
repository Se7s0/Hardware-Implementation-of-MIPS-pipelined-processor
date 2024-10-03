//shift testbench

`timescale 1ps/1ps
//for adjusting of delay
//where it means {delay time unit/delay rounding}
//delay is adjusted by multiplying the delay time with the delay time unit 
//and rounding of the output to the nearest delay rounding 

module shiftl2bench;

	//Inputs
	reg[31:0] extdimm;

	//Outputs for testbench
	wire[31:0] extdimmt4;
	

	//Instantiation of Unit Under Test
	shiftl2 uut (
		.extdimm(extdimm),

		//Outputs for testbench
		.extdimmt4(extdimmt4)
		   );

initial
begin
#10;
extdimm=3;
end
endmodule
