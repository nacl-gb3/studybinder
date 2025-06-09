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

        buildToolsVersion = "36.0.0";
        androidApiLevel = "36";

        androidEnv = pkgs.androidenv.override { licenseAccepted = true; };
        androidComposition = androidEnv.composeAndroidPackages {
          buildToolsVersions = [
            "34.0.0"
            buildToolsVersion
          ];
          platformVersions = [
            "34"
            "35"
            "latest"
            androidApiLevel
          ];

          includeSystemImages = true;
          systemImageTypes = [
            "google_apis"
          ];
          abiVersions = [ "x86_64" ];

          cmakeVersions = [
            "3.22.1"
            "latest"
          ];

          includeEmulator = true;
          includeNDK = true;

          extraLicenses = [
            "android-googletv-license"
            "android-sdk-arm-dbt-license"
            "android-sdk-license"
            "android-sdk-preview-license"
            "google-gdk-license"
            "intel-android-extra-license"
            "intel-android-sysimage-license"
            "mips-android-sysimage-license"
          ];
        };

        androidSdk = androidComposition.androidsdk;
      in
      rec {
        packages.android-emulator = pkgs.androidenv.emulateApp {
          name = "emulate-MyAndroidApp";
          platformVersion = "${androidApiLevel}";
          abiVersion = "x86_64"; # mips, x86, x86_64
          systemImageType = "google_apis";
          enableGPU = true;
        };

        app.android-emulator = {
          type = "app";
          program = "${packages.android-emulator}/bin/run-test-emulator";
        };

        devShells.default = pkgs.mkShell rec {
          packages = [ ];
          nativeBuildInputs = [ ];
          buildInputs = [
            pkgs.flutter
            androidSdk
            pkgs.jdk

            # C libraries
            pkgs.atk
            pkgs.cairo
            pkgs.clang
            pkgs.cmake
            pkgs.libepoxy
            pkgs.libGL
            pkgs.vulkan-loader
            pkgs.gdk-pixbuf
            pkgs.glib
            pkgs.gtk3
            pkgs.harfbuzz
            pkgs.ninja
            pkgs.pango
            pkgs.pcre
            pkgs.pkg-config
            pkgs.xorg.libX11
            pkgs.xorg.xorgproto
            pkgs.mesa-demos
          ];
          QT_QPA_PLATFORM = "xcb";
          CPATH = "${pkgs.xorg.libX11.dev}/include:${pkgs.xorg.xorgproto}/include";
          LD_LIBRARY_PATH =
            with pkgs;
            lib.makeLibraryPath [
              atk
              cairo
              libepoxy
              libGL
              vulkan-loader
              gdk-pixbuf
              glib
              gtk3
              harfbuzz
              pango
            ];
          JAVA_HOME = "${pkgs.jdk}/lib/openjdk";
          ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
          ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
          ANDROID_NDK_ROOT = "${ANDROID_HOME}/ndk-bundle";
          FLUTTER_SDK = "${pkgs.flutter}";
          GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${ANDROID_HOME}/build-tools/${buildToolsVersion}/aapt2";
        };
      }
    );
}
