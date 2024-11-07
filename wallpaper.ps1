# Ruta de la imagen que deseas usar como fondo de pantalla
$imagePath = "c:\windows\temp\wallpaper.png"

# Verificar que la imagen existe
if (Test-Path $imagePath) {
    # Llamar a la API de Windows para cambiar el fondo de pantalla
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll", CharSet=CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@

    # Valores para cambiar el fondo de pantalla
    $SPI_SETDESKWALLPAPER = 0x0014
    $SPIF_UPDATEINIFILE = 0x01
    $SPIF_SENDCHANGE = 0x02

    # Cambiar el fondo de pantalla
    [Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $imagePath, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)

    Write-Output "Fondo de pantalla cambiado a $imagePath"
} else {
    Write-Output "La imagen no se encontró en la ruta especificada: $imagePath"
}
