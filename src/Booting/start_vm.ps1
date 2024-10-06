$vmxPath = "C:\Users\Pol Marsol\OneDrive\Documentos\Virtual Machines\D - Prova 4.2.2\D - Prova 4.2.2.vmx "

$vmrunPath = "C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe"

& "$vmrunPath" start "$vmxPath" nogui

if ($LASTEXITCODE -eq 0) {
    Write-Output "La máquina virtual se ha iniciado correctamente."
    
    Start-Sleep -Seconds 2
    
    ssh pol@192.168.210.138
} else {
    Write-Output "Error al iniciar la máquina virtual."
}
