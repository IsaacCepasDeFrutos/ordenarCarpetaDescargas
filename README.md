[ESP]

# Documentación del Script `ordenarCarpetaDescargas.sh`

## Descripción
`ordenarCarpetaDescargas.sh` es un script en Bash diseñado para sistemas Linux que facilita la **organización automática** de archivos descargados, filtrando por nombre o extensión. Este script está pensado para optimizar la tediosa tarea de clasificar archivos descargados de Internet, como justificantes de entrega de tareas de clase, además de ser útil para organizar archivos **PDF** e **imágenes**.

## Funcionalidades
- **Clasificación Automática**: Mueve archivos a carpetas designadas según su tipo (imágenes, PDF, etc.).
- **Configuración Sencilla**: Permite modificar las rutas de las carpetas y los tipos de archivos fácilmente.
- **Monitoreo en Tiempo Real**: Utiliza `inotifywait` para detectar y mover archivos automáticamente a medida que llegan a la carpeta de descargas.

## Configuración

> [!IMPORTANT]
> Antes de usar el script, asegúrate de que las carpetas de destino estén creadas. También puedes modificar las rutas en el script para adaptarlo a tu estructura de carpetas.

### Variables a Modificar
- `Monitorear`: Ruta de la carpeta que se va a vigilar (por defecto: `/home/isaac/Descargas`).
- `DestinoPNG`: Carpeta para archivos PNG (por defecto: `/home/isaac/Imágenes/png`).
- `DestinoJPG`: Carpeta para archivos JPG (por defecto: `/home/isaac/Imágenes/jpg`).
- `DestinoOtros`: Carpeta para otros formatos de imagen (por defecto: `/home/isaac/Imágenes/otrosFormatos`).
- `DestinoWallpapers`: Carpeta para archivos de wallpapers (por defecto: `/home/isaac/Imágenes/wallpapers`).
- `DestinoPDF`: Carpeta para archivos PDF (por defecto: `/home/isaac/Documentos/pdf`).
- `DestinoComprobantes`: Carpeta para archivos de comprobación de entrega (por defecto: `/home/isaac/Documentos/comprobantesBlackBoard`).

## Uso de `Systemd`

### Hacer que el Script se Ejecute Automáticamente

Para ejecutar el script al iniciar el sistema, sigue estos pasos:

1. **Crear un Archivo de Servicio**:
   Abre una terminal y ejecuta:

   ```bash
   sudo nano /etc/systemd/system/ordenarCarpetaDescargas.service
   ```
> [!IMPORTANT]
  > Luego, agrega esta configuración (reemplaza la ruta con la ubicación de tu script y utiliza el nombre de usuario de tu sistema):

   ```ini
   [Unit]
   Description=Servicio para mover imágenes automáticamente
   After=multi-user.target

   [Service]
   ExecStart=/bin/bash /home/isaac/ordenarCarpetaDescargas.sh
   Restart=on-failure
   User=isaac
   Environment=DISPLAY=:0
   StandardOutput=append:/var/log/ordenarCarpetaDescargas.log
   StandardError=append:/var/log/ordenarCarpetaDescargas-error.log

   [Install]
   WantedBy=multi-user.target
   ```

2. **Habilitar e Iniciar el Servicio**:
   Ejecuta los siguientes comandos para habilitar e iniciar el servicio:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable ordenarCarpetaDescargas.service
   sudo systemctl start ordenarCarpetaDescargas.service
   ```

3. **Verificar el Estado del Servicio**:
   Para comprobar si el servicio está funcionando, utiliza:

   ```bash
   sudo systemctl status ordenarCarpetaDescargas.service
   ```

## Ejemplo de Uso

Una vez configurado y habilitado el servicio, el script organizará automáticamente los archivos que descargues en la carpeta especificada. **Recuerda** verificar que las carpetas de destino existen y están correctamente definidas.

> [!NOTE]
> Si las carpetas de destino no existen, el script puede fallar o no mover los archivos correctamente.

## Notas Adicionales

> [!TIP]
> **Permisos**: Asegúrate de que el script tenga permisos de ejecución. Puedes asignarlos con el siguiente comando:
>
> ```bash
> chmod +x /home/isaac/ordenarCarpetaDescargas.sh
> ```

> [!IMPORTANT]
> **Requisitos**: Este script requiere que `inotify-tools` esté instalado en tu sistema. Instálalo ejecutando:
>
> ```bash
> sudo apt install inotify-tools
> ```

[ENG]


# Documentation for the Script `ordenarCarpetaDescargas.sh`

## Description
`ordenarCarpetaDescargas.sh` is a Bash script designed for Linux systems that facilitates the **automatic organization** of downloaded files by filtering by name or extension. This script is intended to optimize the tedious task of sorting downloaded files from the Internet, such as task submission receipts, and is also useful for organizing **PDF** and **image** files.

## Features
- **Automatic Classification**: Moves files to designated folders based on their type (images, PDF, etc.).
- **Easy Configuration**: Allows you to easily modify folder paths and file types.
- **Real-Time Monitoring**: Uses `inotifywait` to detect and move files automatically as they arrive in the download folder.

## Configuration

> [!IMPORTANT]
> Before using the script, ensure that the destination folders are created. You can also modify the paths in the script to suit your folder structure.

### Variables to Modify
- `Monitor`: Path of the folder to be monitored (default: `/home/isaac/Downloads`).
- `DestinationPNG`: Folder for PNG files (default: `/home/isaac/Images/png`).
- `DestinationJPG`: Folder for JPG files (default: `/home/isaac/Images/jpg`).
- `DestinationOthers`: Folder for other image formats (default: `/home/isaac/Images/otherFormats`).
- `DestinationWallpapers`: Folder for wallpaper files (default: `/home/isaac/Images/wallpapers`).
- `DestinationPDF`: Folder for PDF files (default: `/home/isaac/Documents/pdf`).
- `DestinationReceipts`: Folder for submission receipts (default: `/home/isaac/Documents/blackboardReceipts`).

## Using `Systemd`

### Make the Script Run Automatically

To run the script automatically at system startup, follow these steps:

1. **Create a Service File**:
   Open a terminal and run:

   ```bash
   sudo nano /etc/systemd/system/ordenarCarpetaDescargas.service
   ```

> [!IMPORTANT]
  > Then, add the following configuration (replace the path with your script's location and use your system's username):

   ```ini
   [Unit]
   Description=Service for automatically moving images
   After=multi-user.target

   [Service]
   ExecStart=/bin/bash /home/isaac/ordenarCarpetaDescargas.sh
   Restart=on-failure
   User=isaac
   Environment=DISPLAY=:0
   StandardOutput=append:/var/log/ordenarCarpetaDescargas.log
   StandardError=append:/var/log/ordenarCarpetaDescargas-error.log

   [Install]
   WantedBy=multi-user.target
   ```

2. **Enable and Start the Service**:
   Run the following commands to enable and start the service:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable ordenarCarpetaDescargas.service
   sudo systemctl start ordenarCarpetaDescargas.service
   ```

3. **Check the Status of the Service**:
   To verify if the service is running, use:

   ```bash
   sudo systemctl status ordenarCarpetaDescargas.service
   ```

## Usage Example

Once the service is configured and enabled, the script will automatically organize the files you download into the specified folder. **Remember** to check that the destination folders exist and are correctly defined.

> [!NOTE]
> If the destination folders do not exist, the script might fail or not move the files correctly.

## Additional Notes

> [!TIP]
> **Permissions**: Make sure the script has execution permissions. You can set them with the following command:
>
> ```bash
> chmod +x /home/isaac/ordenarCarpetaDescargas.sh
> ```

> [!IMPORTANT]
> **Requirements**: This script requires `inotify-tools` to be installed on your system. You can install it by running:
>
> ```bash
> sudo apt install inotify-tools
> ```
