
// Unidad de control general

module ControlUnit(
input logic         clk, reset,
input logic  [6:0]  op,
input logic  [2:0]  funct3,
input logic         funct7b5,
input logic         ZeroE,
input logic         SignE,
input logic         FlushE,
output logic        ResultSrcE0,
output logic  [1:0] ResultSrcW,
output logic        MemWriteM,
output logic        PCJalSrcE, PCSrcE, ALUSrcAE, 
output logic  [1:0] ALUSrcBE,
output logic        RegWriteM, RegWriteW,
output logic  [2:0] ImmSrcD,
output logic  [3:0] ALUControlE
);

logic [1:0] ALUOpD;
logic [1:0] ResultSrcD, ResultSrcE, ResultSrcM;
logic [3:0] ALUControlD;
logic BranchD, BranchE, MemWriteD, MemWriteE, JumpD, JumpE;
logic ALUSrcAD, RegWriteD, RegWriteE;
logic [1:0] ALUSrcBD;
logic ZeroOpE, SignOpE, BranchOpE;
logic [2:0] funct3D,funct3E;
logic [6:0] opD, opE;

assign funct3D = funct3;
assign opD = op;

// Unidad de senales de control, de aquí salen a todo el procesador
ControlSig CS(
    .op       (op        ),
    
    .ResultSrc(ResultSrcD),
    .MemWrite (MemWriteD ),
    .Branch   (BranchD   ),
    .ALUSrcA  (ALUSrcAD  ),
    .ALUSrcB  (ALUSrcBD  ),
    .RegWrite (RegWriteD ),
    .Jump     (JumpD     ),
    .ImmSrc   (ImmSrcD   ),
    .ALUOp	  (ALUOpD    )
);

// Deco para la ALU, determina el tipo de operación
DeALU DecA( .opb5      (op[5]      ), 
            .funct3    (funct3     ), 
            .funct7b5  (funct7b5   ), 
            .ALUOp     (ALUOpD     ),
             
            .ALUControl(ALUControlD)
);

// FF entre el Decode y el Execution
FF_Dec_Exe FFDE(.clk(clk), .reset(reset), .clear(FlushE), 
    .RegWriteD(RegWriteD), .MemWriteD(MemWriteD), .JumpD(JumpD), .BranchD(BranchD), .ALUSrcAD(ALUSrcAD), .ALUSrcBD(ALUSrcBD), 
                           .ResultSrcD(ResultSrcD), .ALUControlD(ALUControlD), .funct3D(funct3D), .opD(opD),
                           
    .RegWriteE(RegWriteE), .MemWriteE(MemWriteE), .JumpE(JumpE), .BranchE(BranchE), .ALUSrcAE(ALUSrcAE), .ALUSrcBE(ALUSrcBE), 
                           .ResultSrcE(ResultSrcE), .ALUControlE(ALUControlE), .funct3E(funct3E), .opE(opE)
);

assign ResultSrcE0 = ResultSrcE[0];

// FF entre Execution y Memory 
FF_Exe_Mem FFEM(.clk(clk), .reset(reset), 
                .RegWriteE(RegWriteE), .MemWriteE(MemWriteE), .ResultSrcE(ResultSrcE),
                 
                .RegWriteM(RegWriteM), .MemWriteM(MemWriteM), .ResultSrcM(ResultSrcM)
);

// FF entre Memory y WriteBack
FF_Mem_WB FFMWB(.clk(clk), .reset(reset), 
                .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM),
                 
                .RegWriteW(RegWriteW), .ResultSrcW(ResultSrcW)
);

// Esto todavía no sé si funciona bien 
assign ZeroOpE = ZeroE ^ funct3E[0]; // Complements Zero flag for BNE Instruction
assign SignOpE = (SignE ^ funct3E[0]) ; // Complements Sign for BGE
assign BranchOpE = funct3E[2] ? (SignOpE) : (ZeroOpE);
assign PCSrcE = (BranchE & BranchOpE) | JumpE;
assign PCJalSrcE = (opE == 7'b1100111) ? 1 : 0; // jalr

endmodule