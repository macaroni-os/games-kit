# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Game resources for FreeDM"
HOMEPAGE="https://freedoom.github.io"
SRC_URI="https://github.com/freedoom/freedoom/tarball/8cecc3642861dfb71839984c886d5576fa120d49 -> freedoom-0.13.0-8cecc36.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"

BDEPEND="
	games-util/deutex"

S="${WORKDIR}/freedoom-freedoom-8cecc36"

DOOMWADPATH=/usr/share/doom

src_install() {
	insinto ${DOOMWADPATH}
	doins wads/freedm.wad
	dodoc CREDITS README.adoc
}

pkg_postinst() {
	elog "FreeDM WAD file installed into ${DOOMWADPATH} directory."
}

# vim: noet ts=4 syn=ebuild