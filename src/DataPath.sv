
// Datapath, 5 estados, Fetch, Dec, Exe, Mem, WB
// Hay una imagen donde se ve más bonito

module DataPath(
input logic         clk, reset,
input logic  [1:0]  ResultSrcW,
input logic         PCJalSrcE, PCSrcE, ALUSrcAE, 
input logic  [1:0]  ALUSrcBE,
input logic         RegWriteW,
input logic  [2:0]  ImmSrcD,
input logic  [3:0]  ALUControlE,
input logic  [31:0] InstrF,
input logic  [31:0] ReadDataM,
input logic  [1:0]  ForwardAE, ForwardBE,
input logic         StallD, StallF, FlushD, FlushE,
output logic        ZeroE,
output logic        SignE,
output logic [31:0] PCF,
output logic [31:0] InstrD,
output logic [31:0] ALUResultM, WriteDataM,
output logic [4:0]  Rs1D, Rs2D, Rs1E, Rs2E,
output logic [4:0]  RdE, RdM, RdW
);


	logic [31:0] PCD, PCE, ALUResultE, ALUResultW, ReadDataW;
	logic [31:0] PCNextF, PCPlus4F, PCPlus4D, PCPlus4E, PCPlus4M, PCPlus4W, PCTargetE, BranJumpTargetE;
	logic [31:0] WriteDataE;
	logic [31:0] ImmExtD, ImmExtE;
	logic [31:0] SrcAEfor, SrcAE, SrcBE, RD1D, RD2D, RD1E, RD2E;
	logic [31:0] ResultW;
	
	logic [4:0] RdD;

	
	// #----------Fetch----------#
	
	// Primer mux
	mux2 jal_r(PCTargetE, ALUResultE, PCJalSrcE, BranJumpTargetE);
	
	// Mux del PC
	mux2 pcmux(PCPlus4F, BranJumpTargetE, PCSrcE, PCNextF);
	
	// FF antes del Instruction Memory
	flopenr IF(clk, reset, ~StallF, PCNextF, PCF);
	
	// Sumador para el PC + 4
	adder pcadd4(PCF, 32'd4, PCPlus4F);
	
	
	// #----------Decode----------#
		
	// Instruction Fetch - FF Decode 
	IF_ID FF_FD(clk, reset, FlushD, ~StallD, InstrF, PCF, PCPlus4F, InstrD, PCD, PCPlus4D);
	
	// Se divide el InstrD en las dos entradas del Register File
	assign Rs1D = InstrD[19:15];
	assign Rs2D = InstrD[24:20];
	
	// Resgister File	
	regfile rf (clk, RegWriteW, Rs1D, Rs2D, RdW, ResultW, RD1D, RD2D);
	
	// x
	assign RdD = InstrD[11:7];
	
	// Extend Unit, para tipos Inmediatos
	extend ext(InstrD[31:7], ImmSrcD, ImmExtD);
	
	
	// #----------Execute----------#	
	
	// FF del Decode al Execution
	ID_IEx FF_DE(clk, reset, FlushE, RD1D, RD2D, PCD, Rs1D, Rs2D, RdD, ImmExtD, PCPlus4D, RD1E, RD2E, PCE, Rs1E, Rs2E, RdE, ImmExtE, PCPlus4E);
	
	// Mux que recibe la salida RD1 del Register File y el resultado de la ALU 
	mux3 RD1MUX(RD1E, ResultW, ALUResultM, ForwardAE, SrcAEfor);
	
	// Mux que recibe la salida del RD1MUX y 321b0 para el lui 
	mux2 luimux(SrcAEfor, 32'b0, ALUSrcAE, SrcAE);
	
	// Mux que recibe la salida RD2 del Register File y el resultado de la ALU 
	mux3 RD2MUX(RD2E, ResultW, ALUResultM, ForwardBE, WriteDataE);
	
	//Mux qeu recibe la salida del RD2MUX, la extensión de los inmediatos y el PCTarget
	mux3 InmMUX(WriteDataE, ImmExtE, PCTargetE, ALUSrcBE, SrcBE);
	
	// Sumador para el PC en las instrucciones de jump y branch 
	adder pcadderJumpBranch(PCE, ImmExtE, PCTargetE);
	
	// ALU 
	alu alu(SrcAE, SrcBE, ALUControlE, ALUResultE, ZeroE, SignE);
	
	
	// #----------Memory----------#	
	
		
	// FF de Decode a Memory, de aquí salen los datos que van a memoria (WriteDataM)
	IEx_IMem FF_DM(clk, reset, ALUResultE, WriteDataE, RdE, PCPlus4E, ALUResultM, WriteDataM, RdM, PCPlus4M);
	
	
	// #----------WriteBack----------#
		
	// FF de Memory a WriteBack
	IMem_IW FF_MWb(clk, reset, ALUResultM, ReadDataM, RdM, PCPlus4M, ALUResultW, ReadDataW, RdW, PCPlus4W);
	
	// Mux final, regresa el resultado al Register File o al RD1MUX
	mux3 finalmux( ALUResultW, ReadDataW, PCPlus4W, ResultSrcW, ResultW);
endmodule