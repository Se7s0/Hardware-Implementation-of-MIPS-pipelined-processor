//test bench module for testing of the main intructions we have 
//and monitoring of the hand analysis elements
//this testbench tests everything that needs a clock, which are
//Instruction memory,Data memory, PC, and instruction memory together
//we input or use the instrictions in our memfile.txt

`timescale 1ps/1ps
//for adjusting of delay
//where it means {delay time unit/delay rounding}
//delay is adjusted by multiplying the delay time with the delay time unit 
//and rounding of the output to the nearest delay rounding 

module testbench;

	//Inputs
	reg clk;
        reg reset;

	//Outputs for testbench
	wire[31:0] PCC;
	wire[31:0] WriteDataa;
	wire[4:0]RdOrRtt;
	wire[31:0] dinn;
	wire[31:0] doutt;
	

	//Instantiation of Unit Under Test
	top uut (
		.clk(clk),
		.reset(reset),
		
		//Outputs for testbench
		.PCC(PCC),     //for instruction memory and PC
		.WriteDataa(WriteDataa), //for register file test
		.RdOrRtt(RdOrRtt), //for register file test
		.dinn(dinn), //for register file and data memory test
		.doutt(doutt) //for register file and data memory test
	);

    //our clock period is 1300ps based on the slowest instruction 
    //calculated in the next slide

    always #650 clk=!clk; //adjustment of a general clock with half cycle=clock cycle/2
			  //reset=1 for the first loop
	initial begin
      
        $dumpfile("dump.vcd"); $dumpvars;
      
	clk=0;
	reset=1;
	#1300; //reset=1 for the first clock cycle

      repeat(100) begin 
	reset=0;//reset=0 for the rest cycles 
	#1300;
      end
        $finish; //we will have 11 clock cycles assuming we have 
		 //max of 11 instructions for our program to terminate
		 //the instruction set I made has endless number of instructions
		 //so I used finish to terminate my program
		 //if we need more clock cycles set the 'repeat' value above higher 
  	end

endmodule