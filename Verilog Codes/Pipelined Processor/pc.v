//program counter module 

`timescale 1ps/1ps
//for adjusting of delay
//where it means {delay time unit/delay rounding}
//delay is adjusted by multiplying the delay time with the delay time unit 
//and rounding of the output to the nearest delay rounding 



module PC (clk, rst, Stall_IF ,PC,PCNext);

input clk,rst,Stall_IF ;
input [31:0] PCNext;   //PCnext is the next value of PC
output reg [31:0] PC;  //PC is the current value of PC

always @ (posedge clk) //clock and reset always block 
begin
    if(rst) PC<=0;              //on initial run where reset=1, we will set PC to zero,
    else if(Stall_IF) PC<=PC;
    else PC<=PCNext;            //otherwise when clock signal is input and reset=0, 
			              //we will set the PC
                                //to the next value

#500; //delay time of instruction memory is included here as PC is directly 
      //related to instruction memory

end
    
endmodule

