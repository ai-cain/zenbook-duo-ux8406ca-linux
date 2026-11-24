# Zenbook Duo UX8406CA: setup bonito (Hyprland + Gentleman + Zen)

Complemento de `guia-zenbook-ux8406ca.md` (hardware, instalación y workarounds). Aquí va la parte visual y de uso: escritorio, terminal, navegador, lápiz, teclado y dos pantallas.

> Todo viene de lo que encontré en README y páginas públicas. No está probado en esta laptop.

---

## 1. Stack elegido

| Capa | Elección | Notas |
|---|---|---|
| Base | [Omarchy](https://omarchy.org) (Arch + Hyprland) | Es lo que probaron los repos del Duo. Si se prefiere Arch plano, hay que adaptar los scripts |
| Escritorio | [Hyprland](https://hypr.land) + [Waybar](https://github.com/Alexays/Waybar) + [rofi](https://github.com/davatorium/rofi) + [hyprlock](https://github.com/hyprwm/hyprlock) | Un rice con animaciones, blur y bordes redondeados. **Ojo**: Omarchy 4 parece traer su propia barra y shell (Quickshell, con plugins), no Waybar. No verificado: ver sección 10 |
| Colores | [matugen](https://github.com/InioX/matugen) | Paleta generada desde el wallpaper |
| Terminal | [Ghostty](https://ghostty.org) o [kitty](https://sw.kovidgoyal.net/kitty/) | Ver sección 3 |
| Entorno de terminal | [Gentleman.Dots](https://github.com/Gentleman-Programming/Gentleman.Dots) | Neovim y shell. Sin su tmux/Zellij. Ver sección 4 |
| Multiplexor / agentes | [herdr](https://herdr.dev) | Único multiplexor. Dentro de kitty. Ver sección 4 |
| Cámara, Steam, oficina | Snapshot, Steam, LibreOffice/ONLYOFFICE | Ver sección 4b |
| Navegador | [Zen Browser](https://zen-browser.app) | Ver sección 2 |
| Editor | [Neovim](https://neovim.io) | Sin VS Code |
| Lápiz | [Xournal++](https://github.com/xournalpp/xournalpp), [Rnote](https://github.com/flxzt/rnote), [Krita](https://krita.org) | Ver sección 6 |

---

## 2. Navegador

El pedido: elegante estilo Mac, sin telemetría y open source.

| Opción | Pros | Contras | Costo |
|---|---|---|---|
| [Helium](https://helium.computer) (alternativa) | Open source (GPL-3.0), basado en ungoogled-chromium, sin servicios de Google ni telemetría, interfaz mínima, uBlock Origin integrado. AUR: `helium-browser-bin` | Está en beta. Sin sincronización entre dispositivos. Es Chromium por dentro. En Linux las actualizaciones van por el gestor de paquetes. Revisar el PKGBUILD y la firma PGP | Gratis |
| [GNOME Web (Epiphany)](https://apps.gnome.org/Epiphany/) | Minimal y elegante, motor WebKit, estilo Safari | Tiene pocas funciones y menos extensiones | Gratis |
| [Zen Browser](https://zen-browser.app) (**elegido**) | Open source (MPL-2.0), basado en Firefox, menos telemetría que Firefox | Estilo parecido a Arc. Hereda telemetría de Firefox y desactiva la mayor parte por defecto. Algunos usuarios dicen que aún recopila datos | Gratis |
| [LibreWolf](https://librewolf.net) + [pywalfox](https://github.com/Frewacom/pywalfox) | Enfocado en privacidad. Pywalfox sincroniza los colores con la paleta del wallpaper | Menos "Mac": no trae pestañas verticales de fábrica | Gratis |
| [Vivaldi](https://vivaldi.com) | Muy configurable, pestañas verticales | No es 100% open source. Colores sin sincronizar con matugen | Gratis |
| [Brave](https://brave.com) | Basado en Chromium, bloquea anuncios | Normalmente por AUR. Colores sin sincronizar con matugen | Gratis |

- Zen se instala por AUR (nombre típico `zen-browser-bin`) o por Flatpak en Flathub. Verificar el nombre con `yay -Ss zen-browser`.
- Si se instala algo por AUR, revisar el `PKGBUILD` antes: el AUR ha tenido paquetes maliciosos.
- Si se quiere el mínimo de telemetría posible, LibreWolf es la opción más segura.

---

## 3. Terminal elegante

| Opción | Pros | Contras | Costo |
|---|---|---|---|
| [Ghostty](https://ghostty.org) | Moderno, nativo en Wayland, con tabs, splits y temas integrados. Licencia MIT. Soporta el protocolo gráfico de kitty | Proyecto joven | Gratis |
| [kitty](https://sw.kovidgoyal.net/kitty/) | Lo usaba el rice de referencia. Protocolo gráfico propio, kittens, plantilla de matugen disponible | Configuración más voluminosa | Gratis |
| [WezTerm](https://wezterm.org) | Configurable en Lua, multiplexer propio | Su última versión estable etiquetada es de febrero de 2024; los mantenedores recomiendan builds nocturnos | Gratis |
| [Alacritty](https://alacritty.org) | Minimalista y rápido | Sin tabs ni splits (pensado para usar con tmux) | Gratis |

Para el fetch con imagen y el gato del rice de referencia hace falta un terminal con protocolo gráfico (kitty o Ghostty).

---

## 4. Gentleman.Dots (entorno de terminal)

- Repo: [Gentleman-Programming/Gentleman.Dots](https://github.com/Gentleman-Programming/Gentleman.Dots).
- Es una colección de dotfiles para el entorno de desarrollo, con soporte para Arch. Incluye Neovim con LSP y Tree-sitter, Ghostty, Tmux y Zellij, y asistentes de IA dentro de Neovim.
- Instalación según la documentación (revisar el script antes de ejecutarlo):

```bash
curl -O https://raw.githubusercontent.com/Gentleman-Programming/Gentleman.Dots/refs/heads/main/install-linux-mac.sh
less install-linux-mac.sh          # leer antes de correr
sudo chmod +x install-linux-mac.sh
```

- **Avisos**:
  - Es una configuración opinionada de terminal. No es un rice de escritorio: Hyprland, Waybar, wallpaper y fetch siguen siendo aparte.
  - Puede pisar configs existentes de Neovim, Ghostty y shell (y Omarchy trae las suyas). Respaldar `~/.config` antes.
  - Tiene su propio esquema de colores: decidir si se usa ese o el de matugen.
  - Opción más segura: no correr el instalador completo, sino copiar solo las piezas que se quieran (Neovim, Zellij, Ghostty).
  - El material que leí de instalación es una documentación de terceros: confirmar los pasos en el repo oficial.

### Organizador de terminal: herdr (decidido)

La herramienta del amigo es probablemente **herdr** (por el nombre "h" y por lo que hace). Es un multiplexor de terminal hecho para agentes de IA.

- Sitio: [herdr.dev](https://herdr.dev). Repo: [ogulcancelik/herdr](https://github.com/ogulcancelik/herdr). Hay muchos forks con el mismo nombre: usar el oficial.
- Instalación en Arch: seguir la sección "install" de su sitio (no verifiqué si está en el AUR). Revisar la licencia (un README menciona AGPL con licencia comercial opcional).
- **No reemplaza a kitty/Ghostty**: corre dentro de la terminal. La terminal sigue siendo la ventana.
- **Decisión: no usar tmux ni Zellij.** herdr es el único multiplexor. Gentleman.Dots se usa por Neovim y shell; ignorar su multiplexor. Confirmar en el instalador si deja tmux/Zellij como obligatorio (no verifiqué).

| Función de herdr | Para qué |
|---|---|
| Spaces | Uno por proyecto, con cambio desde la barra lateral |
| Paneles en mosaico y tabs, con mouse | Neovim, agente y shell lado a lado |
| Lista de agentes con estado | Trabajando, bloqueado o terminado, de un vistazo |
| Sesiones persistentes | Cerrar la terminal no mata los agentes. Reconectar desde otra terminal o por SSH |
| Integraciones | `herdr integration install claude` (también codex, pi, opencode) |
| CLI y socket API | `herdr pane split-right`, `herdr agent read`, `herdr pane close`. Un agente puede abrir paneles y leer otros |
| Remoto | `herdr --remote ssh://usuario@servidor:2222` (útil para el homelab) |

Detecta agentes **de terminal** (Claude Code, Codex, opencode, pi, Amp, Droid). Los chats del navegador no aparecen. Los atajos de teclado no los verifiqué: mirar su documentación.

**Flujo diario**: abrir kitty → `herdr` → un Space por proyecto → paneles con Neovim, agente y shell.

**Alternativas** si herdr no convence: [Claude Squad](https://github.com/smtg-ai/claude-squad) (tmux + git worktrees, AGPL-3.0), [agent-deck](https://github.com/asheshgoplani/agent-deck), [dmux](https://dmux.ai) (incluye explorador de archivos). Todas dependen de tmux, así que contradicen la decisión de no usarlo.

### Chat normal con imágenes

Sin Claude Code ni terminal: abrir [claude.ai](https://claude.ai) en Zen y pegar imágenes con Ctrl+V. No vi un cliente de escritorio oficial para Linux.

---

## 4b. Cámara, Steam y archivos de oficina

### Cámara (decidido: simple)

[Snapshot](https://apps.gnome.org/Snapshot/): minimalista, ligera. Sin Webcamoid ni OBS salvo que haga falta.

```bash
sudo pacman -S --needed snapshot
```

### Steam

Requiere el repositorio `multilib` activo en `/etc/pacman.conf` (descomentar `[multilib]` y su `Include`).

```bash
sudo pacman -Syu
sudo pacman -S --needed steam vulkan-intel lib32-vulkan-intel
```

La gráfica es Intel integrada: sirve para juegos livianos, no para AAA.

### Lector de PDF

| Opción | Pros | Contras | Costo |
|---|---|---|---|
| [Zathura](https://pwmt.org/projects/zathura/) (+ `zathura-pdf-mupdf`) | Minimalista, se maneja con teclado estilo vim, encaja con el rice | Casi sin anotaciones. El plugin de PDF va aparte | Gratis |
| [Sioyek](https://sioyek.info) | Pensado para papers: saltos a referencias, marcadores, resaltado, teclado | Interfaz más técnica | Gratis |
| [Okular](https://okular.kde.org) | Anotaciones completas, útil con el lápiz | Es una app Qt de KDE, más pesada | Gratis |
| [Xournal++](https://github.com/xournalpp/xournalpp) | Anotar PDF a mano con el lápiz | No es un lector rápido | Gratis |

Sugerencia: Zathura o Sioyek para leer (tesis, papers), Okular o Xournal++ cuando haya que anotar. Verificar nombres de paquetes con `pacman -Ss`.

### Word, Excel y PowerPoint (leer y editar)

| Opción | Pros | Contras | Costo |
|---|---|---|---|
| [LibreOffice](https://www.libreoffice.org) | Abre .docx, .xlsx y .pptx. Gratis y open source | Puede variar el formato en documentos complejos (fuentes, animaciones, macros) | Gratis |
| [ONLYOFFICE](https://www.onlyoffice.com/desktop.aspx) | Mayor fidelidad con formatos de Microsoft, interfaz parecida a Office | Núcleo open source, pero algunas funciones son del producto comercial | Gratis (escritorio) |

```bash
sudo pacman -S --needed libreoffice-fresh
```

Para mejor fidelidad, instalar fuentes compatibles (`ttf-liberation`, `ttf-carlito`, `ttf-caladea`). Si un archivo se ve distinto, abrirlo también con ONLYOFFICE. Los archivos que genere una IA en .docx/.pptx/.xlsx se abren con cualquiera de los dos.

---

## 5. Dos pantallas apiladas

- Con dos paneles de 1920×1200, el lienzo vertical es de 1920×2400.
- Arriba (`eDP-1`): terminal, Neovim, navegador. Abajo (`eDP-2`): cava, rmpc, reloj, logs.
- Waybar y reglas de Hyprland por monitor (revisar la wiki para los nombres exactos).

### Wallpaper continuo entre las dos

```bash
magick tall.png -crop 1920x1200 +repage part-%d.png   # part-0 arriba, part-1 abajo
```

Luego asignar cada parte a su monitor con [hyprpaper](https://github.com/hyprwm/hyprpaper) (la sintaxis cambia entre versiones).

### Wallpaper animado

```bash
ffmpeg -i tall.mp4 -vf crop=1920:1200:0:0    top.mp4
ffmpeg -i tall.mp4 -vf crop=1920:1200:0:1200 bottom.mp4
mpvpaper -o "loop no-audio" eDP-1 top.mp4
mpvpaper -o "loop no-audio" eDP-2 bottom.mp4
```

- [mpvpaper](https://github.com/GhostNaN/mpvpaper): las dos instancias pueden desincronizarse (sin probar).
- Hay una bisagra entre pantallas: el arte nunca queda perfectamente continuo.

### Cuidado con los OLED

- Una barra, un reloj y bordes fijos todo el día pueden dejar retención de imagen. Tema oscuro, apagado de pantalla corto y barra oculta cuando no se usa.
- Un video de fondo gasta más batería: usarlo enchufado y dejar uno estático con batería.

---

## 6. Lápiz, táctil y teclado

| Función | Estado (según hemagome, Linux 7.2.8, Hyprland 0.56.2) |
|---|---|
| Táctil y lápiz en ambos paneles | Funciona upstream (dos dispositivos táctiles y dos de lápiz detectados) |
| Presión, inclinación y borrador del lápiz | **No documentado**: medir con `libinput debug-events` y Krita |
| Mapeo táctil tras cambios de layout | Parcial, sin validar |
| Teclado Bluetooth desmontable | Funciona (emparejar y confiar con BlueZ) |
| Capa Fn, `Fn+Esc`, backlight (F4), brillo (F5–F6), mute de micro (F9), emoji (F11) | Con workaround (`./install.sh --fn-mode`, requiere sudo) |
| Apagar la pantalla inferior al acoplar el teclado | Con workaround (`./install.sh --keyboard-dock`) |
| Parlantes | Bug reproducido: timeout de los amplificadores CS35L41 |

```bash
sudo pacman -S --needed libinput evtest
sudo libinput debug-events --show-keycodes
```

### Apps para el lápiz

```bash
sudo pacman -S --needed xournalpp krita okular inkscape
pacman -Ss rnote
```

### Teclado en pantalla

Para Hyprland existe [wvkbd](https://github.com/jjsullivan5196/wvkbd) (teclado virtual para Wayland). No lo probé ni sé si funciona bien con el táctil del Duo: verificar.

---

## 6b. Sacarle provecho al hardware: cámara, micrófono, parlantes, lápiz y teclado

Estado según hemagome (UX8406CA, Linux 7.2.8, Hyprland 0.56.2): Wi-Fi, Bluetooth, micrófono y webcam funcionan upstream. Los parlantes tienen un bug reproducido.

| Hardware | Estado | Herramientas |
|---|---|---|
| Cámara FHD | Funciona upstream | [Snapshot](https://apps.gnome.org/Snapshot/) (minimalista), [Webcamoid](https://webcamoid.github.io) (efectos), [OBS Studio](https://obsproject.com) (streaming y grabación), [Cheese](https://wiki.gnome.org/Apps/Cheese) |
| Cámara IR (Windows Hello) | No verificado en este modelo | `howdy-next` + `linux-enable-ir-emitter` (los usa el paquete zenbook-duo-hyprland para face unlock). Editan PAM: respaldar antes |
| Micrófono (array integrado) | Funciona. Mute con F9 vía workaround de hemagome | [EasyEffects](https://github.com/wwmm/easyeffects) para supresión de ruido. El beamforming no se examinó en ningún repo |
| Micrófono del jack TRRS | No da entrada (prueba de cceelen en Fedora) | Usar audífonos Bluetooth con micrófono propio |
| Parlantes | **Bug**: timeout de amplificadores CS35L41 | Si fallan, audífonos Bluetooth. Ecualizar con EasyEffects solo si suenan |
| Lápiz | Táctil y lápiz funcionan upstream. Presión sin documentar | Xournal++, Rnote, Krita. Probar con `libinput debug-events` |
| Teclado | BT funciona. Fn, backlight, mute y dock con workarounds | `./install.sh --fn-mode` y `--keyboard-dock` del repo de hemagome |

Un modo de trabajo que aprovecha todo: teclado Bluetooth desmontado, pantallas apiladas con el soporte plegable, lápiz sobre la pantalla inferior, y audífonos Bluetooth hasta que los parlantes se arreglen.

---

## 7. Orden de trabajo

1. Terminar el hardware con `guia-zenbook-ux8406ca.md` (instalar Omarchy, workarounds de hemagome, pruebas de audio, táctil y lápiz).
2. Instalar terminal (Ghostty o kitty) y navegador (Zen o LibreWolf).
3. Decidir si se usa Gentleman.Dots completo, solo sus piezas, o la config propia de Neovim.
4. Rice: wallpaper, matugen, Waybar por monitor, hyprlock.
5. Probar el lápiz y el audio; repetir pruebas después de cada actualización de kernel, Hyprland o BlueZ.

---

## 8. Trabajo: IoT y visión por computador

Nota de hardware: la Zenbook tiene gráfica Intel integrada, **sin CUDA**. Entrenar o correr TensorRT va en la Jetson o en el servidor; aquí se desarrolla, se prueba y se hace inferencia ligera (OpenVINO). Verificar cada nombre de paquete con `pacman -Ss` o `yay -Ss` antes de instalar.

### MQTT

| Herramienta | Qué hace | Pros | Contras | Costo |
|---|---|---|---|---|
| [mosquitto](https://mosquitto.org) (`mosquitto` en pacman) | Broker y clientes `mosquitto_sub` / `mosquitto_pub` | Estándar, sirve para probar en 1 línea | Solo CLI | Gratis |
| [MQTTX](https://mqttx.app) (`mqttx-bin` en AUR) | GUI de EMQ: conexiones y credenciales guardadas, suscripción a topics, publicar, MQTT 5.0 | Open source, mantenido (1.13.3), interfaz cómoda | Es Electron, pesada | Gratis |
| [mqttui](https://github.com/EdJoPaTo/mqttui) | TUI: árbol de topics, ver y publicar, corre dentro de herdr | Encaja con el flujo de terminal | Menos pulido para payloads binarios grandes. No guarda conexiones (se usan variables de entorno) | Gratis |
| [MQTT Explorer](https://mqtt-explorer.com) | GUI con árbol de topics | Cómoda para depurar muchos dispositivos | Es Electron, pesada. En el AUR sin actualizar hace más de 600 días | Gratis |

```bash
mosquitto_sub -h HOST -t '#' -v          # ver todo (con cuidado en producción)
```

### ESP32, serial y firmware

| Herramienta | Para qué | Link |
|---|---|---|
| tio / picocom | Monitor serial en terminal | [tio](https://github.com/tio/tio) |
| esptool | Flashear ESP32 | [esptool](https://github.com/espressif/esptool) |
| PlatformIO | Build y flash desde CLI o Neovim | [platformio.org](https://platformio.org) |
| mpremote | Si algún día usas MicroPython | [docs](https://docs.micropython.org/en/latest/reference/mpremote.html) |

Acceso al puerto serial: agregar tu usuario al grupo `uucp` en Arch (`sudo usermod -aG uucp $USER`) y reiniciar sesión.

### Modbus / RS485 y red

| Herramienta | Para qué | Link |
|---|---|---|
| OpenModScan (`openmodscan` en AUR) | GUI maestro Modbus, reemplazo nativo de Modbus Poll (Windows). TCP y RTU | [OpenModScan](https://github.com/sanny32/OpenModScan) |
| OpenModSim (`openmodsim` en AUR) | GUI esclavo Modbus, reemplazo nativo de Modbus Slave (Windows). TCP y RTU | [OpenModSim](https://github.com/sanny32/OpenModSim) |
| mbpoll | Leer y escribir registros Modbus desde CLI | [mbpoll](https://github.com/epsilonrt/mbpoll) |
| pymodbus | Scripts y simulación de esclavos en Python | [pymodbus](https://github.com/pymodbus-dev/pymodbus) |
| Wireshark / tshark | Capturar tráfico MQTT y Modbus TCP | [wireshark.org](https://www.wireshark.org) |
| nmap | Descubrir equipos en la red | [nmap.org](https://nmap.org) |
| Tailscale | Acceso remoto al homelab y a las Jetson | [tailscale.com](https://tailscale.com) |

### Jetson

| Herramienta | Para qué | Nota |
|---|---|---|
| ssh + herdr remoto | Un Space por Jetson | `herdr --remote ssh://usuario@host` |
| jtop ([jetson-stats](https://github.com/rbonghi/jetson_stats)) | Monitoreo de CPU/GPU/temperatura | Se instala **en la Jetson** |
| SDK Manager de NVIDIA | Flashear JetPack | Está pensado para Ubuntu. En Arch es incierto: usar un contenedor Ubuntu o una VM, o flashear desde otro equipo |

### Visión por computador con Python

| Herramienta | Para qué | Link |
|---|---|---|
| uv | Entornos y dependencias de Python rápidos | [docs.astral.sh/uv](https://docs.astral.sh/uv/) |
| OpenCV | Procesamiento de imagen | [opencv.org](https://opencv.org) |
| OpenVINO | Inferencia acelerada en CPU/GPU Intel de esta laptop | [docs.openvino.ai](https://docs.openvino.ai) |
| v4l-utils (`v4l2-ctl`) | Controles y formatos de cámaras USB | `sudo pacman -S v4l-utils` |
| ffmpeg y mpv | Convertir, recortar y reproducir video | `sudo pacman -S ffmpeg mpv` |
| Rerun | Visualizar imágenes, detecciones y series de tiempo desde Python | [rerun.io](https://rerun.io) |
| Netron | Inspeccionar modelos ONNX | [netron.app](https://netron.app) |
| TensorBoard | Curvas de entrenamiento | [tensorflow.org/tensorboard](https://www.tensorflow.org/tensorboard) |
| ONNX Runtime | Probar modelos exportados sin CUDA | [onnxruntime.ai](https://onnxruntime.ai) |

### OpenVINO en Arch

Sí hay OpenVINO para Linux. Con un Core Ultra puede correr inferencia en CPU, GPU y NPU.

| Camino | Cómo | Pros | Contras | Costo |
|---|---|---|---|---|
| pip (recomendado) | `uv pip install openvino` y verificar con `ov.Core().available_devices` | Lo más simple para Python | Para GPU hacen falta los drivers del sistema aparte | Gratis |
| AUR | [`openvino`](https://aur.archlinux.org/packages/openvino) y `python-openvino` | Integrado con pacman | Upstream no da binarios precompilados: se compila (hay reportes de horas). Los CFLAGS genéricos de makepkg pueden fallar. Revisar el PKGBUILD | Gratis |
| Archivo oficial | Tarball de Intel en `/opt/intel` ([guía](https://docs.openvino.ai/2026/get-started/install-openvino/install-openvino-archive-linux.html)) | Versión oficial, con ejemplos | Los binarios que vi son para Ubuntu: puede dar problemas de dependencias en Arch | Gratis |

- Para la GPU Intel, dependencias opcionales del AUR: `intel-compute-runtime` (plugin GPU) y `level-zero-loader` (plugin NPU).
- **Incierto**: un usuario del AUR reportó que `get_available_devices()` devolvía una lista vacía (sin CPU, GPU ni NPU) con todo instalado. No sé si sigue pasando: probar en el live USB antes de contar con el NPU.

### Contenedores y monitoreo

| Herramienta | Para qué | Link |
|---|---|---|
| Docker o Podman | Replicar entornos de la Jetson y del servidor | [podman.io](https://podman.io) |
| lazydocker | TUI para contenedores | [lazydocker](https://github.com/jesseduffield/lazydocker) |
| btop | Monitor del sistema | `sudo pacman -S btop` |
| nvtop | Muestra uso de GPU Intel | `sudo pacman -S nvtop` |

### Decisiones del flujo de trabajo

| Tema | Decisión | Notas |
|---|---|---|
| MQTT | [MQTTX](https://mqttx.app) (GUI) como principal: guarda conexiones y credenciales | [mqttui](https://github.com/EdJoPaTo/mqttui) como respaldo dentro de herdr. [MQTTX CLI](https://mqttx.app/cli) existe (no verifiqué si trae TUI) |
| Tabby | No hace falta | kitty + `ssh` con `~/.ssh/config`, `herdr --remote` y `tio` para serial. [Tabby](https://tabby.sh) existe para Linux pero es Electron |
| Postman | [Bruno](https://www.usebruno.com) | Open source, colecciones como archivos (aptas para git), sin cuenta. TUI alternativa: [Posting](https://github.com/darrenburns/posting); `curl` para lo rápido |
| Contenedores | Docker | Compatible con servidores y Jetson. Ojo: el grupo `docker` equivale a root. Alternativa: [Podman](https://podman.io) |
| ESP32 | ESP-IDF por CLI (`idf.py build flash monitor`) + `clangd` en Neovim, o PlatformIO CLI | Neovim no usa extensiones de VS Code. La [extensión de Espressif](https://github.com/espressif/vscode-esp-idf-extension) es solo de VS Code. No verifiqué que Gentleman.Dots traiga algo específico para ESP32. Seguir la [guía oficial](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/) de instalación |

### VNC, SSH y serial (con conexiones guardadas)

**Decisión**: [RustConn](https://flathub.org/apps/io.github.totoshko88.RustConn) como principal (instalar por Flathub). Remmina o RealVNC solo si RustConn no se puede instalar o por gusto personal. Reemplaza a Tabby. MQTT queda aparte (RustConn no lo lista): MQTTX o, de respaldo, mqttui.

| Opción | Pros | Contras | Costo |
|---|---|---|---|
| [RustConn](https://flathub.org/apps/io.github.totoshko88.RustConn) | GTK4/libadwaita. SSH (terminal embebido), VNC, RDP, SPICE, Serial, Telnet, Kubernetes y SFTP en una app. Grupos, etiquetas, pestañas y paneles divididos. Importa desde Remmina, SSH config, MobaXterm, Royal TS, CSV y más. Contraseñas vía llavero, KeePassXC, Bitwarden, 1Password o Pass. Sincroniza por directorio compartido (Syncthing, Nextcloud, etc.) | Proyecto joven, con versiones frecuentes. **No verifiqué la exportación** (la página no lista formatos de export; menciona un formato nativo `.rcn`): probar con 2 o 3 conexiones antes de migrar. No hace MQTT. Aspecto subjetivo: ver capturas antes | Gratis |
| [RealVNC Viewer](https://www.realvnc.com/en/connect/download/viewer/) | Tiene versión para Linux. Libreta de direcciones con **File → Export Connections** (permite elegir si exportar contraseñas) e importación. Sincroniza entre equipos si inicias sesión con cuenta | Es software propietario. En Arch suele instalarse por AUR (verificar con `yay -Ss vnc-viewer` y revisar el PKGBUILD) | Viewer gratis |
| [Remmina](https://remmina.org) (`sudo pacman -S remmina libvncserver`) | Open source. VNC, RDP, SSH y SPICE en una sola app. Cada conexión es un archivo `.remmina` en `~/.config/remmina` o `~/.local/share/remmina`, fácil de copiar o versionar en git. Se abre desde CLI: `remmina -c vnc://usuario@host` | Las contraseñas no viajaron al copiar solo los perfiles en un caso reportado (snap). Probar la exportación con contraseñas antes de migrar | Gratis |

Para ver tu propia pantalla desde otro equipo, Hyprland usa un servidor VNC para Wayland ([wayvnc](https://github.com/any1/wayvnc)). No lo probé en el Duo.

### Conexión remota a Windows desde lejos

**Cliente**: [RustConn](https://flathub.org/apps/io.github.totoshko88.RustConn) (RDP con IronRDP, VNC con vnc-rs), [Remmina](https://remmina.org) o [KRDC](https://apps.kde.org/krdc/) (RDP, VNC, SPICE).

**Llegar a la red**

| Opción | Cómo funciona | Pros | Contras | Costo |
|---|---|---|---|---|
| [Tailscale](https://tailscale.com) | Red privada entre equipos; luego RDP o VNC normal contra la IP de Tailscale. RustConn lo lista entre sus túneles Zero Trust | No abre puertos del router ni expone RDP a internet | Hay que instalarlo en cada Windows que se quiera alcanzar | Plan gratuito personal (verificar límites) |
| [RustDesk](https://rustdesk.com) | Funciona sin configuración | Útil si no se puede instalar VPN en la red del destino | Herramienta aparte, no usa las conexiones guardadas | Gratis (revisar su plan) |

- RDP necesita que el Windows de destino lo permita. En Windows Home, que yo sepa, no se puede activar el servidor de RDP (hace falta Pro o superior): verificar en cada equipo.
- Para VNC en Windows hace falta un servidor VNC instalado (RealVNC Server, TightVNC, etc.).
- No exponer RDP ni VNC directo a internet: pasarlo por una VPN.

### Neovim para este trabajo

Con Gentleman.Dots ya viene LSP. Agregar con Mason: `pyright` o `basedpyright`, `ruff`, `clangd` (C/C++), y el LSP de TypeScript para Angular (`angular-language-server`).

### Layout sugerido en herdr

Un Space por proyecto. Ejemplos (los comandos son los de cada herramienta; los atajos de herdr no los verifiqué, ver su documentación):

| Space | Panel 1 | Panel 2 | Panel 3 |
|---|---|---|---|
| Proyecto IoT (ESP32 + MQTT) | `nvim` | `mqttui -b mqtt://HOST` | `idf.py monitor` o `tio /dev/ttyUSB0` |
| Proyecto de visión (Jetson) | `nvim` | `ssh jetson` (con `jtop` dentro) | shell local con `uv run ...` |
| Servidor / homelab | `herdr --remote ssh://usuario@host` | `lazydocker` | `btop` |

Los comandos de herdr para armar esto desde scripts (`herdr pane split-right`, `herdr agent read`, `herdr pane close`) están en su CLI y socket API: ver [herdr.dev](https://herdr.dev).

---

## 9. Otras herramientas del día a día

### GitHub con varias cuentas

Problema típico: git usa una sola identidad global y SSH ofrece la primera clave que encuentra, así que un push da "permission denied".

1. Una clave SSH por cuenta, con alias en `~/.ssh/config`:

```
Host *
  AddKeysToAgent yes

Host github-personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_personal
  IdentitiesOnly yes

Host github-trabajo
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_trabajo
  IdentitiesOnly yes
```

Probar con `ssh -T git@github-personal`. Clonar con el alias: `git clone git@github-trabajo:org/repo.git`.

2. Sin identidad global, con `includeIf` por carpeta (`~/.gitconfig`):

```
[user]
  useConfigOnly = true
[includeIf "gitdir:~/personal/"]
  path = ~/.gitconfig-personal
[includeIf "gitdir:~/trabajo/"]
  path = ~/.gitconfig-trabajo
```

Cada archivo incluido lleva `[user] name` y `email`. Con `useConfigOnly = true` y sin nombre/email globales, git se niega a commitear fuera de esas carpetas.

3. Para no escribir la passphrase a cada rato: ssh-agent (`AddKeysToAgent yes`). En Arch, la unidad de usuario se activa con `systemctl --user enable --now ssh-agent.socket` y se exporta `SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket` (verificar que la unidad exista con `systemctl --user list-unit-files | grep ssh`). Alternativa: KeePassXC con agente SSH.
4. Si sigue dando "permission denied": la clave pública no está en esa cuenta, la organización exige SSO (autorizar la clave para la org) o el repo se clonó con `github.com` en vez del alias (`git remote -v`).
5. Con HTTPS, `gh` usa la cuenta activa: cambiar con `gh auth switch`. SSH con alias es más fiable.

Extras: [`gh`](https://cli.github.com), [lazygit](https://github.com/jesseduffield/lazygit), [gh-dash](https://github.com/dlvhdr/gh-dash).

### Contraseñas (decisión: gratis y con login)

| Opción | Pros | Contras | Costo |
|---|---|---|---|
| [Vaultwarden](https://github.com/dani-garcia/vaultwarden) en el homelab (**elegida**) | Tiene login y sincroniza solo, con las apps y extensiones de Bitwarden. Sin pagar | Yo lo mantengo, actualizo y respaldo | Gratis |
| [KeePassXC](https://keepassxc.org) | 100% local, agente SSH, extensión para Zen | Sin login: sincronizar el `.kdbx` con Syncthing | Gratis |
| [Bitwarden](https://bitwarden.com) (plan gratuito) | Login y sincronización sin servidor propio | Su nube. Verificar límites del plan | Gratis (con planes de pago) |
| [pass](https://www.passwordstore.org) | Solo terminal | Sin interfaz | Gratis |

- Clientes: extensión de Bitwarden en Zen, `bw` (CLI) y la app de escritorio. RustConn soporta Bitwarden y KeePassXC como backend de credenciales.
- Respaldar el servidor y la base de datos de Vaultwarden. Pasarlo por Tailscale, sin exponerlo a internet.
- Móvil con KeePassXC: [KeePassDX](https://www.keepassdx.com) (Android), [KeePassium](https://keepassium.com) (iOS).

### Correo con varias cuentas

| Opción | Pros | Contras | Costo |
|---|---|---|---|
| [aerc](https://aerc-mail.org) | Terminal, varias cuentas, encaja con herdr | Gmail y Outlook con OAuth pueden requerir pasos extra (ver su documentación) | Gratis |
| [Thunderbird](https://www.thunderbird.net) | Varias cuentas y calendario, fácil de configurar | App grande | Gratis |
| Webmail en Zen | Sin instalar nada | Sin cliente aparte | Gratis |

### Otros extras

| Tema | Opción | Link |
|---|---|---|
| Respaldo del sistema | snapper o Timeshift (btrfs) | [snapper](https://github.com/openSUSE/snapper) |
| Dotfiles en git | chezmoi | [chezmoi.io](https://www.chezmoi.io) |
| Capturas | `grim` + `slurp` | [grim](https://sr.ht/~emersion/grim/) |
| Portapapeles | `cliphist` | [cliphist](https://github.com/sentriz/cliphist) |
| Fuentes | Una Nerd Font | [nerdfonts.com](https://www.nerdfonts.com) |
| Batería | `power-profiles-daemon` o TLP | Verificar cuál trae Omarchy |
| Archivos en terminal | yazi | [yazi-rs.github.io](https://yazi-rs.github.io) |

Verificar qué trae ya Omarchy antes de instalar duplicados.

---

## 10. Plugins de Omarchy (catálogo: [plugins.omarchy.org](https://plugins.omarchy.org/))

Omarchy 4 (Quattro) corre dentro de una sola instancia de Quickshell, con barra y plugins propios. La configuración vive en `~/.config/omarchy/shell.json` y los plugins de terceros en `~/.config/omarchy/plugins/<id>/`. Esto reemplaza en la práctica a Waybar (no verificado en el Duo).

```bash
omarchy plugin add https://github.com/USUARIO/REPO.git --enable
omarchy plugin remove ID_DEL_PLUGIN
omarchy plugin list --json
```

**Seguridad**: según una guía sobre plugins, `omarchy plugin add` avisa de que los plugins corren como código arbitrario sin sandbox dentro de omarchy-shell, e instala lo más nuevo de GitHub, no la versión que revisó el catálogo. La etiqueta "Verified" del catálogo no sé qué garantiza. Revisar el repo antes de instalar, y hacerlo de a uno, después de comprobar que el hardware funciona.

| Plugin | Para qué | Estado de la investigación |
|---|---|---|
| Performance (SkyHonnor) | CPU, RAM, GPU, temperaturas y ventiladores en la barra, con botón a btop | No sé cómo lee la gráfica Intel Arc. Licencia: ver su repo |
| Time Machine (Jankees) | Respaldos con restic y navegador de snapshots | No sé. Hay que configurar el destino |
| Barcraft | Barra personalizable con skins por monitor | No sé. Nuevo (v0.5.2), no encontré documentación aparte del catálogo |
| DevDock | Puertos, túneles SSH, logs de Docker/Podman, systemd | No sé. Muy nuevo y hace mucho: revisar el código |
| Bettery Life (TimRudorf) | Límite de carga de la batería | **No sé** si funciona en el UX8406CA. No encontré su repo. Probar en el live USB (ver abajo) |
| OmaKeyboard-Brightness | Slider de luz del teclado | **No sé.** El backlight del teclado desmontable del Duo se maneja con el workaround de hemagome (HID por USB/Bluetooth), así que probablemente el plugin no lo vea. Sin verificar |
| OmaClone | Clonar repos pegando un enlace | No sé si respeta los alias SSH de multicuenta |
| **Omdrop** (netmojo) — [repo](https://github.com/netmojo-systems/omdrop-plugin) · [ficha](https://plugins.omarchy.org/plugin.html?id=netmojo.omdrop) | AirDrop: enviar/recibir archivos con dispositivos Apple cercanos | **Lo quiero.** v0.19.0, MIT. Solo está verificado el snapshot `afd1af8` (3 oct 2026); HEAD `130065c` sin verificar. **No sé** si el Wi-Fi del UX8406CA lo soporta en Linux: probar tras instalar |
| **Microphone Effects** (WhoIsCalebBrown) — [repo](https://github.com/WhoIsCalebBrown/mic-effects) · [ficha](https://plugins.omarchy.org/plugin.html?id=whoiscalebbrown.mic-effects) | Micrófono virtual a nivel de sistema con rack de efectos: reducción de ruido, dinámica, EQ, pitch, reverb | **Lo quiero.** v1.1.2, MIT. Solo verificado el snapshot `83afc96` (29 sep 2026); HEAD `d5d62b9` sin verificar. Sirve para el mic del Duo (que en hemagome funciona). Sin probar |

**Instalar los dos con revisión previa** (sin `--enable`, mirar el código y luego activar):

```bash
omarchy plugin add https://github.com/netmojo-systems/omdrop-plugin.git
omarchy plugin add https://github.com/WhoIsCalebBrown/mic-effects.git
omarchy plugin list --json
# tras revisar el código de cada uno, activarlo con --enable
```

**Probar el límite de carga (en el live USB, antes de instalar nada)**

```bash
ls /sys/class/power_supply/
cat /sys/class/power_supply/BAT*/charge_control_end_threshold
```

Si existe `charge_control_end_threshold`, el kernel expone el límite de carga y cualquier herramienta podría usarlo. Si no existe, el plugin no podrá hacer nada. Alternativas de CLI para ASUS: `batlimit` (menciona el módulo asus-wmi) y `batctl-tui` (AUR). Una discusión de Omarchy también menciona el paquete AUR `bat-asus-battery-bin`. Ninguno verificado en el UX8406CA.

**Otros plugins y herramientas que podrían servir para las dos pantallas (sin probar)**

| Nombre | Qué hace |
|---|---|
| [hyprsplit-workspaces-quickshell](https://github.com/Maduki-tech/hyprsplit-workspaces-quickshell) | Indicador de workspaces por monitor, en vez de una sola tira global |
| hyprmoncfg (widget de Omarchy) | Perfiles de monitores guardados, con editor visual de posición y escala. Requiere el paquete `hyprmoncfg` aparte |
| [omarchy-monitor-settings](https://github.com/ryanyogan/omarchy-monitor-settings) | TUI para resolución y escala en Hyprland |
| [arr213/omarchy-setup](https://github.com/arr213/omarchy-setup) | Scripts de monitores con orden configurable de arriba a abajo (`MONITOR_ORDER`) |

El repo de hemagome ya resuelve el layout vertical con posiciones y escala explícitas en Hyprland, así que estos serían complementos, no reemplazos.

---

## Fuentes

- [Gentleman-Programming/Gentleman.Dots](https://github.com/Gentleman-Programming/Gentleman.Dots)
- [Zen Browser](https://zen-browser.app) y [su repo](https://github.com/zen-browser/desktop)
- [Wikipedia: Zen Browser](https://en.wikipedia.org/wiki/Zen_Browser)
- [OMG! Ubuntu: Zen Browser](https://omgubuntu.co.uk/2025/08/zen-browser-is-what-mozilla-firefox-should-be)
- [Ghostty vs Kitty (It's FOSS)](https://itsfoss.com/comparison/ghostty-vs-kitty/)
- [Linux terminal emulators 2026 (glukhov.org)](https://www.glukhov.org/developer-tools/terminals-shell/terminal-emulators-for-linux-comparison/)
- [hemagome/zenbook-duo-ux8406ca-linux](https://github.com/hemagome/zenbook-duo-ux8406ca-linux)
