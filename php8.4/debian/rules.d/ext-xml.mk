ext_PACKAGES    += xml
xml_DESCRIPTION := DOM, SimpleXML, XML, and XSL
xml_EXTENSIONS  := dom simplexml xml xmlreader xmlwriter xsl
dom_config = --enable-dom=shared
simplexml_config = --enable-simplexml=shared
xml_config = --enable-xml=shared
xml_PRIORITY := 15
xmlreader_config = --enable-xmlreader=shared
xmlwriter_config = --enable-xmlwriter=shared
xsl_config      := --with-xsl=shared
export xml_PRIORITY
export xml_EXTENSIONS
export xml_DESCRIPTION
