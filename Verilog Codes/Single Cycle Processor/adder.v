//adder module for doing the branch and PC incrementation for the system

module adder ( a, b, y);

input [31:0] a,b;  //a and b are the input to be added
output [31:0] y;   //Y is the result

assign y=a+b;      //assigning of addition

endmodule

