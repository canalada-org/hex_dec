comp_opt=-gnatq -gnatQ -gnatf
link_opt=-largs -L/usr/lib -lgtkada2 -lgtk-x11-2.0 -lgdk-x11-2.0 -latk-1.0 -lgdk_pixbuf-2.0 -lm -lpangoxft-1.0 -lpangox-1.0 -lpango-1.0 -lgobject-2.0 -lgmodule-2.0 -ldl -lglib-2.0
main=hex_dec
main_unit=ventana_conversor
build_dir=/home/mgr/src/Ada/hex_dec/src/
check_cmd=${cross_prefix}gnatgcc -x ada -c ${comp_opt} ${full_current} -gnats
make_cmd=cd ${build_dir}
make_cmd=${cross_prefix}gnatmake -o ${main} ${main_unit} ${gnatmake_opt} -cargs ${comp_opt} -bargs ${bind_opt} -largs ${link_opt}
comp_cmd=cd ${build_dir}
comp_cmd=${cross_prefix}gnatgcc -x ada -c ${comp_opt} ${full_current}
run_cmd=cd ${build_dir}
run_cmd=./${main}
src_dir=/usr/share/ada/adainclude/gtkada2/
src_dir=./
obj_dir=/usr/lib/ada/adalib/gtkada2/
obj_dir=./
debug_pre_cmd=cd ${build_dir}
debug_post_cmd=