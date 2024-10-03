//sign extend module, this takes the leftmost sign
//of the input and extends it to 32 bits

module signext( input  [15:0] imm,    //16-bit input
                output [31:0] extdimm //32-bit extended output
                );

    assign extdimm = { {16{imm[15]}} , imm };
                //taking of the left most bit and extending
endmodule
