{
  networking.hostName = "nyx";

  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };
  networking.useDHCP = false;

  services.dnsmasq = {
    enable = true;
    settings = {
      listen-address = "127.0.0.1";
      interface = "lo";
      bind-interfaces = true;
      no-resolv = true;
      server = [
        "9.9.9.9"
        "1.1.1.1"
      ];
      cache-size = 10000;
    };
  };
}
