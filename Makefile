INSTALLER_PATH=src/service_install.sh
INSTALL=install
UNINSTALL=remove

all: install

install:
	$(INSTALLER_PATH) $(INSTALL)

uninstall:
	$(INSTALLER_PATH) $(UNINSTALL)

reinstall: uninstall install
