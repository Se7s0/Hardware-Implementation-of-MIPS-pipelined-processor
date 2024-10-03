//Multiplexers module

module mux(inp0,inp1,signal,selectedinp);

parameter n=32;

input [31:0] inp0;   //the 2 inputs that we will be selecting from 
input [31:0] inp1;
input signal;        //the control signal for determing the output signal
output [31:0] selectedinp;  //output

assign selectedinp = signal ? inp1 : inp0;  //if statement for determing the 
                                            //selected input based on signal

endmodule

