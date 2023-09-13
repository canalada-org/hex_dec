hex_dec:
	gnatmake ventana_conversor  -o hex_dec -gnatf -g -I/usr/share/ada/adainclude/gtkada2 -aO/usr/lib/ada/adalib/gtkada2 -largs -L/usr/lib -lgtkada2 -lgtk-x11-2.0 -lgdk-x11-2.0 -latk-1.0 -lgdk_pixbuf-2.0 -lm -lpangoxft-1.0 -lpangox-1.0 -lpango-1.0 -lgobject-2.0 -lgmodule-2.0 -ldl -lglib-2.0

clean:
	rm hex_dec *.ali *.o b~ventana_conversor.adb b~ventana_conversor.ads