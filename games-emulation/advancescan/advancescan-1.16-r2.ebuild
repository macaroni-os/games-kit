# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools eutils flag-o-matic

DESCRIPTION="A command line rom manager for MAME, MESS, AdvanceMAME, AdvanceMESS and Raine"
HOMEPAGE="http://advancemame.sourceforge.net/scan-readme.html"
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="dev-libs/expat
	sys-libs/zlib"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-sys-expat.patch
	"${FILESDIR}"/${P}-gcc6.patch
)

src_prepare() {
	rm -rf expat
	append-cxxflags -std=c++98
	default
	eautoreconf
}

src_install() {
	dobin advscan advdiff
	dodoc AUTHORS HISTORY README doc/*.txt advscan.rc.linux
	doman doc/{advscan,advdiff}.1
	dohtml doc/*.html
}
