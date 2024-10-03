module IFtoID(input clk, 
             input reset,
             input stall,   
             input [31:0]PCplus4_IF, 
             output reg [31:0]PCplus4_ID, 
             input [31:0]Instr_IF,
             output reg [31:0]Instr_ID);
  
  always@(posedge clk)
    begin
    
      if (reset) begin //Resetting the whole system
        PCplus4_ID <= 0;
        Instr_ID <= 0;
      end

      else if(stall) begin        //If we encounter a branch or LW satll, 
        PCplus4_ID <= PCplus4_ID; //we need everything to stay the same
        Instr_ID <= Instr_ID;
        end

      else begin
	PCplus4_ID <= PCplus4_IF;       //if no stall or resets we need the registers to
        Instr_ID <= Instr_IF;     //continue normally
      end

    end
  
endmodule

