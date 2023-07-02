ext_PACKAGES   += gd
gd_DESCRIPTION := GD
gd_EXTENSIONS  := gd
gd_config      := \
	--with-gd=shared,/usr \
	--enable-gd-native-ttf \
	--with-jpeg-dir=/usr \
	--with-xpm-dir=/usr/X11R6 \
	--with-png-dir=/usr \
	--with-freetype-dir=/usr \
	--with-webp-dir=/usr
export gd_EXTENSIONS
export gd_DESCRIPTION
