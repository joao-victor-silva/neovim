{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/22.05.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.sumneko-lua-language-server
    pkgs.lua.pkgs.luacheck
    pkgs.stylua
    pkgs.gh
  ];

  shellHook = ''
  '';

  DIAGNOSTICS = "luacheck:gitlint:cspell:codespell";
  FORMATTING = "stylua";
}

