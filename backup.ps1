# Definir las rutas de respaldo en el servidor
$computerName = 'Oswaldo Donovan Ordaz Eliosa'
$date = Get-Date -Format "yyyyMMdd"
$backupBasePath = "\\192.168.14.3\Respaldos_2021Vol2\Test\$computerName"

# Lista de rutas de origen
$sources = @(
    "C:\Users\Falcon\Documents\Falcon\Credenciales",
    "C:\Users\Falcon\Documents\Falcon\Responsivas",
    "C:\Users\Falcon\Downloads",
    "C:\Users\Falcon\Pictures"
)

# Crear el directorio de respaldo en el servidor si no existe
if (!(Test-Path -Path $backupBasePath)) {
    New-Item -ItemType Directory -Path $backupBasePath -Force
}

# Realizar respaldo para cada ruta de origen
foreach ($source in $sources) {
    # Definir la ruta de respaldo específica para la carpeta
    $folderName = Split-Path -Leaf $source
    $backupPath = "$backupBasePath\$folderName"

    # Crear la carpeta en el servidor para cada subcarpeta respaldada
    if (!(Test-Path -Path $backupPath)) {
        New-Item -ItemType Directory -Path $backupPath -Force
    }

    # Ejecutar robocopy para el respaldo incremental de cada carpeta
    # robocopy $source $backupPath /MIR /FFT /R:3 /W:5 /NP /LOG:"\\Servidor\Logs\backup_log_$computerName_$folderName_$date.txt"
    robocopy $source $backupPath /MIR /FFT /R:3 /W:5 /NP /LOG:C:\Users\Falcon\Documents\Falcon\Logs\backup_log_$computerName-$folderName-$date.txt
}
