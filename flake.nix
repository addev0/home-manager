# ./flake.nix
{
  description = "Nix Home-Manager Public Configuration (addev)";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    # Home-Manager and NixPkgs Source.
    nixpkgs.url = "github:nixos/nixpkgs/a0374025a863d007d98e3297f6aa46cc3141c2f0";
    utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

	outputs = { self, nixpkgs, utils, home-manager, ... } @inputs:
    let 
      mkPkgs = system: import nixpkgs {
        inherit system;

        overlays = [
          (final: prev: {
            # Define a fresh build for Tree-Sitter 0.26.1
            tree-sitter-nightly = prev.stdenv.mkDerivation rec {
              pname = "tree-sitter";
              version = "0.26.9";

              # 1. Fetch the official binary release
              src = prev.fetchurl {
              url = "https://github.com/tree-sitter/tree-sitter/releases/download/v${version}/tree-sitter-linux-x64.gz";
              # HASH DANCE:
              # 1. Set this to prev.lib.fakeHash
              # 2. Run 'home-manager switch'
              # 3. Copy the 'got: sha256-...' error hash and paste it here.
              # hash = prev.lib.fakeHash; 
              hash = "sha256-T2XI2boyo+NxmDAlabMwbwN/EtgxPj8ozfG4DJ8rOjo=";
              };

              # 2. We don't need to unpack a folder, we just have one file.
              dontUnpack = true;
              dontConfigure = true;
              dontBuild = true;

              # 3. Auto-patcher is needed to make the binary run on Nix
              nativeBuildInputs = [ prev.autoPatchelfHook ];
              buildInputs = [ prev.stdenv.cc.cc.lib ];

              # 4. Extract, Install, and chmod
              installPhase = ''
                mkdir -p $out/bin
                # Decompress the binary directly to the output path
                gunzip -c $src > $out/bin/tree-sitter
                chmod +x $out/bin/tree-sitter
              '';
            };
          })
        ];
      };

      system = "x86_64-linux";
      pkgs = mkPkgs system;

    in {
        #  FIXME: Replace 'hostName' with preferred config name and filename
        "hostName" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
            extra = {
              configs = "${self}/extra/configs";
              modules = "${self}/extra/modules";
            };
          };
          modules = [ ./hosts/hostName.nix ];   
        };

      packages = utils.lib.eachDefaultSystem (system: {
        default = (mkPkgs system).tree-sitter-nightly;
      });
    };
}
