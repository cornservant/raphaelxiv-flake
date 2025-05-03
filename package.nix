{
  lib,
  fetchFromGitHub,
  rustPlatform,
  libGL,
  wayland,
  libxkbcommon,
  copyDesktopItems,
  makeDesktopItem,
  makeWrapper,
}:
rustPlatform.buildRustPackage rec {
  pname = "raphael-xiv";
  version = "0.20.0";

  src = fetchFromGitHub {
    owner = "KonaeAkira";
    repo = "raphael-rs";
    rev = "v${version}";
    hash = "sha256-YGIp2TYItjGRMBls1UzwWDMNBEp72KRa3tkAPF0Y+qA=";
  };

  cargoPatches = [
    ./add-cargo-lock.patch
  ];

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "csbindgen-1.9.3" = "sha256-VwlGvBFpjYgcnOXQ6ChsKsI3S/HDsHrVXMGWE5/7De8=";
      "ecolor-0.31.1" = "sha256-CRz1f4ReStckezJnQKLzogz9UDrGOSBWraz6VffwVSQ=";
    };
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-YGIp2TYItjGRMBls1UzwWDMNBEp72KRa3tkAPF0Y+qA=";

  nativeBuildInputs = [
    makeWrapper
    copyDesktopItems
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "raphael-xiv";
      desktopName = "Raphael XIV";
      exec = "raphael-xiv";
    })
  ];

  postFixup = ''
    wrapProgram "$out/bin/raphael-xiv" \
      --prefix LD_LIBRARY_PATH : "${
        lib.makeLibraryPath [
          libGL
          libxkbcommon
          wayland
        ]
      }"
  '';
}
