//shift left module which multiplies
//the input value by 4

module shiftl2(input [31:0] extdimm, //input value 
            output [31:0] extdimmt4);//output value times 4 
            
assign extdimmt4 = extdimm << 2; //using the shift operator to shift

endmodule
