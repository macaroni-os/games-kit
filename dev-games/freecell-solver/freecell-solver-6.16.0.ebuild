# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit cmake-utils python-single-r1

DESCRIPTION="C library for automatically solving Freecell and some other solitaire variants"
HOMEPAGE="https://fc-solve.shlomifish.org/"
SRC_URI="https://fc-solve.shlomifish.org/download.html/downloads/fc-solve/freecell-solver-6.16.0.tar.xz -> freecell-solver-6.16.0.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="${PYTHON_DEPS}
	dev-libs/rinutils
	dev-python/pysol_cards[${PYTHON_USEDEP}]
	dev-python/random2[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	
"
DEPEND="${RDEPEND}
	dev-perl/Moo
	dev-perl/Path-Tiny
	dev-perl/Template-Toolkit
	
"
src_prepare() {
	sed -i -e "s|share/doc/freecell-solver/|share/doc/freecell-solver-6.16.0|" CMakeLists.txt || die

	python_fix_shebang board_gen
	cmake-utils_src_prepare
}
src_configure() {
	local mycmakeargs=(
		-DBUILD_STATIC_LIBRARY=OFF
		-DFCS_BUILD_DOCS=OFF
		-DFCS_WITH_TEST_SUITE=OFF
	)
	cmake-utils_src_configure
}


# vim: filetype=ebuild
