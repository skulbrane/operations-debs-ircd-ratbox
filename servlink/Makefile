#
# Makefile.in for servlink/src
#
# $Id: Makefile.in 17051 2004-06-17 23:19:00Z androsyn $
#

CC              = gcc
INSTALL         = /usr/bin/install -c
INSTALL_BIN     = ${INSTALL}
INSTALL_DATA    = ${INSTALL} -m 644
INSTALL_SUID    = ${INSTALL} -o root -m 4755
RM              = /bin/rm
LEX             = flex
LEXLIB          = -lfl
CFLAGS          =  -O2 -Wall -g -fPIC -DPIC -DIRCD_PREFIX=\"/usr/local/ircd-ratbox\"
LDFLAGS         =  -Wl,-export-dynamic
MKDEP           = gcc -MM -DIRCD_PREFIX=\"/usr/local/ircd-ratbox\"
MV              = /bin/mv
RM              = /bin/rm
prefix          = /usr/local/ircd-ratbox
exec_prefix     = ${prefix}
bindir          = ${exec_prefix}/bin
libexecdir      = ${bindir}
confdir         = /usr/local/ircd-ratbox/etc
localstatedir   = ${prefix}

ZIP_LIB		= 

IRCDLIBS        = -ldl -lcrypt  $(ZIP_LIB)

INCLUDES        = -I. -I../include $(SSL_INCLUDES)
CPPFLAGS        = ${INCLUDES} 

PROGS		= servlink

SOURCES =     \
  servlink.c  \
  io.c        \
  control.c
  

OBJECTS = ${SOURCES:.c=.o}

all: servlink

build: all

servlink: ${OBJECTS}
	${CC} ${CFLAGS} ${LDFLAGS} -o $@ ${OBJECTS} ${IRCDLIBS}

install: build
	@echo "ircd: installing servlink ($(PROGS))"
	@for i in $(PROGS); do \
                if test -f $(DESTDIR)$(bindir)/$$i; then \
                        $(MV) $(DESTDIR)$(bindir)/$$i $(DESTDIR)$(bindir)/$$i.old; \
                fi; \
                $(INSTALL_BIN) $$i $(DESTDIR)$(bindir); \
        done

.c.o:
	${CC} ${CPPFLAGS} ${CFLAGS} -c $<

.PHONY: depend clean distclean
depend:
	@${MKDEP} ${CPPFLAGS} ${SOURCES} > .depend.tmp
	@sed -e '/^# DO NOT DELETE THIS LINE/,$$d' <Makefile >Makefile.depend
	@echo '# DO NOT DELETE THIS LINE!!!' >>Makefile.depend
	@echo '# make depend needs it.' >>Makefile.depend
	@cat .depend.tmp >>Makefile.depend
	@mv Makefile.depend Makefile
	@rm -f .depend.tmp

clean:
	${RM} -f *.o *~ *.core core servlink

lint:
	lint -aacgprxhH $(CPPFLAGS) -DIRCD_PREFIX=\"/usr/local/ircd-ratbox\" $(SOURCES) >>../lint.out

distclean: clean
	${RM} -f Makefile

# End of Makefile
