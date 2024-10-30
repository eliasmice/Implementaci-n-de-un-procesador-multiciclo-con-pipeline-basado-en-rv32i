
// Procesador Risc-V 32i 
// Editado por: Tiler Ure�a
// �ltima actualizaci�n: 05/08/24
// Notas: Falta por probar el branch y el jump. No s� si el Hazard Unit funciona bien o no, toca probar tambi�n
 
module top (
input logic 			clk, reset, 
output logic [31:0] 	Data,  DataAdr, 
output logic 			ControlW
);
				
	logic [31:0] PC, InstrF, ReadDataM;

    // M�dulo principal, las funciones b�sicas est�n probadas (ADD-I, SUB, AND-I, OR-I, XOR-I, SLL-I, SRL-I, SRA-I, SLT-I>, )
    // Pero faltan algunas por probar e implementar
	RiscV_pipeline RV(.clk       (clk      ), 
	                  .reset     (reset    ), 
	                  .PC        (PC       ), 
	                  .InstrF    (InstrF   ), 
	                  .MemWriteM (ControlW ), 
	                  .ALUResultM(DataAdr  ), 
	                  .WriteDataM(Data     ), 
	                  .ReadDataM (ReadDataM)
	                 );
	
	// #----------Memorias----------#
	
	// Memoria para instrucciones
	InstrucMem IM(.addr  (PC    ), 
	              .InstrF(InstrF)
	             );
	
	//Memoria para datos
	DataMem DM(.clk     (clk      ), 
	           .ControlW(ControlW ), 
	           .addr    (DataAdr  ), 
	           .DataW   (Data     ), 
	           .rd      (ReadDataM)
	          );
endmodule
