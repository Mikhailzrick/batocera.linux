################################################################################
#
# jstest2
#
################################################################################

JSTEST2_VERSION = 95784a322faf66f7af79bc883508c8d827ed77b2
#JSTEST2_SITE = $(call gitlab,sdl-jstest,sdl-jstest,$(JSTEST2_VERSION))
JSTEST2_SITE = https://gitlab.com/sdl-jstest/sdl-jstest
JSTEST2_SITE_METHOD = git
JSTEST2_GIT_SUBMODULES = YES
JSTEST2_DEPENDENCIES = sdl2

JSTEST2_CONF_ENV = LIBS="-ncurses -ltinfo"

$(eval $(cmake-package))
