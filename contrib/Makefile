#
# Makefile.in for ircd/contrib
#
# $Id: Makefile.in 23071 2006-09-25 14:30:08Z androsyn $
#
CC		= gcc
RM		= /bin/rm
SED             = /bin/sed
LEX		= flex
LEXLIB		= -lfl
CFLAGS		=  -O2 -Wall -g -fPIC -DPIC -DIRCD_PREFIX=\"/usr/local/ircd-ratbox\"
PICFLAGS	= -fPIC -DPIC -shared
MKDEP		= gcc -MM
INSTALL		= /usr/bin/install -c
INSTALL_PROGRAM	= ${INSTALL}
INSTALL_DATA	= ${INSTALL} -m 644
INSTALL_SUID    = ${INSTALL} -o root -m 4755
SHELL		= /bin/sh
AUTOMODULEDIR	= /usr/local/ircd-ratbox/modules/contrib

SSL_LIBS	= 
SSL_INCLUDES	= 

IRCDLIBS	= -ldl -lcrypt  $(SSL_LIBS)

INCLUDES	= -I../include -I../adns $(SSL_INCLUDES)
CPPFLAGS	= ${INCLUDES} 

SRCS =                          \
  m_clearchan.c			\
  m_flags.c                     \
  m_force.c			\
  m_mkpasswd.c                  \
  m_ojoin.c			\
  m_olist.c			\
  m_okick.c			\
  m_opme.c			\
  m_webirc.c			\
  spy_admin_notice.c		\
  spy_info_notice.c		\
  spy_links_notice.c		\
  spy_motd_notice.c		\
  spy_stats_notice.c            \
  spy_stats_p_notice.c		\
  spy_whois_notice.c            \
  spy_whois_notice_global.c	\
  example_module.c

OBJS = ${SRCS:.c=.so}

default:	build
build: all
all: $(OBJS)

install: all
	-@if test ! -d $(DESTDIR)$(AUTOMODULEDIR); then \
                mkdir $(DESTDIR)$(AUTOMODULEDIR); \
        fi
	@echo "Installing modules into $(DESTDIR)$(AUTOMODULEDIR) .."
	@for file in $(OBJS); do \
		$(INSTALL_DATA) $$file $(DESTDIR)$(AUTOMODULEDIR); \
	done

.SUFFIXES: .so

.c.so:
	${CC} ${PICFLAGS}  ${CPPFLAGS} ${CFLAGS} $< -o $@

.PHONY: depend clean distclean
depend:
	@${MKDEP} ${CPPFLAGS} ${SRCS} > .depend
	@sed s/\\\.o/\\\.so/ < .depend > .depend.tmp
	@sed -e '/^# DO NOT DELETE THIS LINE/,$$d' <Makefile >Makefile.depend
	@echo '# DO NOT DELETE THIS LINE!!!' >>Makefile.depend
	@echo '# make depend needs it.' >>Makefile.depend
	@cat .depend.tmp >>Makefile.depend
	@mv Makefile.depend Makefile
	@rm -f .depend.tmp .depend

clean:
	${RM} -f *.so *~ 

distclean: clean
	${RM} -f Makefile

