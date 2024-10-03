module MEMtoWB(input clk,
            input reset,
            input [31:0] dout_M,
            output reg [31:0] dout_WB,
            input [31:0] ALUResult_M, 
            output reg [31:0]ALUResult_WB,
            input [4:0]RdOrRt_M,
            output reg [4:0]RdOrRt_WB,
            input RegWrite_M,
            output reg RegWrite_WB,
            input MemtoReg_M, 
            output reg MemtoReg_WB);
  
  always@(posedge clk )
    begin
      if (reset) begin
	    	dout_WB <= 0;
        ALUResult_WB <= 0;
        RdOrRt_WB <= 0;
        RegWrite_WB <= 0;
        MemtoReg_WB <= 0;
      end
      else begin
		    dout_WB <= dout_M;
        ALUResult_WB <= ALUResult_M;
        RdOrRt_WB <= RdOrRt_M;
        RegWrite_WB  <= RegWrite_M;
        MemtoReg_WB  <= MemtoReg_M;

      end
    end
endmodule

