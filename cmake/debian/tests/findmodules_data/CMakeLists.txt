cmake_minimum_required(VERSION 3.0)

foreach(VTEST ALSA Armadillo BISON Boost BZip2 Cups CURL CVS Doxygen EXPAT FLEX
        Freetype Gettext GIF Git GnuTLS GTK2 Hg HSPELL Icotool Java
        LibArchive LibLZMA LibXml2 LibXslt OpenSceneGraph Perl PhysFS
        PkgConfig PythonInterp PythonLibs Ruby Protobuf Subversion SWIG TIFF ZLIB)
    find_package(${VTEST} REQUIRED)
endforeach()

find_package(ImageMagick COMPONENTS convert MagickCore Magick++ MagickWand REQUIRED)
