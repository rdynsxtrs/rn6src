DESTDIR =
sysconfdir = /etc
prefix     = /usr
docdir     = $(prefix)/share/doc/sysv-rc
bindir     = $(prefix)/bin
sbindir    = $(prefix)/sbin

INSTALL      = install -m755 -o root -g root
INSTALL_DATA = install -m644 -o root -g root

all:

install:
	$(INSTALL) -d $(DESTDIR)$(docdir)/.
	$(INSTALL) -d $(DESTDIR)/var/lib/insserv
	$(INSTALL) -d $(DESTDIR)$(sysconfdir)/.
	$(INSTALL_DATA) doc/* $(DESTDIR)$(docdir)/.
	cp -af etc/* $(DESTDIR)$(sysconfdir)
	find $(DESTDIR)$(sysconfdir) -type d -name .svn -print0 |xargs -r0 rm -r

	for N in 2 3 4 5 ; do \
		$(INSTALL) -d $(DESTDIR)$(sysconfdir)/rc$${N}.d ; \
		$(INSTALL_DATA) rc2-5.d-README \
			$(DESTDIR)$(sysconfdir)/rc$${N}.d/README ; \
	done
	chmod 644 $(DESTDIR)$(sysconfdir)/init.d/README
	chmod -R go=u-w $(DESTDIR)$(sysconfdir)
	chown -R root:root $(DESTDIR)$(sysconfdir)

	$(INSTALL) -d $(DESTDIR)/usr/share/sysv-rc/.
	$(INSTALL) saveconfig $(DESTDIR)/usr/share/sysv-rc/saveconfig
