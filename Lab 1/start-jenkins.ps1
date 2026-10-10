<#
.SYNOPSIS
    Script de automatización para desplegar Jenkins en Docker (Laboratorio 1 - UTVT)
.DESCRIPTION
    Crea el volumen administrado, arranca el contenedor jenkins:lts-jdk21 y obtiene la clave inicial.
.AUTHOR
    Ludwin García Gaytán (Matrícula: 222310777 - IDGS-81)
#>

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  UNIVERSIDAD TECNOLOGICA DEL VALLE DE TOLUCA" -ForegroundColor Cyan
Write-Host "  Practica 11: Jenkins - Laboratorio 1" -ForegroundColor Cyan
Write-Host "  Alumno: Ludwin Garcia Gaytan | Matricula: 222310777" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Crear volumen si no existe
$volExists = docker volume ls --filter name=jenkins_home -q
if (-not $volExists) {
    Write-Host "[1/4] Creando volumen Docker 'jenkins_home'..." -ForegroundColor Yellow
    docker volume create jenkins_home
} else {
    Write-Host "[1/4] El volumen Docker 'jenkins_home' ya existe." -ForegroundColor Green
}

# 2. Desplegar contenedor
$containerRunning = docker ps --filter name=jenkins -q
if (-not $containerRunning) {
    Write-Host "[2/4] Desplegando contenedor Jenkins en http://127.0.0.1:8081..." -ForegroundColor Yellow
    docker run -d --name jenkins --restart unless-stopped -p 127.0.0.1:8081:8080 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk21
} else {
    Write-Host "[2/4] El contenedor 'jenkins' ya se encuentra en ejecucion." -ForegroundColor Green
}

# 3. Esperar inicialización
Write-Host "[3/4] Esperando a que el servicio inicialice..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# 4. Obtener initialAdminPassword
Write-Host "[4/4] Obteniendo initialAdminPassword:" -ForegroundColor Yellow
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

Write-Host "`nJenkins disponible en: http://127.0.0.1:8081" -ForegroundColor Green
