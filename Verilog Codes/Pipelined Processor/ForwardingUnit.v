module ForwardingUnit(  input [4:0] Rs_EX,            
                      	input [4:0] Rt_EX,
                        input [4:0] Rs_ID,            
                      	input [4:0] Rt_ID,            
                      	input [4:0] RdOrRt_M,       
                      	input [4:0] RdOrRt_WB,      
                        input RegWrite_M,       
                        input RegWrite_WB,      
                        output reg[1:0] ForwardAE,  
                        output reg[1:0] ForwardBE,
                        output reg ForwardAD,  
                        output reg ForwardBD );

//The forwarding Unit strategy of detecting the depencies is taken from the refrence and
//has been directly implemented in here with respect to the same signals that goes to the multiplexers
//Forward A is the first MUX and forward B is the second MUX
//Forward AE is Forward A around the EXEcute
//Forward AD is forward A around the Decode
always @(*)
    begin
        // Forward around EX hazards
        if (RegWrite_M
            && (RdOrRt_M != 0)
            && (RdOrRt_M == Rs_EX))
            ForwardAE = 2'b10;
        // Forward around MEM hazards
        else if (RegWrite_WB
            && (RdOrRt_WB != 0)
            && (RdOrRt_WB == Rs_EX))
            ForwardAE = 2'b01;
        // No hazards, use the value from ID/EX
        else
            ForwardAE = 2'b00;

        
         // Forward around EX hazards
        if (RegWrite_M
            && (RdOrRt_M != 0)
            && (RdOrRt_M == Rt_EX))
            ForwardBE = 2'b10;
        // Forward around MEM hazards
        else if (RegWrite_WB
            && (RdOrRt_WB != 0)
            && (RdOrRt_WB == Rt_EX))
            ForwardBE = 2'b01;
        // No hazards, use the value from ID/EX
        else
            ForwardBE = 2'b00;


        //Forwarding for the branch in the decode stage in case we encounter an R-type instruction before 
        //the BEQ 
        ForwardAD = (RdOrRt_M !=0) && (Rs_ID == RdOrRt_M) && RegWrite_M;
        ForwardBD = (RdOrRt_M !=0) && (Rt_ID == RdOrRt_M) && RegWrite_M;

            
    end

endmodule 