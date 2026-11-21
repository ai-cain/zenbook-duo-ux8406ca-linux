# Pasos de instalación (checklist)

Lista para ir instalando, un paso a la vez. Sale de
[README-UX8406CA.md](README-UX8406CA.md) y
[README-RICE-GENTLEMAN.md](README-RICE-GENTLEMAN.md).

**Cómo usarla**

1. Copia el comando del paso y pégalo en tu terminal (o en el chat de Claude
   con `!` adelante).
2. Si pide contraseña, escríbela (no se ve mientras escribes, es normal).
3. Si pregunta `[Y/n]`, presiona **Enter**.
4. Cuando termine bien, cambia `[ ]` por `[x]`.

Revisado el 2026-11-21: todos los nombres de paquetes existen.

---

## ✅ Ya hecho

- [x] Omarchy + Hyprland instalado
- [x] Arreglos del Zenbook Duo (`./install.sh` de este repo)
- [x] zram (swap en RAM) funcionando
- [x] Neovim, herdr, Docker, LibreOffice, btop, gh, lazygit, uv, ffmpeg, mpv, grim, slurp, snapper, yay
- [x] Repositorio `multilib` activado (necesario para Steam)
- [x] Touchpad con desplazamiento natural, como en Windows (ver abajo)

### Configuración personal (fuera del repo)

Estos cambios viven en `~/.config`, no en el repo. Si reinstalas, hay que
repetirlos (o guardarlos con chezmoi, paso 6).

| Cambio | Archivo | Qué se puso |
|---|---|---|
| Scroll del touchpad como en Windows | `~/.config/hypr/input.lua` | `natural_scroll = true` dentro de `hl.config({ input = { touchpad = { ... } } })` |

Omarchy trae `natural_scroll = false` de fábrica: el scroll se siente al revés
si vienes de Windows. No es una falla del Zenbook. Para volver: poner `false` y
guardar.

### Atajos de teclado básicos

**Super** = tecla de Windows. Ver todos: **`Super + K`**.

| Qué | Atajo |
|---|---|
| Cambiar de ventana | `Alt + Tab` |
| Ventana a la izquierda/derecha/arriba/abajo | `Super + flechas` |
| Ir al escritorio 1, 2, 3… | `Super + 1`, `Super + 2`… |
| Mandar ventana al escritorio 2 | `Super + Shift + 2` |
| Pasar a la otra pantalla | `Ctrl + Alt + Tab` |
| Cerrar ventana | `Super + W` |
| Pantalla completa | `Super + F` |
| Terminal | `Super + Enter` |
| Lista de apps | `Super + Alt + Espacio` |
| Navegador | `Super + Shift + B` |
| Archivos | `Super + Shift + F` |
| Menú de Omarchy | `Super + Espacio` |
| Apagar / reiniciar | `Super + Esc` |

En Zen: `Ctrl + D` guardar en favoritos, `Ctrl + T` nueva pestaña,
`Ctrl + W` cerrar pestaña, `Ctrl + Shift + T` recuperar pestaña. Las descargas
van a `~/Downloads`.

---

## Paso 1: Navegador (Zen Browser)

Elegido por: estilo Mac/Arc, código abierto, menos telemetría que Firefox.

- [x] Instalar

```bash
sudo pacman -S --needed zen-browser-bin
```

- [ ] Hacerlo el navegador principal (así `Super + Shift + B` abre Zen)

```bash
xdg-settings set default-web-browser zen.desktop
```

- [ ] Abrirlo con `Super + Alt + Espacio` → escribir **zen**
- [ ] Opcional: instalar la extensión de Bitwarden dentro de Zen

---

## Paso 2: Lápiz y pruebas de hardware

Para probar el táctil y el lápiz (presión, inclinación, borrador), que todavía
no están verificados en este modelo.

- [ ] Instalar

```bash
sudo pacman -S --needed evtest xournalpp rnote krita okular inkscape
```

- [ ] Probar el táctil y el lápiz (mueve el lápiz por las dos pantallas; salir con `Ctrl+C`)

```bash
sudo libinput debug-events --show-keycodes
```

- [ ] Abrir **Krita** y probar presión, inclinación y borrador del lápiz
- [ ] Probar los parlantes (reproducir algo con sonido). Si no suena, anotar la
      hora: es el bug conocido de los amplificadores

| App | Para qué |
|---|---|
| Xournal++ / Rnote | Apuntes a mano |
| Krita | Dibujo |
| Okular | Leer y anotar PDF |
| Inkscape | Dibujo vectorial |

---

## Paso 3: Terminal

Tus notas dicen kitty o Ghostty. Omarchy ya trae Ghostty en su repo.

- [ ] Instalar kitty

```bash
sudo pacman -S --needed kitty
```

---

## Paso 4: Cámara y Steam

- [ ] Instalar

```bash
sudo pacman -S --needed snapshot steam lib32-vulkan-intel
```

---

## Paso 5: Trabajo (IoT, contenedores, monitoreo)

- [ ] Instalar desde pacman

```bash
sudo pacman -S --needed mosquitto mqttui lazydocker nvtop
```

- [ ] Instalar `tio` (terminal serial para ESP32; viene del AUR)

```bash
yay -S tio
```

| Herramienta | Para qué |
|---|---|
| mosquitto | Broker MQTT y `mosquitto_pub` / `mosquitto_sub` |
| mqttui | Ver MQTT en la terminal |
| tio | Monitor serial (`tio /dev/ttyUSB0`) |
| lazydocker | Contenedores en la terminal |
| nvtop | Uso de la GPU Intel |

---

## Paso 6: Herramientas del día a día

- [ ] Instalar

```bash
sudo pacman -S --needed yazi cliphist chezmoi tailscale flatpak
```

| Herramienta | Para qué |
|---|---|
| yazi | Explorador de archivos en la terminal |
| cliphist | Historial del portapapeles |
| chezmoi | Guardar tus dotfiles en git |
| tailscale | Red privada para conectarte a tus equipos desde lejos |
| flatpak | Necesario para RustConn (paso 7) |

---

## Paso 7: Conexiones remotas (SSH, VNC, RDP, serial)

Necesita el paso 6 (flatpak). Reinicia la sesión después de instalar flatpak.

- [ ] Instalar RustConn

```bash
flatpak install flathub io.github.totoshko88.RustConn
```

---

## Paso 8: Bruno (reemplazo de Postman)

Viene del AUR: `yay` muestra el PKGBUILD; revísalo antes de aceptar.

- [ ] Instalar

```bash
yay -S bruno-bin
```

---

## Paso 9: Plugins de Omarchy

Corren sin sandbox: instálalos sin `--enable`, revisa el código y luego actívalos.

- [ ] Omdrop (AirDrop con dispositivos Apple)

```bash
omarchy plugin add https://github.com/netmojo-systems/omdrop-plugin.git
```

- [ ] Microphone Effects (reducción de ruido del micrófono)

```bash
omarchy plugin add https://github.com/WhoIsCalebBrown/mic-effects.git
```

- [ ] Ver que aparezcan

```bash
omarchy plugin list --json
```

---

## Paso 10 (opcional): Rice

- [ ] Música, visualizador y colores desde el wallpaper

```bash
sudo pacman -S --needed cava mpd rmpc matugen
yay -S tty-clock
```

No hace falta instalar Waybar, rofi ni hyprlock: Omarchy 4 ya trae su propia
barra, lanzador y pantalla de bloqueo.

---

## Opcional: elegir uno de cada uno

- [ ] Contraseñas: `bitwarden-cli` (si usas Vaultwarden/Bitwarden) o `keepassxc`
- [ ] Correo: `aerc` (en la terminal) o `thunderbird`
- [ ] VNC de respaldo: `remmina`
- [ ] Teclado en pantalla: `yay -S maliit-keyboard` (no está probado en Hyprland)
- [ ] Gentleman.Dots: respalda `~/.config` antes de usarlo, porque puede pisar tu
      configuración de Neovim y de la shell
