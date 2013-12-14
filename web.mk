all:
	(cd giggle/engine ; make -f Web.mk main.js)
	(cd raw_resources; make -f Resources.mk $@)
	python ~/local/emsdk_portable/emscripten/1.5.6/tools/file_packager.py assets.dat --preload resources/ --preload giggle/engine_resources/ --pre-run --js-output=preload.js

clean distclean:
	(cd giggle/engine ; make -f Web.mk $@)
