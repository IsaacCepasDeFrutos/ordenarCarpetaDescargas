#!/bin/bash

Monitorear="/home/isaac/Descargas"
DestinoPNG="/home/isaac/Imágenes/png"
DestinoJPG="/home/isaac/Imágenes/jpg"
DestinoOtros="/home/isaac/Imágenes/otrosFormatos"
DestinoWallpapers="/home/isaac/Imágenes/wallpapers"
DestinoPDF="/home/isaac/Documentos/pdf"
DestinoComprobantes="/home/isaac/Documentos/comprobantesBlackBoard"

# Función para mover archivos según el tipo
mover_archivo() {
    archivo="$1"

    # Asegura que no se muevan archivos temporales o incompletos.
    if [[ "$archivo" == *.part || "$archivo" == *.crdownload ]]; then
        return 
    fi

    # Si el archivo comienza con 'wallp'.
    if [[ "$archivo" == wallp* ]]; then
        mv "$Monitorear/$archivo" "$DestinoWallpapers/"
        echo "El archivo $archivo ha sido movido a $DestinoWallpapers."
    
    # Si el archivo es .jpg o .jpeg.
    elif [[ "$archivo" == *.jpg || "$archivo" == *.jpeg ]]; then
        mv "$Monitorear/$archivo" "$DestinoJPG/"
        echo "El archivo $archivo ha sido movido a $DestinoJPG."
    
    # Si el archivo es .png.
    elif [[ "$archivo" == *.png ]]; then
        mv "$Monitorear/$archivo" "$DestinoPNG/"
        echo "El archivo $archivo ha sido movido a $DestinoPNG."
    
    # Otros formatos de imagen.
    elif [[ "$archivo" == *.gif || "$archivo" == *.bmp || "$archivo" == *.tiff || "$archivo" == *.webp || "$archivo" == *.heic || "$archivo" == *.ico ]]; then
        mv "$Monitorear/$archivo" "$DestinoOtros/"
        echo "El archivo $archivo ha sido movido a $DestinoOtros."
    
    # Si el archivo es .pdf.
    elif [[ "$archivo" == *.pdf ]]; then
        mv "$Monitorear/$archivo" "$DestinoPDF/"
        echo "El archivo $archivo ha sido movido a $DestinoPDF."
    
    # Formatos vectoriales.
    elif [[ "$archivo" == *.svg || "$archivo" == *.eps || "$archivo" == *.ai ]]; then
        mv "$Monitorear/$archivo" "$DestinoOtros/"
        echo "El archivo $archivo ha sido movido a $DestinoOtros."
        
    # Archivos de comprobación de entrega de tareas.    
    elif [[ "$archivo" == receipt-* ]]; then
        mv "$Monitorear/$archivo" "$DestinoComprobantes/"
        echo "El archivo $archivo ha sido movido a $DestinoComprobantes."
        
    # Cualquier otro archivo que no coincida.
    else
        echo "Formato de archivo no reconocido: $archivo"
    fi
}

# Procesar archivos ya existentes en la carpeta
for archivo in "$Monitorear"/*; do
    # Solo procesar si es un archivo regular
    if [[ -f "$archivo" ]]; then
        archivo=$(basename "$archivo")  # Obtener solo el nombre del archivo
        mover_archivo "$archivo"
    fi
done

# Monitorea la carpeta para archivos nuevos tanto creados como movidos.
inotifywait -m "$Monitorear" -e create -e moved_to |
while read directorio evento archivo; do
    echo "Archivo detectado: $archivo"  # Mensaje de depuración

    # Asegurar que el archivo realmente exista antes de moverlo
    if [[ -f "$Monitorear/$archivo" ]]; then
        mover_archivo "$archivo"
    else
        echo "El archivo $archivo no existe o está incompleto."
    fi
done

