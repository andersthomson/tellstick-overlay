# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7
PYTHON_COMPAT=( python{3_7,3_8,3_9,3_10,3_11,3_12} )

inherit distutils-r1 git-r3 python-utils-r1


DESCRIPTION="Telldus-py stuff"
HOMEPAGE="TBD"

EGIT_REPO_URI="https://github.com/erijo/tellcore-py.git"
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
