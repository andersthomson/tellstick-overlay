# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit eutils git-r3 python-utils-r1


DESCRIPTION="Pytelldus stuff"
HOMEPAGE="TBD"

EGIT_REPO_URI="https://bitbucket.org/davka003/pytelldus.git"
if [[ ${PV} = 9999* ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT=v${PV}
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="AS-IS"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

#src_prepare() {
#	epatch "${FILESDIR}"/${PN}-allow-nonsudo-install.patch \
#		"${FILESDIR}"/${PN}-fix-man-installs.patch
#}

src_install() {
#	emake DESTDIR="${D}" SUDO="" install
#	dodoc AUTHORS README CHANGES
#	doman vit.1 vitrc.5

#	rm -rf "${ED}"/usr/man
	#hack hack...
	for b in td.py tdtool.py ; do
		echo "#!/usr/bin/python" > ${b}_new
		cat ${b} >> ${b}_new
		mv ${b}_new $b
		dobin ${b}
	done
}
