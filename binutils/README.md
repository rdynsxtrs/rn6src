# binutils

The `binutils` package can't be built using the new `3.0 (quit)` format.
To build you need to unpack the contents of this directory using

`dpkg-source -x binutils_2.28-5+rnx1.dsc`

then change into the directory `binutils-2.28` that was created during the
extraction process and run `debuild -sa` in there.