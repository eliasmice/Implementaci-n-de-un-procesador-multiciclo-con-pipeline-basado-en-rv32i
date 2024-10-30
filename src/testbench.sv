`timescale 1ns/1ps

module testbench();

	logic clk = 0, RST, ControlW;
	logic [31:0] Data, DataAdr;

	top dut(
		.clk(clk), 
		.reset(RST), 
		.Data(Data), 
		.DataAdr(DataAdr), 
		.ControlW(ControlW)
	);

	initial begin
        $dumpfile("C:/Users/HP/Pipeline/Proyecto 1 Arqui riscv/proyecto1-grupo-04/sim/testbench_tb.vcd"); // Ruta absoluta al archivo VCD
        $dumpvars(0, testbench);
    end
	
	always #10 clk = ~clk;	

	initial begin
			RST <= 0; 
			# 5; 
			RST <= 1;
			#50;
			RST <= 0;
			#10000;	
			// $display("#----------INICIO----------#");
			// $monitor("Salida de la ALU = %d", DataAdr);
			$finish;
		end	
endmodule
