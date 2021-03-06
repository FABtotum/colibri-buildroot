################################################################################
#
# sysklogd
#
################################################################################

SYSKLOGD_VERSION = 1.5.1
SYSKLOGD_SITE = http://www.infodrom.org/projects/sysklogd/download
SYSKLOGD_LICENSE = GPLv2+
SYSKLOGD_LICENSE_FILES = COPYING

# Override BusyBox implementations if BusyBox is enabled.
ifeq ($(BR2_PACKAGE_BUSYBOX),y)
SYSKLOGD_DEPENDENCIES = busybox
endif

define SYSKLOGD_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define SYSKLOGD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0500 $(@D)/syslogd $(SYSKLOGD_TARGET_DIR)/sbin/syslogd
	$(INSTALL) -D -m 0500 $(@D)/klogd $(SYSKLOGD_TARGET_DIR)/sbin/klogd
	$(INSTALL) -D -m 0644 package/sysklogd/syslog.conf \
		$(SYSKLOGD_TARGET_DIR)/etc/syslog.conf
endef

define SYSKLOGD_INSTALL_INIT_SYSV
	$(INSTALL) -m 755 -D package/sysklogd/S01logging \
		$(SYSKLOGD_TARGET_DIR)/etc/init.d/S01logging
endef

$(eval $(generic-package))
