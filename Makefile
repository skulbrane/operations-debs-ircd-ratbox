#************************************************************************
#*   IRC - Internet Relay Chat, Makefile
#*   Copyright (C) 1990, Jarkko Oikarinen
#*
#*   This program is free software; you can redistribute it and/or modify
#*   it under the terms of the GNU General Public License as published by
#*   the Free Software Foundation; either version 1, or (at your option)
#*   any later version.
#*
#*   This program is distributed in the hope that it will be useful,
#*   but WITHOUT ANY WARRANTY; without even the implied warranty of
#*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#*   GNU General Public License for more details.
#*
#*   You should have received a copy of the GNU General Public License
#*   along with this program; if not, write to the Free Software
#*   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#*
#*   $Id: Makefile.in 18107 2004-12-10 21:28:20Z leeh $
#*/

RM=/bin/rm
prefix		= /usr/local/ircd-ratbox
exec_prefix	= ${prefix}
bindir		= ${exec_prefix}/bin
mandir		= ${prefix}/man
moduledir	= /usr/local/ircd-ratbox/modules
helpdir		= /usr/local/ircd-ratbox/help
confdir		= /usr/local/ircd-ratbox/etc
logdir		= /usr/local/ircd-ratbox/logs

# Default CFLAGS
# CFLAGS = -g -O2 -DNDEBUG
CFLAGS		= 
# Developers CFLAGS
#CFLAGS= -g -O2 -Wunused -Wall -ggdb -pedantic -Wshadow -Wmissing-declarations

# Default make flags - you may want to uncomment this on a multicpu machine
#MFLAGS = -j 4

#
# For developers
#CFLAGS= -g -O2 -Wall

# You may need to define the FD_SETSIZE in order to overrule
# the system one.
#CFLAGS= -DNDEBUG -g -O2 -D"FD_SETSIZE=1024"
SHELL=/bin/sh
SUBDIRS=modules adns src tools servlink doc help
CLEANDIRS = ${SUBDIRS} contrib
RSA_FILES=rsa_respond/README rsa_respond/respond.c rsa_respond/Makefile

MAKE = make ${MFLAGS} 

all:	build


autoconf: configure.ac
	autoconf
	autoheader
	${RM} -f config.cache

build:
	-@if [ ! -f include/setup.h ] ; then \
		echo "Hmm...doesn't look like you've run configure..."; \
		echo "Doing so now."; \
		sh configure; \
	fi
	@for i in $(SUBDIRS); do \
		echo "build ==> $$i";\
		cd $$i;\
		${MAKE} build || exit; cd ..;\
	done

clean:
	${RM} -f *~ core rsa_respond.tar rsa_respond.tar.gz
	@for i in $(CLEANDIRS); do \
		echo "clean ==> $$i";\
		cd $$i;\
		${MAKE} clean; cd ..;\
	done
	-@if [ -f include/setup.h ] ; then \
	echo "To really restart installation, make distclean" ; \
	fi

distclean:
	${RM} -f Makefile *~ *.rej *.orig core ircd.core
	${RM} -f config.status config.cache config.log
	cd include; ${RM} -f setup.h *~ *.rej *.orig ; cd ..
	@for i in $(CLEANDIRS); do \
		echo "distclean ==> $$i";\
		cd $$i;\
		${MAKE} distclean; cd ..;\
	done

depend:
	@for i in $(SUBDIRS); do \
		echo "depend ==> $$i";\
		cd $$i;\
		${MAKE} depend; cd ..;\
	done

lint:
	@for i in $(SUBDIRS); do \
		echo "lint ==> $$i";\
		cd $$i;\
		${MAKE} lint; cd ..;\
	done

install-mkdirs:
	@echo "ircd: setting up ircd directory structure"
	-@if test ! -d $(DESTDIR)$(prefix); then \
		mkdir $(DESTDIR)$(prefix); \
	fi
	-@if test ! -d $(DESTDIR)$(bindir); then \
		mkdir $(DESTDIR)$(bindir); \
	fi
	-@if test ! -d $(DESTDIR)$(confdir); then \
		mkdir $(DESTDIR)$(confdir); \
	fi
	-@if test ! -d $(DESTDIR)$(mandir); then \
		mkdir $(DESTDIR)$(mandir); \
	fi
	-@if test ! -d $(DESTDIR)$(moduledir); then \
		mkdir $(DESTDIR)$(moduledir); \
	fi
	-@if test ! -d $(DESTDIR)$(helpdir); then \
		mkdir $(DESTDIR)$(helpdir); \
	fi
	-@if test ! -d $(DESTDIR)$(logdir); then \
		mkdir $(DESTDIR)$(logdir); \
	fi
	
install: install-mkdirs all
	@for i in $(SUBDIRS); do \
		echo "install ==> $$i";\
		cd $$i;\
		${MAKE} install; \
		cd ..; \
	done

rsa_respond:
	@cd tools;\
	echo "Creating rsa_respond.tar.gz";\
	tar cf ../rsa_respond.tar $(RSA_FILES);\
	cd ..;\
	gzip rsa_respond.tar
