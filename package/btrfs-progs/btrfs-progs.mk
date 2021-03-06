################################################################################
#
# btrfs-progs
#
################################################################################

BTRFS_PROGS_VERSION = 3.18.2
BTRFS_PROGS_SITE = https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs
BTRFS_PROGS_SOURCE = btrfs-progs-v$(BTRFS_PROGS_VERSION).tar.xz
BTRFS_PROGS_DEPENDENCIES = acl attr e2fsprogs lzo util-linux zlib
BTRFS_PROGS_MAKE_FLAGS = DISABLE_DOCUMENTATION=1 DISABLE_BACKTRACE=1
BTRFS_PROGS_LICENSE = GPLv2
BTRFS_PROGS_LICENSE_FILES = COPYING


ifeq ($(BR2_STATIC_LIBS),y)
BTRFS_PROGS_MAKE_TARGET = static
BTRFS_PROGS_MAKE_INSTALL_TARGET = install-static
ifeq ($(BR2_NEEDS_GETTEXT_IF_LOCALE),y)
# Add -lintl for libuuid
BTRFS_PROGS_MAKE_FLAGS += lib_LIBS="-luuid -lblkid -lz -llzo2 -L. -lintl -pthread"
endif
else
BTRFS_PROGS_MAKE_TARGET = all
BTRFS_PROGS_MAKE_INSTALL_TARGET = install
endif

define BTRFS_PROGS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) \
		$(BTRFS_PROGS_MAKE_FLAGS) $(BTRFS_PROGS_MAKE_TARGET)
endef

define BTRFS_PROGS_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) prefix=/usr DESTDIR=$(BTRFS_PROGS_TARGET_DIR) \
		$(BTRFS_PROGS_MAKE_FLAGS) $(BTRFS_PROGS_MAKE_INSTALL_TARGET)
endef

$(eval $(generic-package))
