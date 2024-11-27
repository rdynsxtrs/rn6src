ext_PACKAGES   += gd
gd_DESCRIPTION := GD
gd_EXTENSIONS  := gd
gd_config      := \
	--enable-gd=shared,/usr \
	--with-external-gd
export gd_EXTENSIONS
export gd_DESCRIPTION
