ext_PACKAGES    += zip
zip_DESCRIPTION := Zip
zip_EXTENSIONS  := zip
zip_config = \
	--with-zip=shared
export zip_EXTENSIONS
export zip_DESCRIPTION
