//Multiplexers module

module mux(inp0,inp1,signal,selectedinp);

parameter n=32;

input [n-1:0] inp0;   //the 2 inputs that we will be selecting from 
input [n-1:0] inp1;
input signal;        //the control signal for determing the output signal
output [n-1:0] selectedinp;  //output

assign selectedinp = signal ? inp1 : inp0;  //if statement for determing the 
                                            //selected input based on signal

endmodule

