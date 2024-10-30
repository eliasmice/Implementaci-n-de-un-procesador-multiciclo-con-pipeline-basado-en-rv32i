
// Memoria para datos

module DataMem(
input logic         clk, ControlW, 
input logic  [31:0] addr, DataW, 
output logic [31:0] rd
);
		
	logic [31:0] RAM[4095:0];           // 64 x 32 
	assign rd = RAM[addr[31:2]];     // Para leer datos
	always_ff @(posedge clk)
		if (ControlW) RAM[addr[31:2]] <= DataW;
endmodule