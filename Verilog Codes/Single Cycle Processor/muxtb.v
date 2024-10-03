//mux testbench

`timescale 1ps/1ps
//for adjusting of delay
//where it means {delay time unit/delay rounding}
//delay is adjusted by multiplying the delay time with the delay time unit 
//and rounding of the output to the nearest delay rounding 

module muxtestbench;

	//Inputs
	reg[31:0] inp0;
        reg[31:0] inp1;
	reg signal;

	//Outputs for testbench
	wire[31:0] selectedinp;
	

	//Instantiation of Unit Under Test
	mux uut (
		.inp0(inp0),
		.inp1(inp1),
		.signal(signal),

		//Outputs for testbench
		.selectedinp(selectedinp)
		   );

initial
begin
#10;
inp0=3;
inp1=2;
signal=0;

#10;
inp0=3;
inp1=2;
signal=1;

end

endmodule
