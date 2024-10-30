# Bubble Sort en Ensamblador (RISC-V)

## Descripción del Programa
Este programa implementa el algoritmo **Bubble Sort** en ensamblador para RISC-V. El objetivo es ordenar un conjunto de números almacenados en memoria utilizando este algoritmo de ordenación. Bubble Sort es un algoritmo simple que itera sobre una lista y compara pares de elementos adyacentes, intercambiándolos si están en el orden incorrecto. Este proceso se repite hasta que la lista está completamente ordenada.

## Instrucciones Soportadas
El programa ha sido diseñado para cumplir con los requisitos del proyecto, utilizando las siguientes instrucciones:

- **lw** y **sw** para cargar y almacenar datos en memoria.
- Operaciones lógicas y de desplazamiento como **slli**, **sll**, **srl**, **srli**.
- Instrucciones aritméticas como **add**, **addi**, **sub**.
- Comparaciones y ramas: **beq**, **bne**, **blt**, **bge**.
- Otras como **jal** y **jalr** para el control del flujo.

## Funcionamiento
1. **Carga de datos**: Inicialmente, el programa almacena en memoria un conjunto de números en direcciones consecutivas. Los números almacenados son: `5, 1, 4, 9, 0`.

2. **Iteración para ordenar**: El programa utiliza dos bucles anidados (uno para las iteraciones externas y otro para las comparaciones internas). Dentro del segundo bucle, compara cada par de elementos consecutivos:
   - Si el primer número es mayor que el segundo, los intercambia.
   - Este proceso continúa hasta que todos los números estén ordenados.

3. **Finalización y comprobación**: Una vez que el algoritmo termina, los números ordenados están almacenados en las mismas posiciones de memoria. Al final, los datos se cargan desde la memoria en los registros **x20** a **x24** para comprobar el resultado.

## Comprobación del Resultado
Al finalizar la ejecución del programa, los registros **x20**, **x21**, **x22**, **x23** y **x24** contendrán los números ordenados en orden ascendente. 

### Contenido Esperado de los Registros:

## Simulación y Verificación
Se recomienda tomar capturas de pantalla de la simulación en **GTKWave** para demostrar el correcto funcionamiento del programa.


