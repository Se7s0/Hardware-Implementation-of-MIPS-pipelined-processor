//Data memory module

`timescale 1ps/1ps
//for adjusting of delay
//where it means {delay time unit/delay rounding}
//delay is adjusted by multiplying the delay time with the delay time unit 
//and rounding of the output to the nearest delay rounding 


module dmem(clk,MemWrite,ALUResult,din,dout);

//we here have defined the data memory to be a 2D array
//which we can address each instruction by its row number 
//where its row number will be the address of the memory unit 
//the address is the cakculated ALU result



parameter depth =128;
parameter width = 32; 

input clk, MemWrite;
input [31:0] ALUResult;
input [width-1:0] din;            //data into the Dmem
output [width-1:0] dout;          //data out of the Dmem

reg [width-1:0] Dmem [depth-1:0]; //initialization of the 2D array
    
assign dout = Dmem[ALUResult];    // as there is no MemRead we will always 
                                  //read and hold the read value
    
always @ (posedge clk) begin      //MemRead permission for writing the memory
    #500; //delay time
	
    if (MemWrite) 		  //writing of the data input to the data memory
		Dmem[ALUResult] <= din; 
		 
end

endmodule
