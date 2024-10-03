//ALU module for the instructions we implemented in our system
//The ALU control bits are based on the general table in the text book
//The table will be found somewhere around this page

`timescale 1ps/1ps 
//for adjusting of delay
//where it means {delay time unit/delay rounding}
//delay is adjusted by multiplying the delay time with the delay time unit 
//and rounding of the output to the nearest delay rounding 

module alu( input [31:0] rsdata,          //Inputs are the register file values (rs and/or rt)
            input [31:0] rtdataOrextimm,  //or the immediate instruction incase of I-type 
            input [3:0] ALUctrl,          //ALU control from the control unit to determine the fucntion to be done 
            output reg [31:0] ALUResult,  //result of ALU, either address for data memory or data result
            output reg zero);             //the zero for branching determination


always @ (*) begin
   // #100; //delay time remove for a proper alutestbench result
    case (ALUctrl)
        4'b0000: ALUResult = rsdata & rtdataOrextimm;                             // AND 0
        4'b0001: ALUResult = rsdata | rtdataOrextimm;                             // OR  1
        4'b0010: ALUResult = rsdata + rtdataOrextimm;                             // ADD 2
        4'b0110: ALUResult = rsdata - rtdataOrextimm;                             // SUB 6
        4'b0111: ALUResult = $signed(rsdata) < $signed(rtdataOrextimm) ? 1 : 0;   // SLT 7
    endcase
         zero = (ALUResult==8'b0);               //assigning of branching zero,
                                                 //if ALUresult which is the sub function (diffrence)
                                                 //is zero then they are equal so zero = 1, otherwise 0.
         
         end                                                             
endmodule




