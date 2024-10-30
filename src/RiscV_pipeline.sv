
//  Módulo central de todo el procesasdor
// Hazard Unit todavía no sé si funciona bien

module RiscV_pipeline(
input logic         clk, reset,
input logic  [31:0] ReadDataM,
input logic  [31:0] InstrF,
output logic        MemWriteM,
output logic [31:0] ALUResultM, WriteDataM,
output logic [31:0] PC
);
	
logic ALUSrcAE, RegWriteM, RegWriteW, ZeroE, SignE, PCJalSrcE, PCSrcE;
logic [1:0] ALUSrcBE;
logic StallD, StallF, FlushD, FlushE, ResultSrcE0;
logic [1:0] ResultSrcW; 
logic [2:0] ImmSrcD;
logic [3:0] ALUControlE;
logic [31:0] InstrD;
logic [4:0] Rs1D, Rs2D, Rs1E, Rs2E;
logic [4:0] RdE, RdM, RdW;
logic [1:0] ForwardAE, ForwardBE;

//Unidad de control 
ControlUnit CU( .clk(clk), .reset(reset), 
                .op(InstrD[6:0]), .funct3(InstrD[14:12]), .funct7b5(InstrD[30]), .ZeroE(ZeroE), .SignE(SignE), .FlushE(FlushE),
                 
                .ResultSrcE0(ResultSrcE0), .ResultSrcW(ResultSrcW), .MemWriteM(MemWriteM), .PCJalSrcE(PCJalSrcE), .PCSrcE(PCSrcE), 
                .ALUSrcAE(ALUSrcAE), .ALUSrcBE(ALUSrcBE), .RegWriteM(RegWriteM), .RegWriteW(RegWriteW), .ImmSrcD(ImmSrcD), .ALUControlE(ALUControlE)
);

// Hazard Unit (Funciona bien?)
HazardU HU( .Rs1D(Rs1D), .Rs2D(Rs2D), .Rs1E(Rs1E), .Rs2E(Rs2E), .RdE(RdE), .RdM(RdM), .RdW(RdW), .RegWriteM(RegWriteM), .RegWriteW(RegWriteW), 
            .ResultSrcE0(ResultSrcE0), .PCSrcE(PCSrcE), 
            
            .ForwardAE(ForwardAE), .ForwardBE(ForwardBE), .StallD(StallD), .StallF(StallF), .FlushD(FlushD), .FlushE(FlushE)
);

// Datapath 
DataPath DP(.clk(clk), .reset(reset), 
            .ResultSrcW(ResultSrcW), .PCJalSrcE(PCJalSrcE), .PCSrcE(PCSrcE), .ALUSrcAE(ALUSrcAE), .ALUSrcBE(ALUSrcBE), .RegWriteW(RegWriteW), 
            .ImmSrcD(ImmSrcD), .ALUControlE(ALUControlE), .InstrF(InstrF), .ReadDataM(ReadDataM), .ForwardAE(ForwardAE), .ForwardBE(ForwardBE), 
            .StallD(StallD), .StallF(StallF), .FlushD(FlushD), .FlushE(FlushE),
            
            .ZeroE(ZeroE), .SignE(SignE), .PCF(PC), .InstrD(InstrD), .ALUResultM(ALUResultM), .WriteDataM(WriteDataM),  .Rs1D(Rs1D), .Rs2D(Rs2D), 
            .Rs1E(Rs1E), .Rs2E(Rs2E), .RdE(RdE), .RdM(RdM), .RdW(RdW) 
);
endmodule
