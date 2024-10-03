//the main control unit along with the ALU control implemented in it,
//check the further shortcut notes for more understanding

module ctrlmain(input [5:0] Opcode,       //we will inoput the opcode, function and
                input [5:0] Func,         //and the zero for brnaching to determine control signals
              
	            output reg  [3:0] ALUctrl,//all outputs are the control signals of 
                output reg MemtoReg,      //the whole system
	            output reg  Jump,
                output reg  MemWrite,
	            output reg  RegDst,
                output reg  ALUSrc,
                output reg  RegWrite,
                output reg Branch            
	        //output[6:0] tempp for ctrltestbench
               );
               
// we have inputs as the opcode, fuction and the zero branch element
//then the poutputs are the 7 control signals and the ALUcontrol

//the OP code and function values are based on the MIPS greensheet 
//ALUcontrol signal is explained in ALU

reg[6:0] temp; //for defining the control signal values later
               //internal register for branching and determining if we branch or not

always @(*) begin 

	
   case (Opcode) 
        6'b000000: begin                              // R-type 0
                    temp <= 7'b1100000;               //96      

                    case (Func)
                    6'b100000: ALUctrl <= 4'b0010;    // ADD 32 2
                    6'b100010: ALUctrl <= 4'b0110;    // SUB 34 6
                    6'b100100: ALUctrl <= 4'b0000;    // AND 36 0 
                    6'b100101: ALUctrl <= 4'b0001;    // OR  37 1
                    6'b101010: ALUctrl <= 4'b0111;    // SLT 42 7
                endcase
            end

        6'b100011: begin                              // LW 35
                        temp <= 7'b1010010;           //82   
                        ALUctrl <= 4'b0010;
                    end

        6'b101011: begin                              // SW 43
                         temp <= 7'b0010100;          //20  
                         ALUctrl <= 4'b0010;
                    end  

        6'b000100: begin                              // BEQ 4
                         temp <= 7'b0001000;          //8 
                        ALUctrl <= 4'b0110; 
                    end      

        6'b001000: begin                              // ADDI 8
                        temp <= 7'b1010000;           //80
                        ALUctrl <= 4'b0010; 
                    end  

        6'b000010: begin                              // JUMP 2
                        temp <= 7'b0000001;           //1
                        ALUctrl <= 4'b0000; 
                    end     
	default:   temp <= 7'bxxxxxxx;                    // NOP
    endcase
   
    
{RegWrite,RegDst,ALUSrc,Branch,MemWrite,MemtoReg,Jump} = temp; //setting the control signals
        

end 

//assign tempp=temp; for ctrltestbench

endmodule


