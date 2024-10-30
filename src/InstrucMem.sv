module InstrucMem(  
    input logic [31:0] addr,  
    output logic [31:0] InstrF  
);  
    logic [31:0] RAM[2047:0]; // 2048 levels x 32 bits  

    // Asignación desde RAM dependiendo de la dirección  
    assign InstrF = RAM[addr[9:2]]; // Suponiendo que addr solo usa bits 9 a 2  

    initial begin  
        $readmemh("sim/bubble.hex", RAM,0,42); // Lee las primeras 26 palabras  
    end  
endmodule
