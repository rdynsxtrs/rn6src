ext_PACKAGES       += sybase
sybase_DESCRIPTION := Sybase
sybase_EXTENSIONS  := pdo_dblib
pdo_dblib_config   := --with-pdo-dblib=shared,/usr
ifeq ($(PHP_MAJOR_VERSION),5)
sybase_EXTENSIONS  += mssql
mssql_config       := --with-mssql=shared,/usr
endif
export sybase_EXTENSIONS
export sybase_DESCRIPTION
