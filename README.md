WIP

# Índice
1. [Información](#información)

2. [Compilar Rustdesk (Sin Modificar)](#compilar-rustdesk-sin-modificar)

3. [Cambios al Código Original](#cambios-al-código-original)

    - 3.1 [Cambios Generales](#cambios-generales)

    - 3.2 [Aplicar cambios en Windows (WIP)](#aplicar-cambios-en-windows)

    - 3.3 [Cambios aplicados (WIP)](#cambios-aplicados)
    
    - 3.4 [Aplicar cambios en MacOS (WIP)](#aplicar-cambios-en-macos)

    - 3.5 [Cambios aplicados (WIP)](#cambios-aplicados-1)

# Información
# Soporte-Cliente-TIC
Cliente Modificado de Rustdesk para solicitud de soporte remoto 

Este proyecto toma a **RustDesk** [<img src="https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/.img/external-link.png" alt="External Link" title="Abrir en una nueva pestaña" width="18" heigth="18">](https://github.com/rustdesk/rustdesk) [^1] (1.4.9) como base, añadiendo funcionalidades para el preste de servicios de soporte remoto. 

- Términos de Uso [<img src="https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/.img/external-link.png" alt="External Link" title="Abrir en una nueva pestaña" width="18" heigth="18">](https://ticonsultores.cl/terms.html)
- Términos de Privacidad [<img src="https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/.img/external-link.png" alt="External Link" title="Abrir en una nueva pestaña" width="18" heigth="18">](https://ticonsultores.cl/privacy.html)

<br>Versiones Específicas:<br>

(:::)

Para esto se necesitaría seguir las instrucciones del propio repositorio de rustdesk, que mencionaré aquí en caso de que cambien, para compilar la aplicación usando Flutter (No Sciter):

Para efectos prácticos se utilizará la herramienta **Git Bash** [<img src="https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/.img/external-link.png" alt="External Link" title="Abrir en una nueva pestaña" width="18" heigth="18">](https://git-scm.com/install/windows) para el cliente de Windows.

Las herramientas base para compilar el programa, obviando la anterior mencionada, serán:

----
## Windows
Herramienta | Versión | Notas
----|----|----|
Visual Studio Community | 2022 (v. 17), workload "Desarrollo para escritorio con C++" | Necesario para MSVC |
Rust(`rustup-innit.exe`) | toolchain `1.75` | El CI de RustDesk fija esta versión para la app |
LLVM | `15.0.6` | Para `bindgen`/`rust-bindgen` |
Flutter SDK | `3.24.5`(canal stable) | **NO** usar `master`/`beta`, RustDesk depende de una verión exacta |
Python 3 | cualquier versión reciente | Para ejecutar `build.py`. <br>En nuestro caso se utilizó la versión `3.11.9` |
vcpkg | commit fijo | Maneja las librerías nativas (`libvpx`, `opus`, `ffmpeg`, etc.)
----

## MacOs
Herramienta | Versión | Notas
----|----|----|
Xcode| La versión mas reciente, mientras sea esta compatible con el OS | En nuestro caso, se utilizó la versión `15.2` (MacOs Ventura 13.7)|
Rust(`rustup-innit`) | `1.75.0` | El CI de RustDesk fija esta versión |
Git | La más reciente | A diferencia de windows, esto es como librería, sin la terminal integrada de git bash. <br>A la fecha (6/Oct/'26): `2.39.3` |
Homebrew | La más reciente | Para instalar los paquetes requeridos. <br>A la fecha (6/Oct/'26): `6.0.19` |
Python 3 | cualquier versión reciente | Para ejecutar `build.py`. <br>En nuestro caso, `3.14.7`. |
vcpkg | commit fijo | Maneja las librerías necesarias (`libvpx`, `opus`, `libyuv`, `aom`) |
Flutter (Vía FVM *(Flutter Version Manager)*) | Flutter: `3.24.5`.<br>FVM: la más reciente | RustDesk depende de una versión de Flutter específica, y FVM permite el manejo entre diferentes versiones.<br> Versión FVM a la fecha(6/Oct/26): `4.3.0` |
----

* Como herramienta adicional para la creación de las imágenes/íconos, se utilizó <img src="https://imagemagick.org/image/wand.png" height="18" width="18"> **ImageMagick** [<img src="https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/.img/external-link.png" alt="External Link" title="Abrir en una nueva pestaña" width="18" heigth="18">](https://imagemagick.org/download/#gsc.tab=0) e <img src="https://inkscape.app/wp-content/uploads/inkscape-logo.webp" height="18" width="18"> **InkScape** [<img src="https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/.img/external-link.png" alt="External Link" title="Abrir en una nueva pestaña" width="18" heigth="18">](https://inkscape.app/es/descargar/), herramientas de código abierto para modificar imágenes y creación de gráficos vectoriales.

# Compilar Rustdesk (Sin Modificar)
Aquí abajo estarán los pasos a realizar para Windows y Mac (Linux en proceso)

<p align="center">
    <img src="https://upload.wikimedia.org/wikipedia/commons/8/87/Windows_logo_-_2021.svg?utm_source=es.wikipedia.org&utm_campaign=imageinfo&utm_content=original" alt="Windows Logo" width="100" height="100">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img src="https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/.img/Apple_logo_grey.svg" alt="Apple Logo" width="100" height="120">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img src="https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/.img/Tux.svg" alt="Linux Logo" width="100" height="120" title="Tux, la mascota de Linux, por Larry Ewing, utilizando el programa GIMP."><a href="https://www.home.unix-ag.org/simon/penguin/README" title="Copyright Page of Tux">&copy;</a>
</p>

[^2]

<p align="center">
    <br>[<a href="/docs/ES/COMPILAR_WIN.md">Compilar en Windows (Sin modificaciones)</a>] | [<a href="/docs/ES/COMPILAR_MAC.md">Compilar en MacOS (Sin modificaciones)</a>] | <a href="/docs/ES/COMPILAR_LINUX.md">Compilar en Linux (Sin modificaciones)(WIP)</a>
</p>








[^1]: External-link icon created by Dixit Lakhani_02 - Flaticon
[^2]: Por Larry Ewing (<a rel="nofollow" class="external text" href="mailto:lewing@isc.tamu.edu">lewing@isc.tamu.edu</a>) and <a href="https://en.wikipedia.org/wiki/GIMP" class="extiw" title="w:GIMP">The GIMP</a>, Attribution, <a href="https://commons.wikimedia.org/w/index.php?curid=753970">Enlace</a>
