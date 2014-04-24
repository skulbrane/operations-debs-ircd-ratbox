#
# Makefile.in for ircd/src
#
# $Id: Makefile.in 20583 2005-07-17 18:55:27Z leeh $
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
AR		= /usr/bin/ar
RANLIB		= /usr/bin/ranlib

prefix		= /usr/local/ircd-ratbox
exec_prefix	= ${prefix}
bindir		= ${exec_prefix}/bin
libexecdir	= ${bindir}
sysconfdir	= ${prefix}/etc
localstatedir	= ${prefix}
# Change this later! -- adrian
moduledir	= /usr/local/ircd-ratbox/modules
automoduledir	= /usr/local/ircd-ratbox/modules/autoload

INCLUDES	= -I../include -I.
CPPFLAGS	= ${INCLUDES} 
 
default:	all

BASE_SRCS = check.c event.c general.c parse.c query.c reply.c setup.c \
		transmit.c types.c


SRCS = ${BASE_SRCS} ${SELECT_SRC}

OBJS = ${SRCS:.c=.o}

all:	libadns.a

build:	all

libadns.a: ${OBJS}
		rm -f $@
		${AR} cqv $@ ${OBJS}
		${RANLIB} $@

# this is really the default rule for c files
.c.o:
	${CC} ${CPPFLAGS} ${CFLAGS} -c $<

.PHONY: depend clean distclean

install: 

depend:
	@${MKDEP} ${CPPFLAGS} ${BASE_SRCS} ${EXTRA_SRCS} > .depend.tmp
	@sed -e '/^# DO NOT DELETE THIS LINE/,$$d' <Makefile >Makefile.depend
	@echo '# DO NOT DELETE THIS LINE!!!' >>Makefile.depend
	@echo '# make depend needs it.' >>Makefile.depend
	@cat .depend.tmp >>Makefile.depend
	@mv Makefile.depend Makefile
	@rm -f .depend.tmp

clean:
	${RM} -f *.o *.exe *~ libadns.a

lint:

distclean: clean
	${RM} -f Makefile version.c.last

# DO NOT DELETE THIS LINE!!!
# make depend needs it.
