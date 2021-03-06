# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake cmake-utils systemd git-r3 eutils

CMAKE_IN_SOURCE_BUILD="true"

DESCRIPTION="Core services for tellstick house automation transmitter/reciever"
HOMEPAGE="http://www.telldus.se/"
#SRC_URI="http://download.telldus.se/TellStick/Software/telldus-core/${P}.tar.gz"

KEYWORDS="~amd64 arm ~x86"
EGIT_REPO_URI="https://github.com/andersthomson/telldus.git"
# Disable all submodules
EGIT_SUBMODULES=()

LICENSE="LGPL-2"
SLOT="0"
IUSE=""
LDFLAGS="-lpthread"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-embedded/libftdi
	dev-libs/confuse
	dev-util/cmake"

S="${WORKDIR}/${P}/telldus-core"
src_prepare() {
#   #epatch "${FILESDIR}"/telldus-core-2.1.1_fix_missing_include.patch
#   epatch "${FILESDIR}"/telldus-core-2.1.2_remove_doxygen.patch
#   epatch "${FILESDIR}"/telldus-core-2.1.2_udev_rules_path.patch
	eapply_user
	eapply "${FILESDIR}"/telldus-core-2.1.2_fix_libftdi_discovery.patch
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=( -DFORCE_COMPILE_FROM_TRUNK="TRUE" )
	cmake-utils_src_configure
}

src_compile() {
	cd "${CMAKE_BUILD_DIR}"
	#emake -j1 || die "make failed"
	cmake_src_compile -j1
}

src_install() {
	systemd_dounit "${FILESDIR}"/telldusd.service
	#DESTDIR="${D}" make -j1 install
	cmake_src_install
}

pkg_postinst() {
	elog "Configure your devices by editing the /etc/tellstick.conf file"
}
