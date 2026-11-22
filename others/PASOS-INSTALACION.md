# Pasos de instalación (checklist)

Lista para ir instalando, un paso a la vez. Sale de
[README-UX8406CA.md](README-UX8406CA.md) y
[README-RICE-GENTLEMAN.md](README-RICE-GENTLEMAN.md).

**Cómo usarla**

1. Copia el comando del paso y pégalo en tu terminal (o en el chat del agente
   con `!` adelante).
2. Si pide contraseña, escríbela (no se ve mientras escribes, es normal).
3. Si pregunta `[Y/n]`, presiona **Enter**.
4. Cuando termine bien, cambia `[ ]` por `[x]`.

Actualizado el 2026-11-21 contra lo instalado (`pacman -Q`).

---

## ✅ Ya hecho

- [x] Omarchy + Hyprland instalado
- [x] Arreglos del Zenbook Duo (`./install.sh` de este repo)
- [x] zram (swap en RAM) funcionando
- [x] Neovim, herdr, Docker, LibreOffice, btop, gh, lazygit, uv, ffmpeg, mpv, grim, slurp, snapper, yay
- [x] Repositorio `multilib` activado (necesario para Steam)
- [x] Touchpad con desplazamiento natural, como en Windows (ver abajo)
- [x] Git configurado (nombre, correo, editor `nvim`) y `gh` con sesión en `ai-cain`
- [x] Repos ordenados en `~/code/<dueño>/<repo>` (ver abajo)
- [x] Limpieza diaria de `~/Downloads` (ver abajo)

### Configuración personal (fuera del repo)

Estos cambios viven en `~/.config`, no en el repo. Si reinstalas, hay que
repetirlos.

| Cambio | Archivo | Qué se puso |
|---|---|---|
| Scroll del touchpad como en Windows | `~/.config/hypr/input.lua` | `natural_scroll = true` dentro de `hl.config({ input = { touchpad = { ... } } })` |
| Atajo para ver el protector de pantalla | `~/.config/hypr/bindings.lua` | `o.bind("SUPER + CTRL + SHIFT + L", "Screensaver", "omarchy-launch-screensaver force")` |
| Limpieza de Descargas | `~/.config/systemd/user/downloads-cleanup.{service,timer}` | Cada día manda a la papelera lo que lleva más de 30 días en `~/Downloads` |

Omarchy trae `natural_scroll = false` de fábrica: el scroll se siente al revés
si vienes de Windows. No es una falla del Zenbook. Para volver: poner `false` y
guardar.

Para apagar la limpieza de Descargas:
`systemctl --user disable --now downloads-cleanup.timer`.

### Orden de carpetas

| Carpeta | Qué va |
|---|---|
| `~/code/ai-cain/` | Repos personales (este repo, `skill-work`) |
| `~/code/<organización>/` | Una carpeta por organización (`qalmia`, `cv-alys`, …) |
| `~/code/_sandbox/` | Repos externos para probar; se pueden borrar sin miedo |
| `~/Downloads` | Solo de paso: instalar y borrar |

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
| Bloquear pantalla | `Super + Ctrl + L` |
| Ver animaciones (sin bloquear) | `Super + Ctrl + Shift + L` |

Al dejar la laptop quieta: a los 2,5 min salen las animaciones y a los 5 min se
bloquea (`~/.config/omarchy/shell.json`, sección `idle`).

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

- [x] Hacerlo el navegador principal (así `Super + Shift + B` abre Zen)

```bash
omarchy-default-browser zen
```

Omarchy fija `$BROWSER`, por eso `xdg-settings` falla con
"$BROWSER is set and can't be changed".

- [ ] Instalar uBlock Origin (bloqueador de anuncios; Zen no trae uno):
      <https://addons.mozilla.org/firefox/addon/ublock-origin/> (autor: Raymond Hill)
- [ ] Opcional: instalar la extensión de Bitwarden dentro de Zen

---

## Paso 2: Lápiz y pruebas de hardware

Para probar el táctil y el lápiz (presión, inclinación, borrador), que todavía
no están verificados en este modelo.

- [x] Instalar

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

- [x] Instalar kitty

```bash
sudo pacman -S --needed kitty
```

---

## Paso 4: Cámara y Steam

- [x] Instalar

```bash
sudo pacman -S --needed snapshot steam lib32-vulkan-intel
```

---

## Paso 5: Trabajo (IoT, contenedores, monitoreo)

- [x] Instalar desde pacman

```bash
sudo pacman -S --needed mosquitto mqttui lazydocker nvtop
```

- [x] Instalar `tio` (terminal serial para ESP32; viene del AUR, junto con el paso 7)

| Herramienta | Para qué |
|---|---|
| mosquitto | Broker MQTT y `mosquitto_pub` / `mosquitto_sub` |
| mqttui | Ver MQTT en la terminal (respaldo / panel de herdr) |
| MQTTX | Cliente MQTT con interfaz gráfica y conexiones guardadas (AUR, paso siguiente) |
| tio | Monitor serial (`tio /dev/ttyUSB0`) |
| lazydocker | Contenedores en la terminal |
| nvtop | Uso de la GPU Intel |

- [ ] Instalar MQTTX (cliente MQTT gráfico, open source, guarda conexiones y credenciales)

```bash
yay -S --needed mqttx-bin
```

- [ ] Instalar Modbus con GUI desde el AUR (reemplazan a Modbus Poll y Modbus Slave de Windows) y fijarlos en el dock

```bash
yay -S --needed openmodscan openmodsim
```

| Herramienta | Para qué |
|---|---|
| OpenModScan | Maestro Modbus (como Modbus Poll) |
| OpenModSim | Esclavo Modbus simulado (como Modbus Slave) |

---

## Paso 6: Herramientas del día a día

- [x] Instalar

```bash
sudo pacman -S --needed yazi cliphist
```

| Herramienta | Para qué |
|---|---|
| yazi | Explorador de archivos en la terminal |
| cliphist | Historial del portapapeles |

Descartados (no hacen falta por ahora; se instalan en un minuto si cambia):

| Herramienta | Por qué no |
|---|---|
| tailscale | Solo sirve para conectarse a equipos remotos sin abrir puertos |
| flatpak | Solo hacía falta para RustConn, que se instala del AUR |
| chezmoi | Respaldo de dotfiles en git: opcional |

---

## Paso 7: Conexiones remotas, serial y API (AUR)

`yay` muestra el PKGBUILD de cada uno; los tres apuntan a su repo oficial en
GitHub.

- [x] Instalar (quedó `rustconn-bin`, la versión ya compilada)

```bash
yay -S rustconn-bin tio bruno-bin
```

- [x] Instalar HeidiSQL (cliente de bases de datos: MySQL, SQL Server, PostgreSQL, SQLite)

```bash
yay -S heidisql-qt6-bin
```

| Herramienta | Para qué |
|---|---|
| RustConn | SSH, VNC, RDP, SPICE y serial con conexiones guardadas |
| tio | Monitor serial (paso 5) |
| Bruno | Reemplazo de Postman; colecciones como archivos aptos para git |
| HeidiSQL | Ver y editar bases de datos; versión nativa Qt6 (liviana, no Electron) |

---

## Paso 8: Plugins de Omarchy

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

## Paso 9: Agente de IA (Gentle Shell)

- [x] gentle-ai 4.6.0 instalado (`~/go/bin`, enlazado en `~/.local/bin`)
- [x] Gentle Shell 4.9.0 instalado (trae su propio Pi, gentle-ai y Engram en `~/.gentle-shell`)
- [ ] Iniciar sesión con un proveedor de modelos: dentro de Gentle Shell, `/login`
- [ ] Elegir el modelo con `/model` y, opcionalmente, la lista de respaldo con `/gentle:profiles`

Uso diario:

```bash
cd ~/code/<dueño>/<repo>
gentle-shell
```

La sesión de IA se guarda en `~/.gentle-shell/agent/auth.json`: no subirlo a git.

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
