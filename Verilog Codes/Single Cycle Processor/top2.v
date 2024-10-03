//top module for wiring everything together

`include "adder.v"
`include "alu.v"
`include "pc.v"
`include "mux.v"
`include "regfile.v"
`include "signext.v"
`include "shiftl2.v"
`include "dmem.v"
`include "imem.v"
`include "ctrlmain.v"

//including of all modules to define them later for wiring in 
//this top module

//check the design procedure for wiring the components toghether

module top(input clk,
           input reset,
		//Outputs for testbench
		output [31:0] PCC,
		output[31:0] WriteDataa,  
		output[4:0] RdOrRtt,
		output [31:0] doutt,
		output[31:0] dinn
		);

//all components are wired as we have no geneal input or output
//as all components are output from one place and input to another
//simultneously across the loop everytime

wire [31:0] PCNext, PCplus4, PCbeforeBranch, PCBranch, ALUResult,dout,rtdata,PC,Instr,
	        extendedimm, extendedimmafter, WriteData, rsdata, rtdataOrextimm;
wire [4:0] RdOrRt;
wire[3:0] ALUControl;
wire RegDst,RegWrite,ALUSrc,Jump,MemtoReg,PCSrc,MemWrite,ZeroFlag;
  
//Outputs for testbench
assign WriteDataa=WriteData; 
assign RdOrRtt=RdOrRt;
assign dinn=rtdata;
assign doutt=dout;
assign PCC=PC;

// PC 

PC PCmod(clk,reset, PC,PCNext); //calling of our PC module to determing our first PC which will be zero
adder pcadd4(PC, 32'd4 ,PCplus4);//first step is doing PC=PC+4
shiftl2 shiftl2(extendedimm,extendedimmafter);//next is extending the branch-imm value to 32 for use in adder, this is the 'A' value
adder pcaddsigned(extendedimmafter,PCplus4,PCbeforeBranch);//determining the branching address of there is one 
mux #(32) branchmux(PCplus4 , PCbeforeBranch, PCSrc, PCBranch);//what we did was (PC+4)+(4*A), which gives us the branching address
mux #(32) jumpmux(PCBranch, {PCplus4[31:28],Instr[25:0],2'b00 }, Jump,PCNext);
//for jumping we take concatinationn of the first 4 bits of PC along with the 25 jump bits and multiply it by 4
//to determing the jump address (4*jump)


// Register File 

regfile regfile(clk,RegWrite, reset, Instr[25:21], Instr[20:16], RdOrRt, WriteData, rsdata,rtdata); 
mux #(5) RegDstmux(Instr[20:16],Instr[15:11],RegDst, RdOrRt);
mux #(32) MemtoRegmux(ALUResult, dout, MemtoReg,WriteData);
//setting the register file inputs along with its control signals
//setting up of the MUX for determing of I or R type instruction
//setting up of the mux for determing which data to be written into register
//if R or I type instruction


// ALU

alu alu(rsdata, rtdataOrextimm, ALUControl, ALUResult, ZeroFlag);
signext immextention(Instr[15:0],extendedimm);
mux #(32) ALUSrcmux(rtdata,extendedimm, ALUSrc, rtdataOrextimm);
//setting up of the ALU inputs along with its output zero branching signal
//extension of immediate value to be used by register
//setting up the MUX to determing input value if we have R or I type instruction


//Data memory

dmem dmem(clk,MemWrite,ALUResult, rtdata, dout);
//pretty simple assigning of out datamemory element with rtdata as out input 
//for store word immediate instructions and dout as output for load word
//immediate instructions


//Instruction memory

imem imem(PC,Instr);
//setting of instruction memory to input PC and give us corresponding instruction


//Control

ctrlmain ctrlmain(Instr[31:26], Instr[5:0] ,ZeroFlag,ALUControl,MemtoReg,Jump,MemWrite,
                        RegDst, ALUSrc, RegWrite,PCSrc);
//control which we input OP and Fucntion and we get the corrsponding control signals

endmodule

