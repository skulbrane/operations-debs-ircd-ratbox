# $Id: Makefile.in 17051 2004-06-17 23:19:00Z androsyn $
CC		= gcc
INSTALL		= /usr/bin/install -c
INSTALL_BIN	= ${INSTALL}
INSTALL_DATA	= ${INSTALL} -m 644
INSTALL_SUID	= ${INSTALL} -o root -m 4755
RM		= /bin/rm
LEX		= flex
LEXLIB		= -lfl
CFLAGS		=  -O2 -Wall -g -fPIC -DPIC -DIRCD_PREFIX=\"/usr/local/ircd-ratbox\"
LDFLAGS		=  -Wl,-export-dynamic
MKDEP		= ${CC} -MM
MV		= /bin/mv
RM		= /bin/rm
CP		= /bin/cp
TOUCH		= /usr/bin/touch

prefix		= /usr/local/ircd-ratbox
exec_prefix	= ${prefix}
exec_suffix	= @exec_suffix@
bindir		= ${exec_prefix}/bin
libexecdir	= ${bindir}
confdir		= /usr/local/ircd-ratbox/etc
localstatedir	= ${prefix}
# Change this later! -- adrian
moduledir	= /usr/local/ircd-ratbox/modules
automoduledir	= /usr/local/ircd-ratbox/modules/autoload

# Local to the etc Makefile
mandir          = ${prefix}/man/man8
MANPAGES        = ircd.8

CONFS		= example.conf example.efnet.conf
DEFAULTCONFS	= kline.conf dline.conf xline.conf resv.conf

SSL_LIBS	= 
SSL_INCLUDES	= 

IRCDLIBS	= -ldl -lcrypt  $(SSL_LIBS)

INCLUDES	= -I../include $(SSL_INCLUDES)
CPPFLAGS	= ${INCLUDES} 
 
install-mkdirs:
	-@if test ! -d $(DESTDIR)$(confdir); then \
		echo "mkdir $(confdir)"; \
		mkdir $(DESTDIR)$(confdir); \
	fi

	-@if test ! -d $(DESTDIR)$(mandir); then \
		echo "mkdir $(mandir)"; \
		mkdir $(DESTDIR)$(mandir); \
	fi

install: install-mkdirs build
	@echo "ircd: installing example config files ($(CONFS))"
	@for i in $(CONFS); do \
		if test -f $(DESTDIR)$(confdir)/$$i; then \
			$(MV) $(DESTDIR)$(confdir)/$$i $(DESTDIR)$(confdir)/$$i.old; \
		fi; \
		$(INSTALL_DATA) $$i $(DESTDIR)$(confdir); \
	done

	@for i in $(DEFAULTCONFS); do \
		if test ! -f $(DESTDIR)$(confdir)/$$i; then \
			echo "ircd: creating config file ($$i)"; \
			${TOUCH} $(DESTDIR)$(confdir)/$$i; \
		fi; \
	done

	-@if test ! -f $(DESTDIR)$(confdir)/ircd.motd; then \
		echo "ircd: installing motd file (ircd.motd)"; \
		$(INSTALL_DATA) ircd.motd $(DESTDIR)$(confdir); \
	fi

	-@if test -f $(DESTDIR)$(confdir)/links.txt; then \
		$(RM) $(DESTDIR)$(confdir)/links.txt; \
	fi

	@echo "ircd: installing manpage"
	@for i in $(MANPAGES); do \
		if test ! -f $(DESTDIR)$(mandir)/$$i; then \
			$(INSTALL_DATA) $$i $(DESTDIR)$(mandir); \
		fi; \
	done

build:

clean:

depend:

lint:

distclean:
	${RM} -f Makefile
