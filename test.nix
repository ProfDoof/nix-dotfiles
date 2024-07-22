{
  systemd.tmpfiles.rules = 
  let
    perms = "- gdm gdm -";
    mkTmpfileRules = name: contents:
      [ "f+ ${name} ${perms}"] ++ map (l: "w+ ${name} - - - - ${l}") (builtins.filter builtins.isString (builtins.split "\n" contents));
  in
    mkTmpfileRules "/run/gdm/.config/monitors.xml" 
      ''
        <monitors version="2">
          <configuration>
            <logicalmonitor>
              <x>0</x>
              <y>0</x>
              <scale>2</scale>
              <primary>yes</primary>
              <monitor>
                <monitorspec>
                  <connector>eDP-1</connector>
                  <vendor>unknown</vendor>
                  <product>unknown</product>
                  <serial>unknown</serial>
                </monitorspec>
                <mode>
                  <width>4112</width>
                  <height>2572</height>
                  <rate>60</rate>
                </mode>
              </monitor>
            </logicalmonitor>
          </configuration>
        </monitors>
      '';
}
