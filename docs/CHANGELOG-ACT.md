Este es el Registro de cambios en cuanto al presente cliente (1.5.0). Aquí se estipulan los cambios de la aplicación propia, **no** los de RustDesk.

Este documento es para señalar los cambios adicionales requeridos para el correcto funcionamiento en versiones posteriores a la `1.4.9`. Sólo añade cambios, a menos que se estipule lo contrario.

Para esta versión se han realizado los siguientes cambios:

Versiones específicas:

- RustDesk:
  commit <`fada664df7a294d1d1a9ca3e7cd3637069122f17`> `Universal (Todos los sistemas operativos)`

- hbb_common:
  commit <`229b904508364c8997aad0fb5af57effac859f60`> `Universal`


## WINDOWS

**`src/platform/windows.rs`** <br>
Se añade el símbolo `_` *(Unicode: `(U+005F)`*), para funcionamiento de la actualización desde la versión anterior. 
```rs
fn validate_install_app_name(app_name: &str) -> ResultType<()> {
    if app_name.is_empty()
        || !app_name
            .chars()
            .all(|character| character.is_ascii_alphanumeric() || character == '-' || character == '_')  // Modificado
    {
        bail!("Application name must match [a-zA-Z0-9_-]+");  // Modificado
    }
    Ok(())
}
```



## MacOS (WIP)


