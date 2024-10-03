//adder testbench

`timescale 1ps/1ps
//for adjusting of delay
//where it means {delay time unit/delay rounding}
//delay is adjusted by multiplying the delay time with the delay time unit 
//and rounding of the output to the nearest delay rounding 

module addertestbench;

	//Inputs
	reg[31:0] a;
        reg[31:0] b;

	//Outputs for testbench
	wire[31:0] y;
	

	//Instantiation of Unit Under Test
	adder uut (
		.a(a),
		.b(b),
		
		//Outputs for testbench
		.y(y)
		   );

initial
begin
#10;
a=5;
b=6;

#10
a=6;
b=9;
end

endmodule

