# Libra UI (Flutter)

Una aplicación Flutter que sirve como interfaz de usuario para el ecosistema de Libra Wallet. Esta aplicación permite a los usuarios interactuar con sus cuentas de Libra Wallet, ver el historial de transacciones y realizar transferencias. Está diseñada para conectarse al [backend de Libra Wallet](https://github.com/FTX-Aseca/libra-wallet/tree/dev).

---

## Funcionalidades

1.  **Gestión de Cuenta**
    *   Registro e inicio de sesión de usuarios.
    *   Visualización del saldo de la cuenta.
    *   Historial de transacciones simplificado (gastos, ingresos).
2.  **Transferencias Peer-to-Peer (P2P)**
    *   Enviar fondos a otros usuarios mediante correo electrónico o ID único.
    *   Ver el estado de la transferencia en el historial.
3.  **Financiación Externa Simulada**
    *   Interfaz de usuario para iniciar operaciones de "recarga", simulando transferencias desde tarjetas o cuentas bancarias.
4.  **Interfaz Minimalista**
    *   Diseño ligero, centrado en las interacciones esenciales del usuario para QA y usabilidad.

---

## Primeros Pasos

Para obtener una copia local y ponerla en funcionamiento, sigue estos sencillos pasos.

### Prerrequisitos

*   Flutter SDK: [Guía de Instalación](https://flutter.dev/docs/get-started/install)
*   Dart SDK: Viene incluido con Flutter
*   Un IDE como Android Studio o VS Code con los plugins de Flutter.

### Instalación y Configuración

1.  Clona el repositorio:
    ```sh
    git clone [URL_DE_TU_REPOSITORIO]
    cd libra_ui
    ```
2.  Instala los paquetes de Flutter:
    ```sh
    flutter pub get
    ```
3.  Asegúrate de que el [backend de Libra Wallet](https://github.com/FTX-Aseca/libra-wallet/tree/dev) esté en ejecución y accesible. Configura la URL del backend en los ajustes de entorno de la aplicación Flutter según sea necesario.

---

## Ejecutando la Aplicación

*   **Modo de Desarrollo:**
    ```sh
    flutter run
    ```
    Selecciona tu dispositivo de destino (emulador o dispositivo físico) cuando se te solicite.

*   **Compilar Release (Android):**
    ```sh
    flutter build apk --release
    ```

*   **Compilar Release (iOS):**
    ```sh
    flutter build ios --release
    ```

---

## Ejecutando Pruebas

*   **Ejecutar todas las pruebas:**
    ```sh
    flutter test
    ```
*   **Ejecutar pruebas con cobertura:**
    ```sh
    flutter test --coverage
    ```
    (Para ver el informe de cobertura HTML: `genhtml coverage/lcov.info -o coverage/html`)

---

## Notas de QA y Pruebas

*   Esta UI está pensada para ser probada junto con el [backend de Libra Wallet](https://github.com/FTX-Aseca/libra-wallet/).
*   Consulta el roadmap de QA y la documentación del backend para escenarios de pruebas integradas.

---

## CI/CD y Versionado

*   **Versionado:** SemVer
*   **Pipelines CI/CD:** GitHub Actions

---

¡Bienvenido a Libra UI! Para más detalles sobre los servicios de backend, consulta la [documentación del repositorio de Libra Wallet](https://github.com/FTX-Aseca/libra-wallet/).
