# Define el directorio que contiene tus archivos Verilog
$verilogDir = "${PSScriptRoot}/../src"

# Define el directorio de salida
$outputDir = "${PSScriptRoot}/../sim"

# Crea el directorio de salida si no existe
if (-Not (Test-Path -Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir
}

# Obtén todos los archivos .sv en el directorio y sus subdirectorios
$verilogFiles = Get-ChildItem -Path $verilogDir -Recurse -Filter "*.sv" | ForEach-Object { $_.FullName }

# Define el archivo de salida
$outputFile = "${outputDir}/prueba.vvp"

# Ejecuta iverilog con todos los archivos encontrados
iverilog -g2012 -o $outputFile $verilogFiles

# Opcionalmente, puedes ejecutar la simulación
vvp $outputFile

# Define el archivo VCD generado
$vcdFile = "${outputDir}/testbench_tb.vcd"

# Espera a que el archivo VCD sea creado y tenga un tamaño mayor que 0 bytes
while (-Not (Test-Path -Path $vcdFile) -or (Get-Item -Path $vcdFile).Length -eq 0) {
    Start-Sleep -Seconds 1
}

# Abre GTKWave en pantalla completa y cierra la consola al cerrar GTKWave
Start-Process -FilePath "cmd.exe" -ArgumentList "/c start /max gtkwave $vcdFile & exit"