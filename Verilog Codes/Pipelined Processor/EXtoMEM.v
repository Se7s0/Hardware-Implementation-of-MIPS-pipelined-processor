module EXtoMEM(input clk,
            input reset,
            input [31:0] ALUResult_Ex,
            output reg [31:0] ALUResult_M,
            input [31:0] fdwmux2out,
            output reg [31:0] din_M,
            input [4:0] RdOrRt_Ex,
            output reg [4:0] RdOrRt_M,
            input RegWrite_Ex,
            output reg RegWrite_M,
            input MemtoReg_Ex, 
            output reg MemtoReg_M,
            input MemWrite_Ex, 
            output reg MemWrite_M);
  
  always@(posedge clk)
    begin
      if (reset)  begin
        ALUResult_M <= 0;
        din_M <= 0;
        RdOrRt_M <= 0;
        RegWrite_M <= 0;
        MemtoReg_M <= 0;
        MemWrite_M <= 0;
        end

      else begin
        ALUResult_M <= ALUResult_Ex;
        din_M <= fdwmux2out;
        RdOrRt_M  <= RdOrRt_Ex;
        RegWrite_M  <= RegWrite_Ex;
        MemtoReg_M  <= MemtoReg_Ex;
        MemWrite_M  <= MemWrite_Ex;
      end
    end
  
endmodule