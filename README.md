
# Índice
1. [Información](#información)

2. [Compilar Rustdesk (Sin Modificar)](#compilar-rustdesk-sin-modificar)

3. [Cambios al Código Original](#cambios-al-código-original)

    - 3.1 [Cambios Generales](#cambios-generales)
  
         - 3.1.1 [Cambios Originales](#cambios-originales)

    - 3.2 [Aplicar cambios en Windows](#aplicar-cambios-en-windows)

    - 3.3 [Cambios aplicados](#cambios-aplicados)
    
    - 3.4 [Aplicar cambios en MacOS](#aplicar-cambios-en-macos)

    - 3.5 [Cambios aplicados](#cambios-aplicados-1)

# Información
# Soporte-Cliente-TIC
Cliente Modificado de Rustdesk para solicitud de soporte remoto 

Este proyecto toma a **RustDesk** [<img src="https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/.img/external-link.png" alt="External Link" title="Abrir en una nueva pestaña" width="18" heigth="18">](https://github.com/rustdesk/rustdesk) [^1] (1.4.9) como base, añadiendo funcionalidades para el preste de servicios de soporte remoto. 

- Términos de Uso [<img src="https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/.img/external-link.png" alt="External Link" title="Abrir en una nueva pestaña" width="18" heigth="18">](https://ticonsultores.cl/terms.html)
- Términos de Privacidad [<img src="https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/.img/external-link.png" alt="External Link" title="Abrir en una nueva pestaña" width="18" heigth="18">](https://ticonsultores.cl/privacy.html)

<br>Versiones Específicas:<br>

- RustDesk: <br> commit <`6c578292e8ebbbec708b76986ba8c4bc7c509747`> `Windows`<br> commit <`91c9fccbb0f7bfe5f11644d5fbdec9b23fa10540`> `MacOS` 

(Win)
```bash
6c578292e (HEAD, tag: 1.4.9) bump to 1.4.9
1.4.9-0-g6c578292e
``` 
(Mac)
```bash
91c9fccbb (HEAD -> master, origin/master, origin/HEAD) chore(deps): security bumps in Cargo.lock (RUSTSEC-2026 fixes) (#16143)
nightly-177-g91c9fccbb
```

- hbb_common: <br> commit <`69cea8dafee147848ae88702029f4bf7df7224c3`> `Windows` <br> commit <`29cf7cbe4d38ce36020749f713fb066299f02431`> `MacOs`

(Win)
```bash
libs/hbb_common (driver-310-g69cea8d)
```
(Mac)
```bash
libs/hbb_common (driver-390-g29cf7cb)
```

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
    <br>
    [<a href="/docs/ES/COMPILAR_WIN.md">Compilar en Windows (Sin modificaciones)</a>] | [<a href="/docs/ES/COMPILAR_MAC.md">Compilar en MacOS (Sin modificaciones)</a>] | [<a href="/docs/ES/COMPILAR_LINUX.md">Compilar en Linux (Sin modificaciones)(WIP)</a>] *
    <br>
    <i font-size:"10">*Estos documentos redirigen al repositorio del cliente para administrador</i>
</p>

# Cambios al código original

A partir de aquí se asume el directorio principal, o 'base', aquel donde se descargue RustDesk, por defecto 'C/rustdesk/'.

## Cambios generales

Cambios que van en todas las versiones (Act. Win & Mac)

**`/src/lang/es.rs`** <br>
Se corrige un error de traducción
```rust
("Untagged", "Sin etiquetar"), // El código original contiene "itiquetar"
```

**`/flutter/lib/desktop/pages/desktop_home_page.dart`**
```dart
// Añadir imports
import 'support_request.dart';

// (...)

class _DesktopHomePageState extends State<DesktopHomePage>

    // (...)
    @override
    Widget build(BuildContext context) {
        super.build(context);
        final isIncomingOnly = bind.isIncomingOnly();
        return _buildBlock(
            child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            buildLeftPane(context),
            if (!isIncomingOnly) const VerticalDivider(width: 1),
        if (!isIncomingOnly) Expanded(child: CompanyPane()), // <-- NEW
        ],
        ));
    }

    // (...)

    Widget buildLeftPane(BuildContext context) {
        
        // (...)
        
        return ChangeNotifierProvider.value(
            value: gFFI.serverModel,
            child: Container(
                width: isIncomingOnly ? 490.0 : 190.0,          // Modificado
                color: Theme.of(context).colorScheme.background,
                child: Stack(
                children: [
                    Column(
                    children: [
                        SingleChildScrollView(
                        controller: _leftPaneScrollController,
                        child: Column(
                            key: _childKey,
                            children: children,
                        ),
                        ),
                        //Expanded(child: Container())          // Comentado
                    ],
                    ),

    // (...)
    buildIDBoard(BuildContext context) {
    final model = gFFI.serverModel;
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 11),
      height: 57,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Container(
            width: 2,
            decoration: const BoxDecoration(color: MyTheme.accent),
          ).marginOnly(top: 5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translate("ID"),
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.color
                                  ?.withOpacity(0.5)),
                        ).marginOnly(top: 5),
                        //buildPopupMenu(context)  // <-- Comentado
                      ],
                    ),
                  ),

    // (...)
     Widget buildHelpCards(String updateUrl) {
    /**if (!bind.isCustomClient() &&                    // Comentado desde aquí
        updateUrl.isNotEmpty &&
        !isCardClosed &&
        bind.mainUriPrefixSync().contains('rustdesk')) {
      final isToUpdate = (isWindows || isMacOS) && bind.mainIsInstalled();
      String btnText = isToUpdate ? 'Update' : 'Download';
      GestureTapCallback onPressed = () async {
        final Uri url = Uri.parse('https://rustdesk.com/download');
        await launchUrl(url);
      };
      if (isToUpdate) {
        onPressed = () {
          handleUpdate(updateUrl);
        };
      }
      return buildInstallCard(
          "Status",
          "${translate("new-version-of-{${bind.mainGetAppNameSync()}}-tip")} (${bind.mainGetNewVersion()}).",
          btnText,
          onPressed,
          closeButton: true,
          help: isToUpdate ? 'Changelog' : null,
          link: isToUpdate
              ? 'https://github.com/rustdesk/rustdesk/releases/tag/${bind.mainGetNewVersion()}'
              : null);
    }**/                                                // Hasta aquí
    if (systemError.isNotEmpty) {
      return buildInstallCard("", systemError, "", () {});
    }

    if (isWindows && !bind.isDisableInstallation()) {
      if (!bind.mainIsInstalled()) {
        return buildInstallCard(
            "", "" , "Install",                         // Modificado
            () async {
          await rustDeskWinManager.closeAllSubWindows();
          bind.mainGotoInstall();
        });
      } else if (bind.mainIsInstalledLowerVersion()) {
        return buildInstallCard(
            "", "", "Click to upgrade",                 // Modificado
            () async {
          await rustDeskWinManager.closeAllSubWindows();
          bind.mainUpdateMe();
        });
      }

```

**`/flutter/lib/common.dart`** [^3]
```dart
    // (...)
    // ~ Ln. 2984
    /// from local options
  ServerConfig.fromOptions(Map<String, dynamic> options)
      : idServer = options['<IP_SERVIDOR>'] ?? '',
        relayServer = options['<IP_SERVIDOR>'] ?? '',
        apiServer = options['https://<IP_SERVIDOR>'] ?? '',
        key = options['<KEY_SERVIDOR>'] ?? '';


    // (...)
    // should set one by one
    await bind.mainSetOption(
        key: 'custom-rendezvous-server', value: '<IP_SERVIDOR>');
    await bind.mainSetOption(key: 'relay-server', value: '<IP_SERVIDOR>');
    await bind.mainSetOption(key: 'api-server', value: 'htps://<IP_SERVIDOR>');
    await bind.mainSetOption(key: 'key', value: '<KEY_SERVIDOR>');
```



**`/libs/hbb_common/src/config.rs`**
```rs
// ~ Ln. 72
lazy_static::lazy_static! {
    // (...)
    pub static ref APP_NAME: RwLock<String> = RwLock::new("<NombreDeApp>".to_owned());
```

**`/src/common.rs`**
```rs


    pub fn set_hardcoded_preset_password() {
    let preset_password = "<CUSTOM_PASSWORD>";
    let preset_salt = "<CUSTOM_SALT>";
    let h1 = hbb_common::config::compute_permanent_password_h1(preset_password, preset_salt);
    let storage = "00".to_owned() + &hbb_common::base64::encode(h1);

    config::HARD_SETTINGS.write().unwrap()
        .insert("password".to_owned(), storage);
    config::HARD_SETTINGS.write().unwrap()
        .insert("salt".to_owned(), preset_salt.to_owned());
    config::BUILTIN_SETTINGS.write().unwrap()
        .insert(
            config::keys::OPTION_DISABLE_CHANGE_PERMANENT_PASSWORD.to_owned(),
            "Y".to_owned(),
        );
    config::Config::set_permanent_password("");
}
```

**`/src/core_main.rs`**
```rs
#[cfg(not(any(target_os = "android", target_os = "ios")))]
pub fn core_main() -> Option<Vec<String>> {
    if !crate::common::global_init() {
        return None;
    }
    crate::load_custom_client();
    crate::set_hardcoded_preset_password();         // Nuevo
```


**`src/flutter_ffi.rs`**
```rs
// ~ Ln. 52, dentro de la siguiente función:
fn initialize(app_dir: &str, custom_client_config: &str){
    // (...)
    if custom_client_config.is_empty() {
        crate::load_custom_client();
    } else {
        crate::read_custom_client(custom_client_config);
    }
    crate::set_hardcoded_preset_password();                    // Nuevo desde aquí
    config::HARD_SETTINGS
        .write()
        .unwrap()
        .insert("allow-remote-config-modification".to_owned(), "Y".to_owned()); // Hasta aquí
```

### Cambios Originales (WIP)
----



## Aplicar Cambios en Windows
### Cambios aplicados 

En esta sección se especifican los cambios realizados para el cliente RustDesk que se hicieron en Windows con efecto de personalizar y/o adaptar el software RustDesk a necesidades específicas.

Para los íconos, véase en el Readme de la versión de Administrador [<img src="https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/.img/external-link.png" alt="External Link" title="Abrir en una nueva pestaña" width="18" heigth="18">](https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/README.md#aplicar-cambios-en-windows)

**`build.py`**
```py
def build_flutter_windows(version, features, skip_portable_pack):
    # (...)
    # ~ Ln. 456
    system2(
        f'python3 ./generate.py -f ../../{flutter_build_dir_2} -o . -e ../../{flutter_build_dir_2}/Soporte_Remoto.exe')
    # (...)
    os.rename('./rustdesk_portable.exe', f'./Soporte_Remoto-{version}-install.exe')
    print(
        f'output location: {os.path.abspath(os.curdir)}/Soporte_Remoto-{version}-install.exe')
```


**`Cargo.toml`**
```toml
[package]
name = "rustdesk"
version = "1.4.9"
authors = ["rustdesk <info@rustdesk.com> TiConsultores <soporte@ticonsultores.cl>"] # Modificado
edition = "2021"
build= "build.rs"
description = "Soporte Remoto TiConsultores"    # Modificado
default-run = "rustdesk"
rust-version = "1.75"
#(...)
[package.metadata.winres]
LegalCopyright = "Copyright © 2026 Purslane Tech Pte. Ltd. Modifications by TiConsultores SpA. All rights reserved."
ProductName = "Soporte_Remoto"
FileDescription = "Soporte Remoto TiConsultores"
OriginalFilename = "soporte_remoto.exe"
```

**`/flutter/windows/runner/main.cpp`**
```cpp
// ~ Ln. 66
  std::wstring app_name = L"<NombreDeApp>";
```

**`/flutter/windows/runner/Runner.rc`**
```rc
// ~ Ln. 92 - 98
        BEGIN
            VALUE "CompanyName", "Purslane Tech Pte. Ltd. TiConsultores SpA." "\0"
            VALUE "FileDescription", "Soporte Remoto" "\0" 
            VALUE "FileVersion", VERSION_AS_STRING "\0"
            VALUE "InternalName", "Nombre-de-App" "\0"
            VALUE "LegalCopyright", "Copyright © 2026 Purslane Tech Pte. Ltd. Modifications by TiConsultores SpA. All rights reserved." "\0"
            VALUE "OriginalFilename", "Nombre-de-App.exe" "\0"
            VALUE "ProductName", "Nombre-de-App" "\0"
            VALUE "ProductVersion", VERSION_AS_STRING "\0"
        END
```

**`/flutter/windows/CMakeLists.txt`**
```txt
# ~ Ln. 7
set(BINARY_NAME "Nombre-de-App")
```

**`/libs/portable/Cargo.toml`** 
```toml
[package.metadata.winres]
LegalCopyright = "<CopyrightDeApp>" # Esto es para efecto de clientes personalizados
ProductName = "Nombre-de-App"
OriginalFilename = "Nombre-de-App.exe"
FileDescription = "NombreDeApp"
```

**`/libs/portable/generate.py`**
```py

# ~ Ln. 100
    if not options.executable:
        options.executable = 'Nombre-de-App.exe'
```

**`/src/platform/windows.rs`** <br>
Correlación entre el nombre de la app y el nombre de las funciones.
```rs
// ~ Ln. 1992 - 1993
#[inline]
pub fn get_custom_client_staging_dir() -> PathBuf {
    get_public_base_dir()
        .join("NombreDeApp")
        .join("NombreDeAppCustomClientStaging")
}
// (...)
// ~ Ln. 3750
                if file_name.starts_with("Nombre-de-")  // El comienzo del nombre de la app, no es necesario el nombre completo para distinguirlo de otros archivos.
                    && (file_name.ends_with(".msi") || file_name.ends_with(".exe"))
                {
// (...)
// ~ Ln. 3816
     let caption = "Nombre de App Output"
```


## Aplicar Cambios en MacOS
### Cambios aplicados

Los cambios aquí presentes son los que han sido aplicados con efecto de personalizar y/o adaptar el software RustDesk a necesidades específicas.

Para los íconos, véase en el Readme de la versión de Administrador [<img src="https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/.img/external-link.png" alt="External Link" title="Abrir en una nueva pestaña" width="18" heigth="18">](https://github.com/bryanmoraga-ticonsultores/Soporte-Admin-TIC/blob/main/README.md#aplicar-cambios-en-macos)

**`/flutter/macos/Runner/Configs/AppInfo.xcconfig`**
```
PRODUCT_NAME = <NombreDeApp>
PRODUCT_BUNDLE_IDENTIFIER = <tu.identificador.unico>
PRODUCT_COPYRIGHT = Copyright © 2026 Purslane Tech Pte. Ltd. Modifications by TiConsultores SpA. All rights reserved.
```
> `<NombreDeApp>` no debe contener espacios, sólo caracteres alfanuméricos y guiones(`_`, `-`)

**`/flutter/macos/Runner.xcodeproj/project.pbxproj`** — hay 3 ocurrencias hardcodeadas que sobreescriben al `.xcconfig` si no se cambian.
<br>Con esto cambia esas 3 ocurrencias del archivo:
```bash
sed -i '' 's/PRODUCT_BUNDLE_IDENTIFIER = com.carriez.rustdesk;/PRODUCT_BUNDLE_IDENTIFIER = <tu.identificador.unico>;/g' flutter/macos/Runner.xcodeproj/project.pbxproj
```

**`build.py`** Se agrega una función para obtener el nombre de la aplicación de forma dinámica.
```python
def get_mac_app_name():
    xcconfig_path = 'flutter/macos/Runner/Configs/AppInfo.xcconfig'
    with open(xcconfig_path, 'r') as f:
        for line in f:
            line = line.strip()
            if line.startswith('PRODUCT_NAME'):
                name = line.split('=', 1)[1].strip()
                return f'{name}.app'
    raise Exception('No se encontró PRODUCT_NAME en AppInfo.xcconfig')
```
y se llama a esta función aquí:<br>
(fragmento)
```python
def build_flutter_dmg(version, features):
    ...

    app_name = get_mac_app_name() # ← Aquí

    os.chdir('flutter')
    
    mac_arch = 'arm64' if platform.machine().lower() in ('arm64', 'aarch64') else 'x86_64'
    system2(
        f'FLUTTER_XCODE_ARCHS={mac_arch} FLUTTER_XCODE_ONLY_ACTIVE_ARCH=YES flutter build macos --release')
        # Para usarse aquí ↓
    system2(f'cp -rf ../target/release/service "./build/macos/Build/Products/Release/{app_name}/Contents/MacOS/"') 
    ...
```

[^1]: External-link icon created by Dixit Lakhani_02 - Flaticon
[^2]: Por Larry Ewing (<a rel="nofollow" class="external text" href="mailto:lewing@isc.tamu.edu">lewing@isc.tamu.edu</a>) and <a href="https://en.wikipedia.org/wiki/GIMP" class="extiw" title="w:GIMP">The GIMP</a>, Attribution, <a href="https://commons.wikimedia.org/w/index.php?curid=753970">Enlace</a>
[^3]: Utilizo el símbolo '\~' para decir 'Alrededor'. E.g.: "\~ Ln. 84" sería: "Alrededor de la línea 84".
