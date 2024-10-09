
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

   Luego, agrega esta configuración (reemplaza la ruta con la ubicación de tu script):

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

> [!WARNING]
> **Requisitos**: Este script requiere que `inotify-tools` esté instalado en tu sistema. Instálalo ejecutando:
>
> ```bash
> sudo apt install inotify-tools
> ```
