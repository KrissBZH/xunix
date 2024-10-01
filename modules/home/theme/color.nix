{ config, lib, ... }:
{
  options.color = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    description = "color";
  };
  config.color = {
    base00 = "2E3440";
    base01 = "3B4252";
    base02 = "434C5E";
    base03 = "4C566A";
    base04 = "AFB3BB";
    base05 = "C7CACE";
    base06 = "C1C1C1";
    base07 = "8FBCBB";
    base08 = "A47A7E";
    base09 = "D08770";
    base0A = "EBCB8B";
    base0B = "98A89C";
    base0C = "7f979d";
    base0D = "7D8E9F";
    base0E = "B48EAD";
    base0F = "D9B6B6";
    background = "1B1B1B";
  };
}
