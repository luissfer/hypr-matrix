#!/bin/bash

SOURCE="waybar"
DEST="$HOME/.config/waybar"

# Verifica si la carpeta fuente existe
if [[ ! -d "$SOURCE" ]]; then
  echo "Advertencia: La carpeta '$SOURCE' no existe. No se realizó ninguna acción."
else
  # Crea la carpeta destino si no existe
  mkdir -p "$DEST"

  # Copia recursivamente todos los archivos y directorios
  cp -r "$SOURCE/"* "$DEST/"

  echo "Archivos copiados exitosamente a $DEST."
fi