builtins.fromJSON ''{
  "battery": {
    "format": "<span foreground='#ffd1db'>{icon}</span> {capacity}%",
    "format-charging": "<span foreground='#ffd1db'>{icon}</span> {capacity}%",
    "format-full": "<span foreground='#ffd1db'></span> {capacity}%",
    "format-icons": {
      "charging": [
        "",
        "",
        "",
        "",
        ""
      ],
      "default": [
        "",
        "",
        "",
        "",
        ""
      ]
    },
    "format-plugged": "<span foreground='#ffd1db'></span> {capacity}%",
    "format-time": "{H}:{M}",
    "interval": 30,
    "states": {
      "critical": 15,
      "warning": 30
    },
    "tooltip-format": "{timeTo}"
  },
  "clock": {
    "calendar": {
      "format": {
        "days": "<span color='#ff7aba'><b>{}</b></span>",
        "months": "<span color='#89b4fa'><b>{}</b></span>",
        "today": "<span color='#ffd1db'><b><u>{}</u></b></span>",
        "weekdays": "<span color='#f38ba8'><b>{}</b></span>",
        "weeks": "<span color='#a6e3a1'><b>W{}</b></span>"
      },
      "mode": "month",
      "on-scroll": 1,
      "weeks-pos": "left"
    },
    "format": "<span foreground='#ffd1db'>󰅐</span> {:%a - %H:%M}",
    "format-alt": "<span foreground='#ffd1db'>󰸗</span> {:%a, %d %b %y   <span foreground='#ffd1db'>󰅐 </span> %H:%M}",
    "interval": 1,
    "tooltip": true,
    "tooltip-format": "<tt>{calendar}</tt>"
  },
  "cpu": {
    "format": "<span foreground='#ffd1db'></span> {usage}%",
    "interval": 2,
    "tooltip": false
  },
  "custom/memory": {
    "exec": "~/.config/waybar/scripts/memory.sh",
    "format": "<span foreground='#ffd1db'></span> {}",
    "interval": 5,
    "tooltip": false
  },
  "custom/weather": {
    "exec": "''${HOME}/.config/waybar/scripts/weather.sh Delhi+India",
    "format": "<span foreground='#ffd1db'>󰅟</span> {}",
    "interval": 3600,
    "on-click-right": "''${HOME}/.config/waybar/scripts/weather.sh Delhi+India",
    "return-type": "json",
    "tooltip": false
  },
  "disk": {
    "format": "<span foreground='#ffd1db'></span> {free}",
    "interval": 10,
    "path": "/",
    "tooltip": false
  },
  "exclusive": true,
  "layer": "top",
  "margin": "5px 5px 0px 5px",
  "modules-center": [
    "clock"
  ],
  "modules-left": [
    "cpu",
    "temperature",
    "custom/memory",
    "disk"
  ],
  "modules-right": [
    "custom/weather",
    "wireplumber",
    "battery",
    "network"
  ],
  "network": {
    "format-disconnected": "<span foreground='#ffd1db'>󰲛</span> Offline",
    "format-ethernet": "<span foreground='#ffd1db'>󰈀</span> Connected",
    "format-icons": {
      "wifi": [
        "󰤯",
        "󰤟",
        "󰤢",
        "󰤥",
        "󰤨"
      ]
    },
    "format-wifi": "<span foreground='#ffd1db'>{icon}</span> {essid}",
    "interface": "wlan0",
    "interval": 5,
    "tooltip": false
  },
  "niri/workspaces": {
    "format": "{icon}",
    "format-icons": {
      "browser": "󰈹",
      "chat": "",
      "default": "",
      "terminal": ""
    },
    "hide-empty": true
  },
  "position": "top",
  "spacing": 5,
  "temperature": {
    "format": "<span foreground='#ffd1db'>󱃃</span> {temperatureC}°C",
    "hwmon-path": "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon7/temp1_input",
    "interval": 2,
    "thermal-zone": 0,
    "tooltip": false
  },
  "wireplumber": {
    "format": "<span foreground='#ffd1db'>{icon}</span> {volume}%",
    "format-icons": [
      "󰕿",
      "󰖀",
      "󰕾"
    ],
    "format-muted": "<span foreground='#ffd1db'>󰝟</span> Muted",
    "on-click-right": "pavucontrol",
    "tooltip": false
  }
}
''
