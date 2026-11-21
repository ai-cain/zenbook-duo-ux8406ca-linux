# Zenbook Duo 2025 (UX8406CA) en Arch Linux + Hyprland

Guía y notas para usar el ASUS Zenbook Duo UX8406CA con Arch Linux y Hyprland (ricing estilo r/unixporn), con GNOME como respaldo y Windows como plan B.

> Solo para **UX8406CA (2025, Core Ultra 9 285H)**. El repo del 2026 (UX8407AA, Panther Lake) no aplica: sus módulos se niegan a instalar en este modelo.
> Todo viene de README y páginas públicas, no de pruebas propias en esta laptop.

---

## 1. La laptop en venta

Ficha vista: **UX8406CA-QL444W**.

| Dato | Valor |
|---|---|
| CPU | Intel Core Ultra 9 285H, 16 núcleos |
| RAM | 16 GB LPDDR5X, no expandible |
| Disco | SSD 512 GB (una ranura M.2) |
| Pantallas | 2× OLED 1920×1200, táctiles, 16:10 |
| Lápiz | ASUS Pen SA203H, MPP 2.0 (incluido) |
| Conectividad | Wi-Fi 7, Bluetooth 5.4, cámara FHD con IR |
| Teclado | Español |
| Incluye | Cargador USB-C 65 W, lápiz, mochila y funda |
| Sistema | Windows 11 Home |
| Garantía | 1 año oficial ASUS |
| Precio visto | S/ 6,000 |
| Devolución | "Devuelve tu producto sin abrir sin costo" (confirmar qué pasa si se abre) |

### Comparación de precio en Perú

| Opción | Precio |
|---|---|
| Esta ficha (285H, 16 GB, 512 GB, 1920×1200) | S/ 6,000 |
| UX8406CA-PZ073W (285H, 32 GB, 1 TB, 3K OLED) | Entre S/ 8,383 y S/ 9,609 (capturas de junio en Falabella y Knasta) |
| Zenbook DUO 2026 (UX8407AA) | S/ 12,599 (Diario Correo: disponible desde el 16 de junio en Falabella y la tienda oficial ASUS Perú) |

- La laptop actual tiene 12 GB de RAM, así que 16 GB es un salto de un tercio. Sigue soldada.
- Revisar el precio actual: las capturas comparativas son de junio.

### Cómo se identifica el modelo

- El 285H es del 2025 (Arrow Lake). El 2024 trae 185H. El 2026 trae Core Ultra 7 355H, 9 386H o X9 388H (Panther Lake).
- Confirmar con la etiqueta o con `sudo dmidecode -s system-product-name` (debe decir UX8406CA).

---

## 2. Decisión de escritorio

| Opción | Pros | Contras | Costo |
|---|---|---|---|
| **Hyprland (elegida)** | Ricing fluido. Hay repos probados en el UX8406CA | Más armado manual. Algunos scripts apuntan a Omarchy | Gratis |
| GNOME + extensiones | Mejor cobertura de las funciones del Duo (teclas de pantalla, rotación, mapeo de táctil) | No es lo que se quiere usar | Gratis |
| KDE Plasma | Muy personalizable | Sin cobertura documentada para el 2025 | Gratis |
| Windows 11 | Todo funciona de fábrica | No es el objetivo | Incluido |

Plan B si algo crítico falla (por ejemplo, el audio): dejarla con Windows.

---

## 3. Soporte Hyprland para el UX8406CA

### Repos

| Repo | Modelo | Qué hace | Notas |
|---|---|---|---|
| [hemagome/zenbook-duo-ux8406ca-linux](https://github.com/hemagome/zenbook-duo-ux8406ca-linux) | UX8406CA | Documentación y workarounds reversibles para Omarchy 4.x + Hyprland | El más relevante. Probado en un solo equipo |
| [keejkrej/omarchy-zenbookduo](https://github.com/keejkrej/omarchy-zenbookduo) | UX8406MA y UX8406CA | Apaga `eDP-2` con el teclado acoplado por USB y apila la pantalla inferior bajo la superior al quitarlo | USB ID del teclado: `0b05:1bf2` en UX8406CA, `0b05:1b2c` en UX8406MA |
| [laithm/zenbook-duo-hyprland](https://github.com/laithm/zenbook-duo-hyprland) (AUR: `zenbook-duo-hyprland`) | UX8406MA | Auto-toggle de pantalla y teclado Bluetooth, face unlock opcional | Probado solo en UX8406MA. No cubre brillo, táctil ni rotación. El autor se aleja de esta laptop |

### Estado según hemagome (Linux 7.2.8-9-omarchy, Omarchy 4.0.5, Hyprland 0.56.2, BlueZ 5.87)

| Función | Estado |
|---|---|
| Gráficos Arc con Wayland | Funciona upstream |
| Ambos paneles a 120 Hz | Funciona upstream |
| Táctil y lápiz en ambos paneles | Funciona upstream (detecta dos dispositivos táctiles y dos de lápiz) |
| Wi-Fi, Bluetooth, micrófono, webcam | Funciona upstream |
| LUKS, Btrfs, Limine, arranque dual con Windows | Funciona (depende de la instalación) |
| Teclado Bluetooth desmontable | Funciona: emparejar y confiar con BlueZ |
| Layout vertical de dos pantallas | Requiere workaround (posiciones y escala explícitas en Hyprland) |
| Brillo independiente por panel | Requiere workaround (wrapper por monitor) |
| Apagar panel inferior al cubrirlo con el teclado | Requiere workaround (detección USB por pogo-pin) |
| Capa Fn, Fn Lock (`Fn+Esc`), backlight del teclado (F4), brillo (F5–F6), mute de micro (F9), emoji (F11) | Requieren workaround (HID nativo USB `1bf2` y Bluetooth `1bf3`) |
| Mapeo táctil tras cambios de layout | Parcial: sin validar |
| **Parlantes internos** | **Bug reproducido**: timeout al encender los amplificadores CS35L41 (`PUP_DONE_MASK: -110`) |
| Presión del lápiz, comportamiento de la tapa, suspend/resume completo | No cubiertos en la página |

Ningún elemento está marcado como "no funciona", pero el audio de los parlantes es el punto débil.

### Instalación (según su README)

```bash
git clone https://github.com/hemagome/zenbook-duo-ux8406ca-linux.git && cd zenbook-duo-ux8406ca-linux
./install.sh --list            # revisar opciones antes de aplicar nada
./install.sh --layout          # layout vertical de dos pantallas
./install.sh --brightness      # brillo independiente por panel
./install.sh --keyboard-dock   # apagar panel inferior con el teclado puesto
sudo ./install.sh --fn-mode    # capa Fn (una regla udev estrecha)
# o todo junto: ./install.sh --all
hyprctl reload && hyprctl configerrors
```

- Inspeccionar los scripts antes de correrlos. El instalador muestra sus operaciones, hace respaldos en `~/.local/state/ux8406ca-linux/` y se niega ante conflictos inesperados.
- Desinstalar solo está documentado para brillo y layout: `./uninstall.sh --brightness` y `./uninstall.sh --layout`.
- Después de actualizar kernel, Hyprland, Omarchy, asusctl o BlueZ, repetir las pruebas.
- Pendientes de retesteo según el repo: pulsaciones físicas, reconexión Bluetooth y transiciones de dock. VMD activado sin validar, y el kernel `7.2.11.arch1-1` no fue probado en arranque.

### Omarchy vs Arch plano

- [Omarchy](https://omarchy.org) es una configuración opinionada de Arch + Hyprland (de DHH). Trae barra, lanzador, temas y atajos ya puestos.
- Los repos de arriba están probados sobre Omarchy, y algunos scripts pueden depender de herramientas suyas (por ejemplo, el brillo se ajusta "a través de Omarchy").
- Dos caminos:
  1. Instalar Omarchy y usar los repos tal cual (más seguro), luego reemplazar la parte visual por el rice propio.
  2. Arch + Hyprland a mano y adaptar los scripts (más control, sin probar).
- Con Omarchy, un rice propio encima puede chocar con su tema. No está verificado qué tan limpio sale.

---

## 4. Rice (estilo r/unixporn)

Stack de referencia (post "[Hyprland] new to linux" en r/unixporn):

| Pieza | Herramienta |
|---|---|
| Compositor | [Hyprland](https://hypr.land) |
| Lockscreen | [hyprlock](https://github.com/hyprwm/hyprlock) |
| Lanzador | [rofi](https://github.com/davatorium/rofi) |
| Barra | [Waybar](https://github.com/Alexays/Waybar) |
| Música | [rmpc](https://github.com/mierak/rmpc) + [MPD](https://www.musicpd.org) |
| Terminal | [kitty](https://sw.kovidgoyal.net/kitty/) |
| Visualizador | [cava](https://github.com/karlstav/cava) |
| Reloj | [tty-clock](https://github.com/xorg62/tty-clock) |
| Navegador | [LibreWolf](https://librewolf.net) + [pywalfox](https://github.com/Frewacom/pywalfox) |
| Editor | [Neovim](https://neovim.io) |
| Colores desde el wallpaper | [matugen](https://github.com/InioX/matugen) |

- matugen genera los colores con plantillas; en el post, la plantilla de kitty mapea `surface`, `primary`, `secondary`, etc. a `color0`–`color15`.
- Uso sugerido de las dos pantallas apiladas: arriba kitty, Neovim y navegador; abajo cava, rmpc y tty-clock. Waybar y las reglas de Hyprland pueden ser por monitor (revisar la wiki para los nombres exactos de opciones).
- Si se publican los dotfiles: revisar todo, incluido el historial de git, para no filtrar contraseñas o claves.

---

## 5. Orden de trabajo

1. **Antes de borrar Windows**: arrancar Windows y actualizar la BIOS. En el hilo de NixOS sobre el Duo 2024 se recomienda actualizar el firmware, sin problemas detectados después.
2. **Probar con Arch live USB** (sin instalar): audio, táctil, lápiz y Bluetooth.
3. Instalar Arch (o Omarchy) y los workarounds de hemagome.
4. Rice encima.
5. Repetir pruebas después de cada actualización importante.

### Pruebas de táctil y lápiz

```bash
sudo pacman -S --needed libinput evtest
sudo libinput debug-events --show-keycodes
```

Luego probar presión, inclinación y borrador en Krita. No hay documentación de presión del lápiz para este modelo.

### zram (16 GB de RAM soldada)

```bash
sudo pacman -S zram-generator
# configurar /etc/systemd/zram-generator.conf (p. ej. zram-size = ram / 2) y reiniciar el servicio
```

Ver la [wiki de Arch sobre zram](https://wiki.archlinux.org/title/Zram) para los valores.

### Apps para el lápiz

```bash
sudo pacman -S --needed xournalpp krita okular inkscape
pacman -Ss rnote
```

[Xournal++](https://github.com/xournalpp/xournalpp), [Rnote](https://github.com/flxzt/rnote), [Krita](https://krita.org), [Okular](https://okular.kde.org), [Inkscape](https://inkscape.org). Todas gratis.

### Teclado en pantalla (modo tablet)

```bash
pacman -Ss maliit
sudo pacman -S maliit-keyboard
```

En KDE se activa desde Ajustes → Teclado → Teclado virtual. En Hyprland no hay un flujo documentado aquí. No está verificado si kitty dispara el teclado virtual. El teclado físico también funciona por Bluetooth.

---

## 6. Respaldo con GNOME (si Hyprland da problemas)

| Proyecto | Para qué | Notas |
|---|---|---|
| [cceelen/asus-zenbook-duo-ux8406](https://github.com/cceelen/asus-zenbook-duo-ux8406) | Teclado y Fn (dock, cable y Bluetooth), luz del teclado, pantalla inferior con brillo sincronizado, teclas de pantalla y rotación en GNOME, servicio contra apagados con la tapa cerrada | Probado en UX8406CA con Fedora. Requiere Linux 6.11 o superior y `udev-hid-bpf`. Arch por repo OBS (no AUR) |
| [alesya-h/zenbook-duo-2024-ux8406ma-linux](https://github.com/alesya-h/zenbook-duo-2024-ux8406ma-linux) | Sync de brillo, luz del teclado, límite de batería, palm rejection, táctil/lápiz por panel | Escrito para UX8406MA. Mapeo de paneles solo GNOME. Pide una regla sudo NOPASSWD que el propio README llama "hack" |
| [Fmstrat/zenbook-duo-linux](https://github.com/fmstrat/zenbook-duo-linux) | Pantalla inferior y Bluetooth al quitar o poner el teclado | Probado en UX8406CA con Ubuntu 25.10 |
| [JowiAoun/linux-on-zenbook-duo](https://github.com/JowiAoun/linux-on-zenbook-duo) | Dock de pantalla, hotkeys, backlight y ecualización de parlantes | Escrito para UX8406MA, probado en Ubuntu 24.04 con GNOME |

Limitaciones de cceelen: la tecla de Bluetooth del teclado no manda eventos al laptop, el micrófono del jack TRRS no da entrada, el límite de batería no se mantiene al 80% y las ventanas de la pantalla inferior se quedan arriba al volver. Quitar otras soluciones del Duo antes de instalar.

---

## 7. Riesgos pendientes

- **Audio**: bug de los amplificadores CS35L41 reproducido por hemagome; en el 2024 hubo regresiones de audio según el kernel. Usar audífonos Bluetooth con micrófono propio si falla.
- **Lápiz**: presión, inclinación y borrador sin documentar para este modelo.
- **Mapeo táctil tras cambios de layout**: sin validar.
- **Devolución**: la ficha dice "sin abrir". Preguntar al vendedor qué pasa si se enciende. Preguntar también si instalar Linux afecta la garantía (no encontré información).
- **Todo está probado en equipos de terceros**, no en esta laptop.

---

## Fuentes

- [hemagome/zenbook-duo-ux8406ca-linux](https://github.com/hemagome/zenbook-duo-ux8406ca-linux)
- [keejkrej/omarchy-zenbookduo](https://github.com/keejkrej/omarchy-zenbookduo)
- [laithm/zenbook-duo-hyprland](https://github.com/laithm/zenbook-duo-hyprland)
- [cceelen/asus-zenbook-duo-ux8406](https://github.com/cceelen/asus-zenbook-duo-ux8406)
- [alesya-h/zenbook-duo-2024-ux8406ma-linux](https://github.com/alesya-h/zenbook-duo-2024-ux8406ma-linux)
- [Fmstrat/zenbook-duo-linux](https://github.com/fmstrat/zenbook-duo-linux)
- [JowiAoun/linux-on-zenbook-duo](https://github.com/JowiAoun/linux-on-zenbook-duo)
- [Falabella Perú: Zenbook Duo](https://www.falabella.com.pe/falabella-pe/shop/asus-zenbook-pro-duo)
- [Knasta: UX8406CA-PZ073W](https://knasta.pe/detail/shopstar/16769847/laptop-asus-zenbook-ux8406ca-pz073w-14-3k-oled-touch-core-ultra-9-285h-32gb-1tb-ssd-w11h)
- [Diario Correo: Zenbook DUO 2026 en Perú](https://diariocorreo.pe/tecnologia/asus-y-rog-lanzan-en-peru-las-nuevas-laptops-de-doble-pantalla-zenbook-duo-y-zephyrus-duo-2026-noticia/)
- [Ultrabookreview: Zenbook DUO 2026 vs 2025](https://www.ultrabookreview.com/74199-asus-zenbook-duo-ux3407/)
- [NixOS Discourse: Zenbook Duo 2024](https://discourse.nixos.org/t/asus-zenbook-duo-2024-ux8406ma-nixos/39792?page=4)
