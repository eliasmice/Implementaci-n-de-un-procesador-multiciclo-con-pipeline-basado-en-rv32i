# Proyecto 1: Implementación de un procesador multiciclo con pipeline basado en `rv32i`
### EL4314 - Arquitectura de Computadoras I
### Escuela de Ingeniería Electrónica
### Tecnológico de Costa Rica

<br/><br/>

## Preámbulo

Para el desarrollo de este proyecto 1, usted deberá guiarse por la documentación que se encuentra en el capítulo 2 y 4 del libro *Computer Organization and Design: The Hardware Software Interface, RISC-V edition*.


## Procesador multiciclo con pipeline basado en `rv32i`

Usted desarrollará un procesador multiciclo con pipeline como el que muestra en la siguiente figura.

![Diagrama de bloques para el procesador multiciclo con pipeline](https://github.com/TEC-EL3310/proyecto_final/blob/main/figs/diagram_pipeline.png?raw=true "Diagrama de bloques de un procesador multiciclo con pipeline basado en `rv32i`")


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

## Programas de prueba
Deberá escribir al menos 2 programas, en lenguaje ensamblador, que le permitan estresar su diseño y asegurarse de que todas las instrucciones anteriores están debidamente soportadas. Dichos programas deberán tener algún sentido algorítmico y no ser simplemente una serie de instrucciones que no ejecutan algo con sentido.


## Evaluación
Este proyecto corto se evaluará con la siguiente rúbrica.


| Rubro | % | C | EP | D | NP |
|-------|---|---|----|---|----|
|Desarrollo de procesador | 60 |   |    |   |    |
|Validación funcional del procesador con programas desarrollados  |30|   |    |   |    |
|Uso de repositorio |10|   |    |   |    |

C: Completo,
EP: En progreso ($\times 0,8$),
D: Deficiente ($\times 0,5$),
NP: No presenta ($\times 0$)

Para el rubro de "Uso de repositorio" se requiere que existan contribuciones de todos los miembros del equipo. El último _commit_ debe registraste antes de las 11:59 pm del sábado 28 de setiembre de 2024.

