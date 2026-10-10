#!/usr/bin/env bash
# ==========================================================
# UNIVERSIDAD TECNOLOGICA DEL VALLE DE TOLUCA
# Practica 11: Jenkins - Laboratorio 1
# Alumno: Ludwin Garcia Gaytan | Matricula: 222310777 (IDGS-81)
# ==========================================================
set -e

echo "[1/4] Creando volumen jenkins_home..."
docker volume create jenkins_home || true

echo "[2/4] Desplegando contenedor jenkins:lts-jdk21 en puerto 8081..."
docker run -d --name jenkins --restart unless-stopped -p 127.0.0.1:8081:8080 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk21 || true

echo "[3/4] Esperando inicializacion de Jenkins..."
sleep 10

echo "[4/4] initialAdminPassword:"
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

echo "Jenkins disponible en: http://127.0.0.1:8081"
