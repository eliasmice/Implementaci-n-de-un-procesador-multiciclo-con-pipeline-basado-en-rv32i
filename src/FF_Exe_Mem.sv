
// FF entre Execution y Memory 

module FF_Exe_Mem (
input logic        clk, reset,
input logic        RegWriteE, MemWriteE,
input logic  [1:0] ResultSrcE,  
output logic       RegWriteM, MemWriteM,
output logic [1:0] ResultSrcM);

    always_ff @( posedge clk, posedge reset ) begin
        if (reset) begin
            RegWriteM <= 0;
            MemWriteM <= 0;
            ResultSrcM <= 0;
        end
        else begin
            RegWriteM <= RegWriteE;
            MemWriteM <= MemWriteE;
            ResultSrcM <= ResultSrcE; 
        end      
    end
endmodule