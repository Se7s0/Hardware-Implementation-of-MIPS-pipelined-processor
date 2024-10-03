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
`include "ForwardingUnit.v"
`include "hazarddetect.v"
`include "IFtoID.v"
`include "IDtoEx.v"
`include "ExtoMEM.v"
`include "MEMtoWB.v"

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

wire [31:0] PCNext, PCplus4,PCplus4_IF,PCplus4_ID, PCbeforeBranch, PCBranch, ALUResult,ALUResult_Ex,ALUResult_M,ALUResult_WB,dout,dout_M,dout_WB,rtdata,
			rtdata_ID,rtdata_Ex,din_M,PC,PC_IF,Instr,Instr_IF,Instr_ID,Instr_Ex,
	        extendedimm,extendedimm_Ex,extendedimm_ID, extendedimmafter, WriteData, rsdata,rsdata_ID,rsdata_Ex,
			fwdmux2OrExtimm,fwdmux1out,fwdmux2out,equalone,equaltwo;
wire [4:0] RdOrRt,RdOrRt_Ex,RdOrRt_M,RdOrRt_WB;
wire [3:0] ALUControl,ALUControl_Ex,ALUControl_ID;
wire RegDst,RegDst_Ex,RegDst_ID,RegWrite,RegWrite_EX,RegWrite_ID,RegWrite_M,RegWrite_WB,ALUSrc,ALUSrc_Ex,
	 ALUSrc_ID,Jump,MemtoReg,MemtoReg_Ex,MemtoReg_ID,MemtoReg_M,MemtoReg_WB,PCSrc,MemWrite,MemWrite_Ex,MemWrite_ID,
	 MemWrite_M,ZeroFlag,Branch_ID,Branchdet,Equal_ID;
wire [1:0] ForwardAE,ForwardBE;
wire Flush_Ex, Stall_IF, Stall_ID; 
wire ForwardAD, ForwardBD;
  
//Outputs for testbench
assign WriteDataa=WriteData; 
assign RdOrRtt=RdOrRt_M;
assign dinn=din_M;
assign doutt=dout_WB;
assign PCC=PC_IF;

// Fetch stage

PC PCmod(clk,reset,Stall_IF, PC_IF,PCNext); //calling of our PC module to determine our first PC which will be zero
adder pcadd4(PC_IF, 32'd4 ,PCplus4_IF);//first step is doing PC=PC+4
mux #(32) branchmux(PCplus4_IF , PCbeforeBranch, Branchdet, PCBranch);//what we did was (PC+4)+(4*A), which gives us the branching address
mux #(32) jumpmux(PCBranch, {PCplus4_ID[31:28],Instr_ID[25:0],2'b00 }, Jump,PCNext);
//for jumping we take concatinationn of the first 4 bits of PC along with the 25 jump bits and multiply it by 4
//to determing the jump address (4*jump)
imem imem(PC_IF,Instr_IF);
//setting of instruction memory to input PC and give us corresponding instruction


//IF ID registers
IFtoID IFtoID(clk,reset|Branchdet|Jump,Stall_ID,PCplus4_IF,PCplus4_ID,Instr_IF,Instr_ID);
//branchdet is with reset signal in order to reset the current instruction that is
//after the branch incase the branch is executed

//Decode stage
signext immextention(Instr_ID[15:0],extendedimm_ID);
shiftl2 shiftl2(extendedimm_ID,extendedimmafter);//next is extending the branch-imm value to 32 for use in adder, this is the 'A' value
regfile regfile(clk,RegWrite_WB, reset, Instr_ID[25:21], Instr_ID[20:16], RdOrRt_WB, WriteData, rsdata_ID,rtdata_ID); 

// for add and beq dependencies, the add instruction will be in the Memory stage and the branch needs in the Decode stage
//so we prepare a forwarding mux to do this dependency and execute the branch as it is not in the decode stage
mux #(32) equalmux1(rsdata_ID,ALUResult_M,ForwardAD,equalone);  
mux #(32) equalmux2(rtdata_ID,ALUResult_M,ForwardBD,equaltwo);

//comparator for the branch instruction instead of using the ALU separately 
//Branchdet is for determining if we should branch or not
assign Equal_ID = (equalone==equaltwo);
assign Branchdet = (Equal_ID & Branch_ID);

adder pcaddsigned(extendedimmafter,PCplus4_ID,PCbeforeBranch);//determining the branching address of there is one 
ctrlmain ctrlmain(Instr_ID[31:26], Instr_ID[5:0],ALUControl_ID,MemtoReg_ID,Jump,MemWrite_ID,
                  RegDst_ID, ALUSrc_ID, RegWrite_ID,Branch_ID);
//control which we input OP and Function and we get the corrsponding control signals

//flush of memtoreg signal in case of stall
mux #(32) flushmux(MemtoReg_ID,32'b0,Stall_IF,MemtoReg_ID_flush);

//ID Ex reg
IDtoEX IDtoEx(clk, reset , rsdata_ID, rsdata_Ex,rtdata_ID,rtdata_Ex, extendedimm_ID,extendedimm_Ex, Instr_ID,Instr_Ex, RegWrite_ID, RegWrite_Ex, 
                            MemtoReg_ID_flush, MemtoReg_Ex, MemWrite_ID,MemWrite_Ex, ALUControl_ID, ALUControl_Ex, ALUSrc_ID, ALUSrc_Ex, RegDst_ID, RegDst_Ex);

//ex stage
mux3 forwardmuxA (rsdata_Ex, WriteData, ALUResult_M, ForwardAE, fwdmux1out);
mux3 forwardmuxB (rtdata_Ex, WriteData, ALUResult_M, ForwardBE, fwdmux2out);
alu alu(fwdmux1out, fwdmux2OrExtimm, ALUControl_Ex, ALUResult_Ex, ZeroFlag);
mux #(32) ALUSrcmux(fwdmux2out,extendedimm_Ex, ALUSrc_Ex, fwdmux2OrExtimm);
mux #(5) RegDstmux(Instr_Ex[20:16],Instr_Ex[15:11],RegDst_Ex, RdOrRt_Ex);
//setting up of the ALU inputs along with its output zero branching signal
//extension of immediate value to be used by register
//setting up the MUX to determing input value if we have R or I type instruction


//ex_m reg
EXtoMEM EXtoMEM(clk, reset, ALUResult_Ex, ALUResult_M, fwdmux2out, din_M, RdOrRt_Ex, RdOrRt_M,
                           RegWrite_Ex, RegWrite_M, MemtoReg_Ex, MemtoReg_M, MemWrite_Ex, MemWrite_M );

//memory stage
dmem dmem(clk,MemWrite_M,ALUResult_M, din_M, dout_M);
//pretty simple assigning of out datamemory element with rtdata as out input 
//for store word immediate instructions and dout as output for load word
//immediate instructions


//forwarding and hazard
ForwardingUnit ForwardingUnit( Instr_Ex [25:21], Instr_Ex [20:16], Instr_ID [25:21], Instr_ID [20:16], RdOrRt_M, RdOrRt_WB, RegWrite_M, RegWrite_WB, ForwardAE, ForwardBE, ForwardAD, ForwardBD);
hazarddetect hazarddetect(Instr_Ex [20:16], Instr_ID [25:21], Instr_ID [20:16], RdOrRt_M,RdOrRt_Ex,MemtoReg_ID_flush,MemtoReg_M,RegWrite_Ex,Branch_ID,Jump,
Stall_IF,Stall_ID,Flush_Ex );

//mem_WB
MEMtoWB MEMtoWB(clk,reset, dout_M, dout_WB, ALUResult_M, ALUResult_WB, RdOrRt_M, RdOrRt_WB,
                             RegWrite_M, RegWrite_WB, MemtoReg_M, MemtoReg_WB);

//Wb stage
mux #(32) MemtoRegmux(ALUResult_WB, dout_WB, MemtoReg_WB,WriteData);

endmodule

