let
  palette = import ../lib/palette.nix;
in
builtins.fromJSON ''
  {
      "$schema": "https://zed.dev/schema/themes/v0.2.0.json",
      "name": "Main",
      "author": "spaceavenue",
      "themes": [
          {
              "name": "Main",
              "appearance": "dark",
              "style": {
                  "accents": [
                      "${palette.red}",
                      "${palette.pink}",
                      "${palette.text}",
                      "${palette.mauve}",
                      "${palette.blue}",
                      "${palette.green}",
                      "${palette.peach}"
                  ],
                  "vim.mode.text": "${palette.base}",
                  "vim.normal.foreground": "${palette.base}",
                  "vim.helix_normal.foreground": "${palette.base}",
                  "vim.visual.foreground": "${palette.base}",
                  "vim.helix_select.foreground": "${palette.base}",
                  "vim.insert.foreground": "${palette.base}",
                  "vim.visual_line.foreground": "${palette.base}",
                  "vim.visual_block.foreground": "${palette.base}",
                  "vim.replace.foreground": "${palette.base}",
                  "vim.normal.background": "${palette.text}",
                  "vim.helix_normal.background": "${palette.text}",
                  "vim.visual.background": "${palette.mauve}",
                  "vim.helix_select.background": "${palette.mauve}",
                  "vim.insert.background": "${palette.green}",
                  "vim.visual_line.background": "${palette.mauve}",
                  "vim.visual_block.background": "${palette.pink}",
                  "vim.replace.background": "${palette.red}",
                  "background.appearance": "opaque",
                  "border": "#00000000",
                  "border.variant": "#00000000",
                  "border.focused": "#00000000",
                  "border.selected": "#00000000",
                  "border.transparent": "#00000000",
                  "border.disabled": "#00000000",
                  "elevated_surface.background": "${palette.surfaceDark2}",
                  "surface.background": "${palette.surfaceDark0}",
                  "background": "${palette.base}",
                  "element.background": "#220417",
                  "element.hover": "#2d071f",
                  "element.selected": "#380b27",
                  "element.active": "#500021",
                  "element.disabled": "#18000f80",
                  "drop_target.background": "#f38ba826",
                  "ghost_element.background": "#00000000",
                  "ghost_element.hover": "#ffd1db14",
                  "ghost_element.active": "#ffd1db24",
                  "ghost_element.selected": "#ffd1db1f",
                  "ghost_element.disabled": "#ffffff08",
                  "text": "${palette.text}",
                  "text.muted": "${palette.muted}",
                  "text.placeholder": "${palette.dim}",
                  "text.disabled": "#5a454980",
                  "text.accent": "${palette.pink}",
                  "icon": "${palette.text}",
                  "icon.muted": "${palette.muted}",
                  "icon.disabled": "#5a454980",
                  "icon.placeholder": "${palette.dim}",
                  "icon.accent": "${palette.pink}",
                  "status_bar.background": "${palette.base}",
                  "title_bar.background": "${palette.base}",
                  "title_bar.inactive_background": "#14010a",
                  "toolbar.background": "${palette.base}",
                  "tab_bar.background": "${palette.base}",
                  "tab.inactive_background": "${palette.crust}",
                  "tab.active_background": "${palette.base}",
                  "search.match_background": "#cc99aa33",
                  "search.active_match_background": "#f38ba855",
                  "panel.background": "${palette.surfaceDark0}",
                  "panel.focused_border": "#00000000",
                  "panel.indent_guide": "${palette.guide}",
                  "panel.indent_guide_active": "#cc99aa80",
                  "panel.indent_guide_hover": "${palette.pink}",
                  "panel.overlay_background": "${palette.surfaceDark0}",
                  "pane.focused_border": "#00000000",
                  "pane_group.border": "#00000000",
                  "scrollbar.thumb.background": "#cc99aa33",
                  "scrollbar.thumb.hover_background": "#cc99aa66",
                  "scrollbar.thumb.active_background": "#cc99aa99",
                  "scrollbar.thumb.border": null,
                  "scrollbar.track.background": "${palette.base}",
                  "scrollbar.track.border": "#00000000",
                  "minimap.thumb.background": "#f5c2e733",
                  "minimap.thumb.hover_background": "#f5c2e766",
                  "minimap.thumb.active_background": "#f5c2e799",
                  "minimap.thumb.border": null,
                  "editor.foreground": "${palette.text}",
                  "editor.background": "${palette.base}",
                  "editor.gutter.background": "${palette.base}",
                  "editor.subheader.background": "${palette.surfaceDark0}",
                  "editor.active_line.background": "#ffd1db0f",
                  "editor.highlighted_line.background": "#ffd1db08",
                  "editor.line_number": "${palette.subtext}",
                  "editor.active_line_number": "${palette.pink}",
                  "editor.invisible": "#5a45494d",
                  "editor.wrap_guide": "${palette.guide}",
                  "editor.active_wrap_guide": "#cc99aa80",
                  "editor.document_highlight.bracket_background": "#f5c2e729",
                  "editor.document_highlight.read_background": "#ffd1db18",
                  "editor.document_highlight.write_background": "#ffd1db22",
                  "editor.indent_guide": "${palette.guide}",
                  "editor.indent_guide_active": "#cc99aa80",
                  "terminal.background": "#000000",
                  "terminal.ansi.background": "#000000",
                  "terminal.foreground": "${palette.text}",
                  "terminal.dim_foreground": "${palette.dim}",
                  "terminal.bright_foreground": "${palette.text}",
                  "terminal.ansi.black": "${palette.guide}",
                  "terminal.ansi.white": "${palette.muted}",
                  "terminal.ansi.red": "${palette.red}",
                  "terminal.ansi.green": "${palette.green}",
                  "terminal.ansi.yellow": "${palette.peach}",
                  "terminal.ansi.blue": "${palette.blue}",
                  "terminal.ansi.magenta": "${palette.pink}",
                  "terminal.ansi.cyan": "${palette.mauve}",
                  "terminal.ansi.bright_black": "${palette.subtext}",
                  "terminal.ansi.bright_white": "${palette.text}",
                  "terminal.ansi.bright_red": "#ff7597",
                  "terminal.ansi.bright_green": "#bbf2b6",
                  "terminal.ansi.bright_yellow": "#fcecc2",
                  "terminal.ansi.bright_blue": "#a3c7fc",
                  "terminal.ansi.bright_magenta": "#ffcaf0",
                  "terminal.ansi.bright_cyan": "#ddbdfc",
                  "terminal.ansi.dim_black": "#220417",
                  "terminal.ansi.dim_white": "#cc99aa80",
                  "terminal.ansi.dim_red": "#f38ba880",
                  "terminal.ansi.dim_green": "#a6e3a180",
                  "terminal.ansi.dim_yellow": "#fab38780",
                  "terminal.ansi.dim_blue": "#89b4fa80",
                  "terminal.ansi.dim_magenta": "#f5c2e780",
                  "terminal.ansi.dim_cyan": "#cba6f780",
                  "link_text.hover": "${palette.blue}",
                  "conflict": "${palette.red}",
                  "conflict.border": "${palette.red}",
                  "conflict.background": "#f38ba826",
                  "created": "${palette.green}",
                  "created.border": "${palette.green}",
                  "created.background": "#a6e3a126",
                  "deleted": "${palette.red}",
                  "deleted.border": "${palette.red}",
                  "deleted.background": "#f38ba826",
                  "hidden": "${palette.subtext}",
                  "hidden.border": "${palette.subtext}",
                  "hidden.background": "${palette.surfaceDark0}",
                  "hint": "${palette.dim}",
                  "hint.border": "${palette.dim}",
                  "hint.background": "${palette.surfaceDark0}",
                  "ignored": "${palette.subtext}",
                  "ignored.border": "${palette.subtext}",
                  "ignored.background": "#ac798a26",
                  "modified": "${palette.peach}",
                  "modified.border": "${palette.peach}",
                  "modified.background": "#fab38726",
                  "predictive": "${palette.dim}",
                  "predictive.border": "#cc99aa40",
                  "predictive.background": "${palette.surfaceDark0}",
                  "renamed": "${palette.blue}",
                  "renamed.border": "${palette.blue}",
                  "renamed.background": "#89b4fa26",
                  "info": "${palette.blue}",
                  "info.border": "${palette.blue}",
                  "info.background": "#89b4fa26",
                  "warning": "${palette.peach}",
                  "warning.border": "${palette.peach}",
                  "warning.background": "#fab38726",
                  "error": "${palette.red}",
                  "error.border": "${palette.red}",
                  "error.background": "#f38ba826",
                  "success": "${palette.green}",
                  "success.border": "${palette.green}",
                  "success.background": "#a6e3a126",
                  "unreachable": "${palette.red}",
                  "unreachable.border": "${palette.red}",
                  "unreachable.background": "#f38ba826",
                  "players": [
                      {
                          "cursor": "${palette.text}",
                          "selection": "#ffd1db44",
                          "background": "${palette.red}"
                      },
                      {
                          "cursor": "${palette.mauve}",
                          "selection": "#cba6f740",
                          "background": "${palette.mauve}"
                      },
                      {
                          "cursor": "${palette.lavender}",
                          "selection": "#b4befe40",
                          "background": "${palette.lavender}"
                      },
                      {
                          "cursor": "${palette.sapphire}",
                          "selection": "#74c7ec40",
                          "background": "${palette.sapphire}"
                      },
                      {
                          "cursor": "${palette.green}",
                          "selection": "#a6e3a140",
                          "background": "${palette.green}"
                      },
                      {
                          "cursor": "${palette.yellow}",
                          "selection": "#f9e2af40",
                          "background": "${palette.yellow}"
                      },
                      {
                          "cursor": "${palette.peach}",
                          "selection": "#fab38740",
                          "background": "${palette.peach}"
                      },
                      {
                          "cursor": "${palette.red}",
                          "selection": "#f38ba840",
                          "background": "${palette.red}"
                      }
                  ],
                  "version_control.added": "${palette.green}",
                  "version_control.deleted": "${palette.red}",
                  "version_control.modified": "${palette.peach}",
                  "version_control.renamed": "${palette.blue}",
                  "version_control.conflict": "${palette.red}",
                  "version_control.conflict_marker.ours": "#a6e3a133",
                  "version_control.conflict_marker.theirs": "#89b4fa33",
                  "version_control.ignored": "${palette.subtext}",
                  "debugger.accent": "${palette.red}",
                  "editor.debugger_active_line.background": "#f38ba818",
                  "syntax": {
                      "variable": {
                          "color": "${palette.text}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "variable.builtin": {
                          "color": "${palette.red}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "variable.parameter": {
                          "color": "${palette.maroon}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "variable.member": {
                          "color": "${palette.blue}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "variable.special": {
                          "color": "${palette.red}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "constant": {
                          "color": "${palette.peach}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "constant.builtin": {
                          "color": "${palette.peach}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "constant.macro": {
                          "color": "${palette.mauve}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "module": {
                          "color": "${palette.yellow}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "label": {
                          "color": "${palette.blue}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "string": {
                          "color": "${palette.mauve}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "string.documentation": {
                          "color": "${palette.mauve}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "string.regexp": {
                          "color": "${palette.peach}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "string.escape": {
                          "color": "${palette.pink}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "string.special": {
                          "color": "${palette.pink}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "string.special.path": {
                          "color": "${palette.text}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "string.special.symbol": {
                          "color": "${palette.pink}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "string.special.url": {
                          "color": "${palette.blue}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "character": {
                          "color": "${palette.mauve}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "character.special": {
                          "color": "${palette.pink}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "boolean": {
                          "color": "${palette.peach}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "number": {
                          "color": "${palette.peach}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "number.float": {
                          "color": "${palette.peach}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "tag": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "tag.attribute": {
                          "color": "${palette.yellow}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "tag.delimiter": {
                          "color": "${palette.muted}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "type": {
                          "color": "${palette.yellow}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "type.builtin": {
                          "color": "${palette.mauve}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "type.definition": {
                          "color": "${palette.yellow}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "type.interface": {
                          "color": "${palette.yellow}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "type.super": {
                          "color": "${palette.yellow}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "attribute": {
                          "color": "${palette.peach}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "property": {
                          "color": "${palette.blue}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "function": {
                          "color": "${palette.blue}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "function.builtin": {
                          "color": "${palette.peach}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "function.call": {
                          "color": "${palette.blue}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "function.macro": {
                          "color": "${palette.blue}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "function.method": {
                          "color": "${palette.blue}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "function.method.call": {
                          "color": "${palette.blue}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "constructor": {
                          "color": "${palette.pink}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "operator": {
                          "color": "${palette.sky}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.modifier": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.type": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.coroutine": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.function": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.operator": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.import": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.repeat": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.return": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.debug": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.exception": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.conditional": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.conditional.ternary": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.directive": {
                          "color": "${palette.pink}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.directive.define": {
                          "color": "${palette.pink}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "keyword.export": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "punctuation": {
                          "color": "${palette.muted}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "punctuation.delimiter": {
                          "color": "${palette.muted}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "punctuation.bracket": {
                          "color": "${palette.muted}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "punctuation.special": {
                          "color": "${palette.pink}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "punctuation.special.symbol": {
                          "color": "${palette.pink}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "punctuation.list_marker": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "comment": {
                          "color": "${palette.subtext}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "comment.doc": {
                          "color": "${palette.subtext}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "comment.documentation": {
                          "color": "${palette.subtext}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "comment.info": {
                          "color": "${palette.blue}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "comment.error": {
                          "color": "${palette.red}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "comment.warning": {
                          "color": "${palette.peach}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "comment.warn": {
                          "color": "${palette.peach}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "comment.hint": {
                          "color": "${palette.blue}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "comment.todo": {
                          "color": "${palette.pink}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "comment.note": {
                          "color": "${palette.text}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "diff.plus": {
                          "color": "${palette.green}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "diff.minus": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "parameter": {
                          "color": "${palette.salmon}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "field": {
                          "color": "${palette.text}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "namespace": {
                          "color": "${palette.yellow}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "float": {
                          "color": "${palette.peach}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "symbol": {
                          "color": "${palette.pink}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "string.regex": {
                          "color": "${palette.peach}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "text": {
                          "color": "${palette.text}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "emphasis.strong": {
                          "color": "${palette.salmon}",
                          "font_style": null,
                          "font_weight": 700
                      },
                      "emphasis": {
                          "color": "${palette.salmon}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "embedded": {
                          "color": "${palette.salmon}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "text.literal": {
                          "color": "${palette.mauve}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "concept": {
                          "color": "${palette.yellow}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "enum": {
                          "color": "${palette.yellow}",
                          "font_style": null,
                          "font_weight": 700
                      },
                      "function.decorator": {
                          "color": "${palette.peach}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "type.class.definition": {
                          "color": "${palette.yellow}",
                          "font_style": null,
                          "font_weight": 700
                      },
                      "hint": {
                          "color": "${palette.dim}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "link_text": {
                          "color": "${palette.text}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "link_uri": {
                          "color": "${palette.blue}",
                          "font_style": "italic",
                          "font_weight": null
                      },
                      "parent": {
                          "color": "${palette.peach}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "predictive": {
                          "color": "${palette.dim}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "predoc": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "primary": {
                          "color": "${palette.salmon}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "tag.doctype": {
                          "color": "${palette.mauve}",
                          "font_style": null,
                          "font_weight": null
                      },
                      "string.doc": {
                        "color": "${palette.mauve}",
                        "font_style": "italic",
                        "font_weight": null
                      },
                      "title": {
                          "color": "${palette.text}",
                          "font_style": null,
                          "font_weight": 800
                      },
                      "variant": {
                          "color": "${palette.red}",
                          "font_style": null,
                          "font_weight": null
                      }
                  }
              }
          }
      ]
  }
''
