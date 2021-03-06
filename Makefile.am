EXTRA_DIST		= autogen.sh .version make/release.mk \
			  make/git-version-gen make/gitlog-to-changelog \
			  cbox.in cbox.8 cbox.spec.in

SUBDIRS			= data hooks

AUTOMAKE_OPTIONS	= foreign

MAINTAINERCLEANFILES	= Makefile.in aclocal.m4 configure \
			  missing install-sh autoscan.log \
			  configure.scan

TARGET			= cbox

sbin_SCRIPTS		= $(TARGET)

man_MANS		= $(TARGET).8

$(TARGET): $(TARGET).in
	cat $< | sed \
		-e 's#VERSION#$(VERSION)#g' \
		-e 's#DATADIR#$(CBOXDATADIR)#g' \
		-e 's#LOGDIR#$(CBOXLOGDIR)#g' \
		-e 's#EMULATOR#$(CBOXEMULATOR)#g' \
		> $@-t && \
	chmod 755 $@-t && mv $@-t $@

cbox.spec: cbox.spec.in
	cat $< | sed \
		-e "s#RPM_VERSION#`echo $(VERSION)| tr -- - _`#g" \
		-e "s#VERSION#$(VERSION)#g" \
		> $@-t && \
	chmod 755 $@-t && mv $@-t $@

srpm: dist cbox.spec
	rpmbuild --define "_sourcedir $$PWD" \
	    --define "_specdir $$PWD" \
	    --define "_builddir $$PWD" \
	    --define "_srcrpmdir $$PWD" \
	    --define "_rpmdir $$PWD" \
	    --define "dist .any" \
	    --define "fedora 21" \
	    --define "rhel 7" \
	    --nodeps -bs cbox.spec

clean-local:
	rm -f $(TARGET)

install-exec-local:
			$(INSTALL) -d $(DESTDIR)/$(CBOXLOGDIR)

uninstall-local:
			rmdir $(DESTDIR)/$(LOGDIR) || :;

BUILT_SOURCES = .version
.version:
	echo $(VERSION) > $@-t && mv $@-t $@

dist-hook: gen-ChangeLog
	echo $(VERSION) > $(distdir)/.tarball-version

gen_start_date = 2000-01-01
.PHONY: gen-ChangeLog
gen-ChangeLog:
	if test -d .git; then 						\
		$(top_srcdir)/make/gitlog-to-changelog			\
			--since=$(gen_start_date) > $(distdir)/cl-t;	\
		rm -f $(distdir)/ChangeLog; 				\
		mv $(distdir)/cl-t $(distdir)/ChangeLog;		\
	fi
