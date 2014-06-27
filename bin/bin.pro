TEMPLATE = app
TARGET = omniacreator.sh
OBJECTS_DIR =

PRE_TARGETDEPS = $$PWD/omniacreator.sh

QMAKE_LINK = cp $$PWD/omniacreator.sh $@ && : IGNORE REST OF LINE:
QMAKE_STRIP =
CONFIG -= qt separate_debug_info gdb_dwarf_index

QMAKE_CLEAN = omniacreator.sh

target.path  = $$QTC_PREFIX/bin
INSTALLS    += target

OTHER_FILES = $$PWD/omniacreator.sh
