{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*";
    flake-parts.url = "https://flakehub.com/f/hercules-ci/flake-parts/0.1.399";
  };

  outputs = inputs@{ flake-parts, ... }: flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "aarch64-darwin" ];

    perSystem = { pkgs, ... }: {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [ ruby ];
      };
    };
  };
}
