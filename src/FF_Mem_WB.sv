
// FF entre Mememory y WriteBack

module FF_Mem_WB (
input logic        clk, reset, 
input logic        RegWriteM, 
input logic  [1:0] ResultSrcM, 
output logic       RegWriteW, 
output logic [1:0] ResultSrcW);

    always_ff @( posedge clk, posedge reset ) begin
        if (reset) begin
            RegWriteW <= 0;
            ResultSrcW <= 0;           
        end

        else begin
            RegWriteW <= RegWriteM;
            ResultSrcW <= ResultSrcM;
        end
    end
endmodule