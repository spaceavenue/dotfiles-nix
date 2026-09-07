let
  palette = import ../lib/palette.nix;
in
''
  #![enable(implicit_some)]
  #![enable(unwrap_newtypes)]
  #![enable(unwrap_variant_newtypes)]
  (
      default_album_art_path: None,
      format_tag_separator: " | ",
      browser_column_widths: [20, 38, 42],
      background_color: None,
      text_color: Some("${palette.muted}"),
      header_background_color: None,
      modal_background_color: None,
      modal_backdrop: false,
      preview_label_style: (fg: "${palette.red}"),
      preview_metadata_group_style: (fg: "${palette.text}", modifiers: "Bold"),
      highlighted_item_style: (fg: "${palette.base}", bg: "${palette.text}", modifiers: "Bold"),
      current_item_style: (fg: "${palette.red}", modifiers: "Bold"),
      borders_style: (fg: "${palette.text}"),
      highlight_border_style: (fg: "${palette.text}"),
  	symbols: (
          song: "S",
          dir: "D",
          playlist: "P",
          marker: "M",
          ellipsis: "...",
          song_style: None,
          dir_style: None,
          playlist_style: None,
          marker_style: None,
          song_highlighted_style: None,
          dir_highlighted_style: None,
          playlist_highlighted_style: None,
          marker_highlighted_style: None,
          song_current_style: None,
          dir_current_style: None,
          playlist_current_style: None,
          marker_current_style: None,
      ),
      level_styles: (
          info: (fg: "${palette.red}", bg: "black"),
          warn: (fg: "${palette.text}", bg: "black"),
          error: (fg: "red", bg: "black"),
          debug: (fg: "${palette.mauve}", bg: "black"),
          trace: (fg: "${palette.muted}", bg: "black"),
      ),
      progress_bar: (
          symbols: ["-", "-", ">", " ", ">"],
          track_style: (fg: "${palette.muted}"),
          elapsed_style: (fg: "${palette.red}"),
          thumb_style: (fg: "${palette.text}"),
          use_track_when_empty: true,
      ),
      scrollbar: None,
      tab_bar: (
          active_style: (fg: "${palette.base}", bg: "${palette.text}", modifiers: "Bold"),
          inactive_style: (fg: "${palette.red}"),
      ),
      lyrics: (
          timestamp: false
      ),
      browser_song_format: [
          (
              kind: Group([
                  (kind: Property(Track)),
                  (kind: Text(" ")),
              ])
          ),
          (
              kind: Group([
                  (kind: Property(Artist)),
                  (kind: Text(" - ")),
                  (kind: Property(Title)),
              ]),
              default: (kind: Property(Filename))
          ),
      ],
      song_table_format: [
          (
              prop: (
  				kind: Property(Artist),
                  default: (kind: Text("Unknown"))
              ),
              label_prop: (kind: Text("Artist")),
              width: "20%",
          ),
          (
              prop: (
  				kind: Property(Title),
                  default: (kind: Text("Unknown"))
              ),
              label_prop: (kind: Text("Title")),
              width: "35%",
          ),
          (
              prop: (
  				kind: Property(Album), style: (fg: "${palette.muted}"),
                  default: (kind: Text("Unknown Album"), style: (fg: "${palette.muted}"))
              ),
              label_prop: (kind: Text("Album")),
              width: "30%",
          ),
          (
              prop: (
  				kind: Property(Duration),
                  default: (kind: Text("-"))
              ),
              label_prop: (kind: Text("Duration")),
              width: "15%",
              alignment: Right,
          ),
      ],
      layout: Split(
          direction: Vertical,
          panes: [
              (
                  pane: Pane(Tabs),
                  borders: "ALL",
                  border_symbols: Rounded,
                  size: "3",
              ),
              (
                  pane: Pane(TabContent),
                  size: "100%",
              ),
              (
                  size: "4",
                  borders: "ALL",
                  border_symbols: Rounded,
                  pane: Split(
                      direction: Vertical,
                      panes: [
                          (
                              size: "1",
                              pane: Split(
                                  direction: Horizontal,
                                  panes: [
  									(
  										size: "1",
  										pane: Pane(Property(content: [(kind: Text(" "))])),
  									),
                                      (
                                          size: "100%",
                                          pane: Pane(ProgressBar),
                                      ),
                                      (
                                          size: "26",
                                          pane: Component("elapsed_and_bitrate"),
                                      ),
                                  ]
                              ),
                          ),
                          (
                              size: "1",
                              pane: Split(
                                  direction: Horizontal,
                                  panes: [
  									(
  										size: "10",
  										pane: Component("song_status"),
  									),
                                      (
                                          size: "100%",
                                          pane: Component("song_info"),
                                      ),
                                      (
                                          size: "42",
                                          pane: Component("volume_and_states"),
                                      ),
                                  ]
                              ),
                          ),
                      ]
                  ),
              ),
          ],
      ),
      components: {
  		"elapsed_and_bitrate": Pane(Property(
              content: [
                  (kind: Property(Status(Elapsed)), style: (fg: "${palette.red}")),
                  (kind: Text(" / "), style: (fg: "${palette.mauve}")),
                  (kind: Property(Status(Duration)), style: (fg: "${palette.red}")),
                  (kind: Group([
  						(kind: Text(" ("), style: (fg: "${palette.mauve}")),
  						(kind: Property(Status(Bitrate)), style: (fg: "${palette.mauve}")),
  						(kind: Text(" kbps)"), style: (fg: "${palette.mauve}")),
                  ])),
              ],
              align: Right,
          )),
  		"song_status": Pane(Property(
  			content: [
  				(kind: Text("["), style: (fg: "${palette.text}", modifiers: "Bold")),
                  (kind: Property(Status(StateV2())), style: (fg: "${palette.text}", modifiers: "Bold")),
                  (kind: Text("] "), style: (fg: "${palette.text}", modifiers: "Bold")),
  			],
  			align: Left,
  		)),
          "song_info": Pane(Property(
              content: [
                  (
  					kind: Property(Song(Title)), style: (fg: "${palette.text}", modifiers: "Bold"), 
  					default: (kind: Text("No Song"), style: (fg: "${palette.text}", modifiers: "Bold"))
  				),
                  (kind: Text(" by "), style: (fg: "${palette.mauve}")),
                  (
  					kind: Property(Song(Artist)), style: (fg: "${palette.red}", modifiers: "Bold"), 
  					default: (kind: Text("Unknown"), style: (fg: "${palette.red}", modifiers: "Bold"))
  				),
  				(kind: Text(" in "), style: (fg: "${palette.mauve}")),
  				(
  					kind: Property(Song(Album)), style: (fg: "${palette.red}", modifiers: "Bold"), 
  					default: (kind: Text("Unknown"), style: (fg: "${palette.red}", modifiers: "Bold"))
  				),
              ],
              align: Left,
              scroll_speed: 1,
          )),
          "volume_and_states": Split(
              direction: Horizontal,
              panes: [
                  (
  					size: "9", 
  					pane: Pane(Property(
  						content: [(kind: Text("[Volume] "), style: (fg: "${palette.text}", modifiers: "Bold"))], 
  						align: Right
  					))
  				),
                  (
  					size: "100%", 
  					pane: Pane(Volume(
  						kind: Slider(
  							symbols: (filled: "─", thumb: "●", track: "─"),
  							track_style: (fg: "${palette.muted}"),
  							filled_style: (fg: "${palette.red}"),
  							thumb_style: (fg: "${palette.text}"),
  						),
  					))
  				),
                  (
  					size: "5", 
  					pane: Pane(Property(
  						content: [(kind: Property(Status(Volume)), style: (fg: "${palette.red}"))], 
  						align: Right
  					))
  				),
                  (size: "2", pane: Pane(Property(content: [(kind: Text("% "), style: (fg: "${palette.red}"))]))),
                  (size: "6", pane: Component("states")),
              ]
          ),
          "states": Pane(Property(
              content: [
                  (kind: Text("["), style: (fg: "${palette.mauve}", modifiers: "Bold")),
                  (kind: Property(Status(RepeatV2(
                      on_label: "z",
                      off_label: "z",
                      on_style: (fg: "${palette.mauve}", modifiers: "Bold"),
                      off_style: (fg: "${palette.muted}"),
                  )))),
                  (kind: Property(Status(RandomV2(
                      on_label: "x",
                      off_label: "x",
                      on_style: (fg: "${palette.mauve}", modifiers: "Bold"),
                      off_style: (fg: "${palette.muted}"),
                  )))),
                  (kind: Property(Status(ConsumeV2(
                      on_label: "c",
                      off_label: "c",
                      oneshot_label: "c",
                      on_style: (fg: "${palette.mauve}", modifiers: "Bold"),
                      off_style: (fg: "${palette.muted}"),
                      oneshot_style: (fg: "${palette.red}"),
                  )))),
                  (kind: Property(Status(SingleV2(
                      on_label: "v",
                      off_label: "v",
                      oneshot_label: "v",
                      on_style: (fg: "${palette.mauve}", modifiers: "Bold"),
                      off_style: (fg: "${palette.muted}"),
                      oneshot_style: (fg: "${palette.text}"),
                  )))),
                  (kind: Text("]"), style: (fg: "${palette.mauve}", modifiers: "Bold")),
              ],
              align: Right,
          )),
      },
  )
''
