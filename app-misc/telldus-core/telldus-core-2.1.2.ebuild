# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils
inherit systemd

CMAKE_IN_SOURCE_BUILD="true"

DESCRIPTION="Core services for tellstick house automation transmitter/reciever"
HOMEPAGE="http://www.telldus.se/"
SRC_URI="http://download.telldus.se/TellStick/Software/telldus-core/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
LDFLAGS="-lpthread"
DEPEND=""
RDEPEND="${DEPEND}"


RDEPEND=""
DEPEND="${RDEPEND}
   virtual/pkgconfig
   dev-embedded/libftdi
   dev-libs/confuse 
   dev-util/cmake"

src_prepare() {
   #epatch "${FILESDIR}"/telldus-core-2.1.1_fix_missing_include.patch
   epatch "${FILESDIR}"/telldus-core-2.1.2_remove_doxygen.patch
   epatch "${FILESDIR}"/telldus-core-2.1.2_udev_rules_path.patch
}

src_configure() {
   cmake-utils_src_configure
}

src_compile() {
   cd "${CMAKE_BUILD_DIR}"
   emake -j1 || die "make failed"
}

src_install() {
   systemd_dounit "${FILESDIR}"/telldusd.service
   DESTDIR="${D}" make -j1 install
}

pkg_postinst() {
   elog "Configure your devices by editing the /etc/tellstick.conf file"
}
