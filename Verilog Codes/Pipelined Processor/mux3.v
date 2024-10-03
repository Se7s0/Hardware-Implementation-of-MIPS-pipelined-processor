module mux3 (inp0,inp1,inp2,signal,selectedinp);

parameter n=32;

input [n-1:0] inp0,inp1,inp2;
input [1:0] signal;
output reg [n-1:0] selectedinp;

always @* begin

    case(signal)
        2'b00: selectedinp<=inp0;
        2'b01: selectedinp<=inp1;
        2'b10: selectedinp<=inp2;
    endcase
    
end

endmodule