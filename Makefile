all: export_zelti_top.stl export_zelti_bottom.stl

.PHONY: clean
clean:
	-rm *.stl

export_%.stl: zelti_box.scad
	echo 'use <zelti_box.scad>; $(patsubst export_%.stl,%,$@)();' | openscad - -o "$@"
