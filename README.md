# Proyecto 1: Implementación de un procesador multiciclo con pipeline basado en `rv32i`
### EL4314 - Arquitectura de Computadoras I
### Escuela de Ingeniería Electrónica
### Tecnológico de Costa Rica

<br/><br/>

## Preámbulo

Para el desarrollo de este proyecto 1, usted deberá guiarse por la documentación que se encuentra en el capítulo 2 y 4 del libro *Computer Organization and Design: The Hardware Software Interface, RISC-V edition*.


## Procesador multiciclo con pipeline basado en `rv32i`

Usted desarrollará un procesador multiciclo con pipeline como el que muestra en la siguiente figura.

![diagram_pipeline](https://github.com/user-attachments/assets/8b86e2c6-fa46-489d-a4e4-15db1ae1a9cf)



Para este proyecto usted implementará, además de los bloques básicos que se encuentran en un procesador uniciclo, los siguientes bloques funcionales:
- Registros intermedios entre las etapas
- Unidad de detección de riesgos (_Hazard unit detection_)
- Unidad de adelantamiento (_Forward unit_)
- Comparador a la salida del archivo de registros y sumador en la etapa ID para cálculo de dirección de salto (_target address_)
- Multiplexores (nuevos y modificaciones, según sea necesario)

Para esta implementación, usted debe considerar que su procesador implementa una técnica estática de predicción de saltos con la cual se considera que siempre **los saltos no se toman** (_always not taken_). Asegúrese de que su procesador es capaz de ejecutar un _flush_ en caso de que deba de cambiar la dirección de salto.

Usted deberá implementar las siguientes instrucciones del [_greencard_](https://tecdigital.tec.ac.cr/dotlrn/classes/E/EL4314/S-2-2024.CA.EL4314.1/file-storage/view/materiales%2Fgreencard.pdf):

```asm
lw
sw
sll, slli, srl, srli, sra, srai
add, addi, sub
xor, xori, or, ori, and, andi
beq, bne, blt, bge
slt, slti, sltu, sltui
jal, jalr
```



