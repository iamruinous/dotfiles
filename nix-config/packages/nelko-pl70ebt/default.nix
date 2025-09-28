{
  stdenv,
  fetchurl,
  cups,
  dpkg,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "nelko-pl70ebt-driver";
  version = "3.0.1.407";

  src = fetchurl {
    url = "https://cdn.shopify.com/s/files/1/0657/6626/0980/files/NELKO_PL70e-BT_Linux_v${version}.deb";
    # Replace this with the actual hash from the build error
    sha256 = "sha256-IinWigCaA9WVWTeTL6x+AXQyvBGCUbOKu1shjYjabUY=";
  };

  buildInputs = [cups];

  nativeBuildInputs = [dpkg];

  installPhase = ''
    # Create the necessary directories in the output
    install -d $out/share/cups/model/Nelko
    install -d $out/lib/cups/filter/Nelko/Filter
    install -d $out/lib/cups/filter/Nelko/PPDs

    # Copy the PPD file and the filter executable
    # The exact paths might differ, you may need to inspect the extracted contents
    install -m 644 usr/share/cups/model/Nelko/PL420.ppd $out/share/cups/model/Nelko/
    install -m 644 usr/share/cups/model/Nelko/PL70e-BT.ppd $out/share/cups/model/Nelko/
    install -m 644 usr/lib/cups/filter/Nelko/PPDs/PL420.ppd $out/lib/cups/filter/Nelko/PPDs/
    install -m 644 usr/lib/cups/filter/Nelko/PPDs/PL70e-BT.ppd $out/lib/cups/filter/Nelko/PPDs/
    install -m 755 usr/lib/cups/filter/Nelko/Filter/rastertolabel $out/lib/cups/filter/Nelko/Filter/
  '';

  meta = {
    description = "Nelko PL70e-BT printer driver";
    homepage = "https://nelkoprint.com/";
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
    maintainers = [lib.maintainers.jmeskill];
  };
}
