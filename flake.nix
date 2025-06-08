{
  description = "A basic flake with a shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
        };
        androidSdk = pkgs.androidenv.androidPkgs.androidsdk;
        buildToolsVersion = "34.0.0";
      in
      {
        devShells.default = pkgs.mkShell rec {
          packages = [ ];
          nativeBuildInputs = [ ];
          buildInputs = with pkgs; [
            flutter
            androidsdk
            jdk
            steam-run

            # C libraries
            atk
            cairo
            clang
            cmake
            libepoxy
            gdk-pixbuf
            glib
            gtk3
            harfbuzz
            ninja
            pango
            pcre
            pkg-config
            xorg.libX11
            xorg.xorgproto
          ];

          CPATH = "${pkgs.xorg.libX11.dev}/include:${pkgs.xorg.xorgproto}/include";
          LD_LIBRARY_PATH =
            with pkgs;
            lib.makeLibraryPath [
              atk
              cairo
              libepoxy
              gdk-pixbuf
              glib
              gtk3
              harfbuzz
              pango
            ];
          ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
          GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${ANDROID_HOME}/build-tools/${buildToolsVersion}/aapt2";
        };
      }
    );
}
