all distclean clean:
	(cd giggle; make $@)
	(cd raw_resources; make -f Resources.mk $@)
