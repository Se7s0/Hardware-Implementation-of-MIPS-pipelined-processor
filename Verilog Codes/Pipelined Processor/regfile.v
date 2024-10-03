//Register file module

`timescale 1ps/1ps
//for adjusting of delay
//where it means {delay time unit/delay rounding}
//delay is adjusted by multiplying the delay time with the delay time unit 
//and rounding of the output to the nearest delay rounding 



module regfile (input clk,
                    input RegWrite, 
                    input reset,
                    input [4:0] rs, //address of rs
                    input [4:0] rt, //address of rt
                    input [4:0] RdOrRt, //address of rd or rt based on instruction type
                    input [31:0] WriteData, // data to be input to registers
                    output [31:0] rsdata, //output data of registers
                    output [31:0] rtdata); 
                    
//we here have defined the register file to be a 2D array
//which we can address each register by its row number 
//where its row number will be the address of each register
//the 2D array is 32 bits wide for the register file max size



reg [31:0] register [31:0]; //2D array initialization

assign rsdata = register[rs]; //assigning of the registers data to an output
assign rtdata = register[rt]; //in case we need the register contents

//No delay time as we have no RegrRead signal


integer i;

initial begin //initialization of all registers to be default by zero
    for (i=1; i<32; i=i+1) begin
         register[i] <= 32'd0;
        end
    end
    
always @(posedge clk) //clock and resit always block

begin
    register[0]=0;
    if(reset) for(i = 0; i < 32; i = i + 1) register[i] = 32'd0; // if reset=1
                                                                 //reset the whole reg file

    else if (RegWrite) //permission to write the register 
        if(RdOrRt != 0) register[RdOrRt]= WriteData; //if you are wondering what happens of both reset and regwrite =1,
                                                     //and thats the case for the first run incase we encounter an immediate instruction
                                                     //that is explained in the next slide and how these 2 if statements merge
   // #200; //Delay time
end

endmodule
