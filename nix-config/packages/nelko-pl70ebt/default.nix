{
  stdenv,
  fetchurl,
  unzip,
  dpkg,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "nelko-pl70ebt-driver";
  version = "3.0.1.407";

  src = fetchurl {
    url = "https://cdn.shopify.com/s/files/1/0657/6626/0980/files/NELKO_PL70e-BT_Linux_v3.0.1.407.deb";
    # Replace this with the actual hash from the build error
    sha256 = "11v28s7z032ixg0z6x8g8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v8v";
  };

  nativeBuildInputs = [unzip dpkg];

  unpackPhase = ''
    # Extract the contents of the debian package
    dpkg -x $src .
  '';

  installPhase = ''
    # Create the necessary directories in the output
    install -d $out/share/cups/model
    install -d $out/lib/cups/filter

    # Copy the PPD file and the filter executable
    # The exact paths might differ, you may need to inspect the extracted contents
    install -m 644 usr/share/cups/model/Nelko_PL70e-BT.ppd $out/share/cups/model/
    install -m 755 usr/lib/cups/filter/rastertoNelko_PL70e-BT $out/lib/cups/filter/
  '';

  meta = {
    description = "Nelko PL70e-BT printer driver";
    homepage = "https://nelkoprint.com/";
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
    maintainers = [lib.maintainers.jmeskill];
  };
}
