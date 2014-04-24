#
# Makefile.in for ircd/src
#
# $Id: Makefile.in 22994 2006-08-22 10:15:07Z leeh $
#
CC		= gcc
INSTALL		= /usr/bin/install -c
INSTALL_BIN	= ${INSTALL}
INSTALL_DATA	= ${INSTALL} -m 644
INSTALL_SUID	= ${INSTALL} -o root -m 4755
RM		= /bin/rm
LEX		= flex
LEXLIB		= -lfl
CFLAGS		=  -O2 -Wall -g -fPIC -DPIC -DIRCD_PREFIX=\"/usr/local/ircd-ratbox\"
LDFLAGS   	=  -Wl,-export-dynamic
MKDEP		= gcc -MM -DIRCD_PREFIX=\"/usr/local/ircd-ratbox\"
MV		= /bin/mv
RM		= /bin/rm
YACC		= bison -y
prefix		= /usr/local/ircd-ratbox
exec_prefix	= ${prefix}
bindir		= ${exec_prefix}/bin
libexecdir	= ${bindir}

DOLLAR = $$

IRCD_EXE	= ircd

PROGS		= $(IRCD_EXE)

SSL_LIBS	= 
SSL_INCLUDES	= 

IRCDLIBS	=  -L../adns -ladns -ldl -lcrypt  $(SSL_LIBS)

INCLUDES	= -I../include -I../adns $(SSL_INCLUDES)
CPPFLAGS	= ${INCLUDES} 
 
default:	all

y.tab.o:	y.tab.c ircd_parser.y
	${CC} ${CPPFLAGS} ${CFLAGS} -I. -c y.tab.c

# Note GNU bison uses <file>.tab.c not y.tab.c
y.tab.c:	ircd_parser.y
	${YACC} -d ircd_parser.y

lex.yy.o:	lex.yy.c ircd_lexer.l
	${CC} ${CPPFLAGS} ${CFLAGS} -I. -c lex.yy.c

lex.yy.c:	ircd_lexer.l
	${LEX} ircd_lexer.l

BASE_SRCS =                     \
  adns.c                        \
  balloc.c			\
  cache.c			\
  channel.c                     \
  class.c                       \
  client.c                      \
  commio.c			\
  event.c                       \
  getopt.c                      \
  hash.c                        \
  hook.c                        \
  hostmask.c			\
  irc_string.c                  \
  ircd.c                        \
  ircd_signal.c                 \
  kdparse.c			\
  linebuf.c                     \
  listener.c                    \
  match.c                       \
  memory.c                      \
  modules.c                     \
  monitor.c			\
  newconf.c			\
  numeric.c                     \
  packet.c                      \
  parse.c                       \
  patricia.c			\
  reject.c			\
  restart.c                     \
  s_auth.c                      \
  s_conf.c                      \
  s_newconf.c			\
  s_gline.c                     \
  s_log.c                       \
  s_serv.c                      \
  s_stats.c                     \
  s_user.c                      \
  scache.c                      \
  send.c                        \
  snprintf.c			\
  tools.c                       \
  whowas.c

SRCS = ${BASE_SRCS}   epoll.c

OBJS = ${SRCS:.c=.o}

all: ircd

build: all

ircd: $(OBJS) y.tab.o lex.yy.o version.o
	${CC} ${CFLAGS} ${LDFLAGS} -o $@ ${OBJS} lex.yy.o y.tab.o version.o ${IRCDLIBS} ${LEXLIB}
	mv version.c version.c.last

install-mkdirs:
	-@if test ! -d $(DESTDIR)$(prefix); then \
		echo "ircd: setting up ircd directory structure"; \
		mkdir $(DESTDIR)$(prefix); \
	fi
	-@if test ! -d $(DESTDIR)$(exec_prefix); then \
		mkdir $(DESTDIR)$(exec_prefix); \
	fi
	-@if test ! -d $(DESTDIR)$(bindir); then \
		mkdir $(DESTDIR)$(bindir); \
	fi

install: install-mkdirs build
	-@if test -f $(DESTDIR)$(bindir)/ircd; then \
		echo "ircd: backing up ircd"; \
	fi
	@echo "ircd: installing ircd ($(PROGS))"
	@for i in $(PROGS); do \
		if test -f $(DESTDIR)$(bindir)/$$i; then \
			$(MV) $(DESTDIR)$(bindir)/$$i $(DESTDIR)$(bindir)/$$i.old; \
		fi; \
		$(INSTALL_BIN) $$i $(DESTDIR)$(bindir); \
	done

version.c: version.c.SH
	/bin/sh ./version.c.SH


# this is really the default rule for c files
.c.o:
	${CC} ${CPPFLAGS} ${CFLAGS} -c $<

.PHONY: depend clean distclean
depend:
	${MKDEP} ${CPPFLAGS} ${BASE_SRCS} lex.yy.c > .depend

clean:
	${RM} -f *.o *.exe *~ ircd.core core ircd 

lint:
	lint -aacgprxhH $(CPPFLAGS) -DIRCD_PREFIX=\"/usr/local/ircd-ratbox\" $(SRCS) >>../lint.out

distclean: clean
	${RM} -f Makefile version.c.last

include .depend
