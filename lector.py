#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
lector.py - Escáner de proyectos para documentación
Genera archivos de texto con el contenido de todos los archivos del proyecto,
excluyendo librerías y dependencias.
"""

import os
import sys
import re
from pathlib import Path
from datetime import datetime

# ============================================
# CONFIGURACIÓN
# ============================================

# Carpetas y archivos a EXCLUIR (no se procesarán)
EXCLUIR_CARPETAS = [
    'node_modules',
    '.git',
    '.vscode',
    '.idea',
    '__pycache__',
    'venv',
    'env',
    'dist',
    'build',
    'coverage',
    '.nyc_output',
    'tmp',
    'temp',
    'Resumen'  # 🆕 Excluir la carpeta de salida
]

EXCLUIR_ARCHIVOS = [
    # ' .env',  # ❌ ELIMINADO: Ahora .env SÍ se incluirá
    '.gitignore',
    '.DS_Store',
    'Thumbs.db',
    'package-lock.json',
    'yarn.lock',
    'pnpm-lock.yaml',
    '.eslintrc',
    '.prettierrc',
    '.editorconfig',
    'lector.py',  # 🆕 Excluir el propio script
    'resumen.txt'  # 🆕 Excluir archivos de resumen antiguos
]

# Extensiones de archivos a procesar (None = todas)
EXTENSIONES_PERMITIDAS = [
    '.js', '.jsx', '.ts', '.tsx', '.json', '.sql',
    '.py', '.rb', '.php', '.java', '.go', '.rs',
    '.css', '.scss', '.sass', '.less',
    '.html', '.ejs', '.pug', '.hbs', '.mustache',
    '.yml', '.yaml', '.toml', '.ini', '.cfg',
    '.sh', '.bash', '.zsh', '.ps1', '.bat', '.cmd',
    '.dockerfile', '.dockerignore',
    '.xml', '.xsd', '.xslt',
    '.md', '.markdown', '.rst',
    '.txt', '.log',
    '.env'  # 🆕 Asegurar que .env esté incluido (aunque ya lo está)
]

# Tamaño máximo por archivo de salida (en líneas)
MAX_LINEAS_POR_ARCHIVO = 20000

# Carpeta donde se guardarán los archivos de salida
CARPETA_SALIDA = "Resumen"

# ============================================
# FUNCIONES PRINCIPALES
# ============================================

def limpiar_texto(texto):
    """Limpia caracteres especiales que puedan causar problemas"""
    # Eliminar caracteres de control (excepto saltos de línea y tabs)
    texto = re.sub(r'[\x00-\x08\x0b\x0c\x0e-\x1f\x7f]', '', texto)
    return texto

def deberia_excluir(ruta, es_carpeta=False):
    """
    Determina si una ruta debería ser excluida
    """
    nombre = ruta.name
    
    # Verificar si es una carpeta o archivo excluido
    if es_carpeta:
        for patron in EXCLUIR_CARPETAS:
            if patron in ruta.parts or nombre == patron:
                return True
    else:
        for patron in EXCLUIR_ARCHIVOS:
            if nombre == patron:
                return True
    
    return False

def extension_permitida(ruta):
    """Verifica si la extensión del archivo está permitida"""
    if EXTENSIONES_PERMITIDAS is None:
        return True
    
    # Si no tiene extensión, permitir
    if not ruta.suffix:
        return True
        
    return ruta.suffix.lower() in EXTENSIONES_PERMITIDAS

def leer_archivo(ruta):
    """Lee el contenido de un archivo de forma segura"""
    try:
        # Intentar leer como UTF-8
        with open(ruta, 'r', encoding='utf-8', errors='ignore') as f:
            contenido = f.read()
    except Exception:
        try:
            # Fallback a Latin-1
            with open(ruta, 'r', encoding='latin-1') as f:
                contenido = f.read()
        except Exception as e:
            contenido = f"ERROR: No se pudo leer el archivo: {e}"
    
    return limpiar_texto(contenido)

def procesar_archivo(ruta, output_file):
    """
    Escribe el contenido de un archivo en el archivo de salida
    Retorna el número de líneas escritas
    """
    # Escribir cabecera con la ruta
    cabecera = f"\n\n{'='*80}\n"
    cabecera += f"ARCHIVO: {ruta.absolute()}\n"
    cabecera += f"{'='*80}\n\n"
    output_file.write(cabecera)
    
    # Leer y escribir contenido
    contenido = leer_archivo(ruta)
    output_file.write(contenido)
    output_file.write("\n")
    
    # Contar líneas
    lineas = cabecera.count('\n') + contenido.count('\n') + 1
    return lineas

def necesita_nuevo_archivo(archivo_actual, lineas_escritas):
    """Determina si es necesario crear un nuevo archivo de salida"""
    return lineas_escritas >= MAX_LINEAS_POR_ARCHIVO

def obtener_proximo_nombre(base_dir, prefijo="Parte"):
    """Obtiene el siguiente nombre de archivo disponible"""
    parte = 1
    while True:
        nombre = f"{prefijo}{parte}.txt"
        ruta = base_dir / nombre
        if not ruta.exists():
            return ruta, parte
        parte += 1

def escanear_proyecto(ruta_inicio):
    """
    Escanea recursivamente un proyecto y genera archivos de salida
    """
    print(f"\n🔍 Escaneando proyecto en: {ruta_inicio.absolute()}")
    print(f"📋 Excluyendo carpetas: {', '.join(EXCLUIR_CARPETAS)}")
    print(f"📄 Límite: {MAX_LINEAS_POR_ARCHIVO} líneas por archivo")
    print("-" * 60)
    
    # Crear carpeta de salida
    carpeta_salida = Path(CARPETA_SALIDA)
    carpeta_salida.mkdir(parents=True, exist_ok=True)
    
    # Archivos de salida
    archivo_actual = None
    lineas_escritas = 0
    parte_numero = 1
    total_archivos = 0
    total_lineas = 0
    archivos_procesados = []
    
    # Obtener el primer nombre de archivo
    ruta_salida, parte_numero = obtener_proximo_nombre(carpeta_salida, "Parte")
    archivo_actual = open(ruta_salida, 'w', encoding='utf-8')
    print(f"📝 Creando: {ruta_salida.name}")
    
    # Escribir encabezado del archivo
    archivo_actual.write("=" * 80 + "\n")
    archivo_actual.write(f"DOCUMENTACIÓN DEL PROYECTO\n")
    archivo_actual.write(f"Fecha: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    archivo_actual.write(f"Ruta base: {ruta_inicio.absolute()}\n")
    archivo_actual.write("=" * 80 + "\n")
    lineas_escritas += 5
    
    # Recorrer todos los archivos
    for ruta_actual in ruta_inicio.rglob('*'):
        # Verificar si es una carpeta
        if ruta_actual.is_dir():
            if deberia_excluir(ruta_actual, es_carpeta=True):
                print(f"⏭️  Excluyendo carpeta: {ruta_actual.relative_to(ruta_inicio)}")
                # No recorrer esta carpeta
                continue
            continue
        
        # Es un archivo
        # Verificar si debe ser excluido
        if deberia_excluir(ruta_actual, es_carpeta=False):
            print(f"⏭️  Excluyendo archivo: {ruta_actual.relative_to(ruta_inicio)}")
            continue
        
        # Verificar extensión
        if not extension_permitida(ruta_actual):
            print(f"⏭️  Extensión no permitida: {ruta_actual.relative_to(ruta_inicio)}")
            continue
        
        # Procesar el archivo
        try:
            print(f"📄 Procesando: {ruta_actual.relative_to(ruta_inicio)}")
            
            lineas_agregadas = procesar_archivo(ruta_actual, archivo_actual)
            lineas_escritas += lineas_agregadas
            total_lineas += lineas_agregadas
            archivos_procesados.append(ruta_actual.relative_to(ruta_inicio))
            total_archivos += 1
            
            # Verificar si necesitamos nuevo archivo
            if necesita_nuevo_archivo(archivo_actual, lineas_escritas):
                archivo_actual.close()
                print(f"✅ Alcanzado límite de líneas. Cerrando {ruta_salida.name}")
                
                # Crear nuevo archivo
                ruta_salida, parte_numero = obtener_proximo_nombre(carpeta_salida, "Parte")
                archivo_actual = open(ruta_salida, 'w', encoding='utf-8')
                print(f"📝 Creando: {ruta_salida.name}")
                
                # Escribir encabezado del nuevo archivo
                archivo_actual.write("=" * 80 + "\n")
                archivo_actual.write(f"DOCUMENTACIÓN DEL PROYECTO - PARTE {parte_numero}\n")
                archivo_actual.write(f"Fecha: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
                archivo_actual.write(f"Ruta base: {ruta_inicio.absolute()}\n")
                archivo_actual.write("=" * 80 + "\n")
                archivo_actual.write(f"Continuación del archivo anterior\n\n")
                lineas_escritas = 5  # Reiniciar contador (cabecera del nuevo archivo)
                
        except Exception as e:
            print(f"❌ Error procesando {ruta_actual}: {e}")
    
    # Cerrar el último archivo
    if archivo_actual:
        archivo_actual.close()
        print(f"✅ Cerrando último archivo: {ruta_salida.name}")
    
    # Generar archivo de resumen
    generar_resumen(carpeta_salida, archivos_procesados, total_archivos, total_lineas, parte_numero)
    
    print("-" * 60)
    print(f"✅ PROCESO COMPLETADO")
    print(f"📊 Total archivos procesados: {total_archivos}")
    print(f"📄 Total líneas escritas: {total_lineas}")
    print(f"📁 Archivos generados en: {carpeta_salida.absolute()}")
    print("-" * 60)

def generar_resumen(carpeta_salida, archivos_procesados, total_archivos, total_lineas, partes):
    """Genera un archivo de resumen con estadísticas"""
    ruta_resumen = carpeta_salida / "resumen.txt"
    
    with open(ruta_resumen, 'w', encoding='utf-8') as f:
        f.write("=" * 80 + "\n")
        f.write("RESUMEN DE DOCUMENTACIÓN GENERADA\n")
        f.write("=" * 80 + "\n\n")
        f.write(f"Fecha de generación: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"Total archivos procesados: {total_archivos}\n")
        f.write(f"Total líneas escritas: {total_lineas}\n")
        f.write(f"Número de partes generadas: {partes}\n\n")
        
        f.write("-" * 80 + "\n")
        f.write("ARCHIVOS PROCESADOS:\n")
        f.write("-" * 80 + "\n\n")
        
        # Agrupar por extensión
        extensiones = {}
        for ruta in archivos_procesados:
            ext = ruta.suffix or "sin_extensión"
            extensiones[ext] = extensiones.get(ext, 0) + 1
        
        # Escribir estadísticas por extensión
        for ext, count in sorted(extensiones.items(), key=lambda x: x[1], reverse=True):
            f.write(f"  {ext}: {count} archivos\n")
        
        f.write("\n" + "-" * 80 + "\n")
        f.write("LISTA COMPLETA DE ARCHIVOS:\n")
        f.write("-" * 80 + "\n\n")
        
        for ruta in sorted(archivos_procesados):
            f.write(f"  {ruta}\n")

# ============================================
# EJECUCIÓN PRINCIPAL
# ============================================

def main():
    """Función principal del script"""
    print("\n" + "=" * 80)
    print("📂 LECTOR DE PROYECTOS - GENERADOR DE DOCUMENTACIÓN")
    print("=" * 80)
    
    # Determinar la ruta a escanear
    if len(sys.argv) > 1:
        ruta_inicio = Path(sys.argv[1])
    else:
        # Usar el directorio actual
        ruta_inicio = Path.cwd()
    
    # Verificar que la ruta existe
    if not ruta_inicio.exists():
        print(f"❌ Error: La ruta '{ruta_inicio}' no existe")
        sys.exit(1)
    
    if not ruta_inicio.is_dir():
        print(f"❌ Error: '{ruta_inicio}' no es un directorio")
        sys.exit(1)
    
    # Mostrar configuración actual
    print(f"📁 Directorio de inicio: {ruta_inicio.absolute()}")
    print(f"📂 Carpeta de salida: {CARPETA_SALIDA}")
    print(f"📏 Máximo líneas por archivo: {MAX_LINEAS_POR_ARCHIVO}")
    print("=" * 80)
    
    # Preguntar si desea continuar
    respuesta = input("¿Desea continuar con la generación? (s/N): ").lower()
    if respuesta != 's':
        print("❌ Proceso cancelado por el usuario")
        sys.exit(0)
    
    # Ejecutar el escaneo
    try:
        escanear_proyecto(ruta_inicio)
    except KeyboardInterrupt:
        print("\n\n⚠️  Proceso interrumpido por el usuario")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Error inesperado: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
