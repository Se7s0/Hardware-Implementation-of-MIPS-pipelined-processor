module hazarddetect(    input [4:0] Rt_EX,            
                        input [4:0] Rs_D,
                        input [4:0] Rt_D,
                        input [4:0] RdOrRt_M,
                        input [4:0] RdOrRt_Ex,
                        input MemtoReg_ID,
                        input MemtoReg_M,
                        input RegWrite_EX,
                        input Branch_ID, 
                        input Jump_ID,
                        output reg stall_IF_ID,
                        output reg stall_ID_EX,
                        output reg flush_EX_Mem);
reg lwstall, branchstall;
always @(*) begin
  //stall after the lw instruction 
  lwstall= ((Rs_D==Rt_EX) || (Rt_D==Rt_EX)) && MemtoReg_ID;
  

  //stall after the branch instruction
  branchstall =Branch_ID &
            (RegWrite_EX ||
            (RdOrRt_Ex == Rs_D | RdOrRt_Ex == Rt_D) |
             MemtoReg_M ||
            (RdOrRt_M == Rs_D | RdOrRt_M == Rt_D));

    stall_ID_EX = lwstall | branchstall | Jump_ID;
    stall_IF_ID = lwstall | branchstall | Jump_ID;
    flush_EX_Mem = lwstall;
		
    end

endmodule 
