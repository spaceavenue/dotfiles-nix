{
  mgr.prepend_keymap = [
    {
      on = "M";
      run = "plugin mount";
    }
    {
      on = "T";
      run = "plugin toggle-pane min-parent";
      desc = "Show or hide the parent pane";
    }
  ];
}
