//instruction memory module

module imem(PC,Inst);

//we here have defined the instruction memory to be a 2D array
//which we can address each instruction by its row number 
//where its row number will be the address of each instruction
//the address is the calculated ALU result



parameter depth =256;
parameter width = 32; 


input [31:0] PC;
output [width-1:0] Inst;

reg [width-1:0] Imem[depth-1:0];     //initialization of 2D array
    
initial
    $readmemh("memfile.txt", Imem);  //reads the instruction as HEX from
      			             //from a textfile and inputs the hex as binary values
				     //inside the Imem row by row with a max of 32 bits defined up
   
  assign Inst= Imem[PC/4];           //The PC is incremented by 4 while the instruction memory has
                                     //values starting from 1 so we revert by dividing PC by 4 to
                                     //address correctly



endmodule


