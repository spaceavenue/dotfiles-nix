let
  palette = import ../../lib/palette.nix;
in
builtins.fromJSON ''
  {
    "battery": {
      "format": "<span foreground='${palette.text}'>{icon}</span> {capacity}%",
      "format-charging": "<span foreground='${palette.text}'>{icon}</span> {capacity}%",
      "format-full": "<span foreground='${palette.text}'></span> {capacity}%",
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
      "format-plugged": "<span foreground='${palette.text}'></span> {capacity}%",
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
          "months": "<span color='${palette.blue}'><b>{}</b></span>",
          "today": "<span color='${palette.text}'><b><u>{}</u></b></span>",
          "weekdays": "<span color='${palette.red}'><b>{}</b></span>",
          "weeks": "<span color='${palette.green}'><b>W{}</b></span>"
        },
        "mode": "month",
        "on-scroll": 1,
        "weeks-pos": "left"
      },
      "format": "<span foreground='${palette.text}'>󰅐</span> {:%a - %H:%M}",
      "format-alt": "<span foreground='${palette.text}'>󰸗</span> {:%a, %d %b %y   <span foreground='${palette.text}'>󰅐 </span> %H:%M}",
      "interval": 1,
      "tooltip": true,
      "tooltip-format": "<tt>{calendar}</tt>"
    },
    "cpu": {
      "format": "<span foreground='${palette.text}'></span> {usage}%",
      "interval": 2,
      "tooltip": false
    },
    "custom/memory": {
      "exec": "~/.config/waybar/scripts/memory.sh",
      "format": "<span foreground='${palette.text}'></span> {}",
      "interval": 5,
      "tooltip": false
    },
    "custom/weather": {
      "exec": "''${HOME}/.config/waybar/scripts/weather.sh Delhi+India",
      "format": "<span foreground='${palette.text}'>󰅟</span> {}",
      "interval": 3600,
      "on-click-right": "''${HOME}/.config/waybar/scripts/weather.sh Delhi+India",
      "return-type": "json",
      "tooltip": false
    },
    "disk": {
      "format": "<span foreground='${palette.text}'></span> {free}",
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
      "format-disconnected": "<span foreground='${palette.text}'>󰲛</span> Offline",
      "format-ethernet": "<span foreground='${palette.text}'>󰈀</span> Connected",
      "format-icons": {
        "wifi": [
          "󰤯",
          "󰤟",
          "󰤢",
          "󰤥",
          "󰤨"
        ]
      },
      "format-wifi": "<span foreground='${palette.text}'>{icon}</span> {essid}",
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
      "format": "<span foreground='${palette.text}'>󱃃</span> {temperatureC}°C",
      "hwmon-path": "/sys/devices/platform/thinkpad_hwmon/hwmon/hwmon7/temp1_input",
      "interval": 2,
      "thermal-zone": 0,
      "tooltip": false
    },
    "wireplumber": {
      "format": "<span foreground='${palette.text}'>{icon}</span> {volume}%",
      "format-icons": [
        "󰕿",
        "󰖀",
        "󰕾"
      ],
      "format-muted": "<span foreground='${palette.text}'>󰝟</span> Muted",
      "on-click-right": "pavucontrol",
      "tooltip": false
    }
  }
''
