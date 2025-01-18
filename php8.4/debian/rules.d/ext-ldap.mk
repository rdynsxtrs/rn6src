ext_PACKAGES     += ldap
ldap_DESCRIPTION := LDAP
ldap_EXTENSIONS  := ldap
ldap_config      := --with-ldap=shared,/usr \
	            --with-ldap-sasl
export ldap_EXTENSIONS
export ldap_DESCRIPTION
