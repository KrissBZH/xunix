{ pkgs, lib, ... }:
{
  fonts = {
    fontDir.enable = true;
    packages = lib.attrValues {
      inherit (pkgs)
        emacs-all-the-icons-fonts
        material-design-icons
        noto-fonts-emoji
        wqy_zenhei
        sarasa-gothic
        ;

      nerdfonts = pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; };
    };

    enableDefaultPackages = false;
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "Sarasa Gothic J"
          "Sarasa Gothic K"
          "Sarasa Gothic SC"
          "Sarasa Gothic TC"
          "Sarasa Gothic HC"
          "Sarasa Gothic CL"
        ];

        sansSerif = [
          "Sarasa Gothic J"
          "Sarasa Gothic K"
          "Sarasa Gothic SC"
          "Sarasa Gothic TC"
          "Sarasa Gothic HC"
          "Sarasa Gothic CL"
        ];

        monospace = [
          "Sarasa Mono J"
          "Sarasa Mono K"
          "Sarasa Mono SC"
          "Sarasa Mono TC"
          "Sarasa Mono HC"
          "Sarasa Mono CL"
        ];

        emoji = [
          "Noto Color Emoji"
          "Material Design Icons"
        ];
      };
    };
  };
}
