# Distributed under the terms of the GNU General Public License v2

EAPI=7

: ${CMAKE_MAKEFILE_GENERATOR:=emake}
inherit cmake flag-o-matic

DESCRIPTION="SuperTux source code"
HOMEPAGE="https://supertux.org/"
SRC_URI="https://github.com/SuperTux/supertux/releases/download/v0.6.3/SuperTux-v0.6.3-Source.tar.gz -> SuperTux-v0.6.3-Source.tar.gz"

LICENSE="GPL-2+ GPL-3+ ZLIB MIT CC-BY-SA-2.0 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
IUSE="debug"

RDEPEND="
	dev-games/physfs
	dev-libs/boost:=[nls]
	media-libs/freetype
	media-libs/glew:=
	media-libs/glm
	media-libs/libpng:0=
	media-libs/libsdl2[joystick,video]
	media-libs/sdl2-ttf
	media-libs/libvorbis
	media-libs/openal
	media-libs/sdl2-image[png,jpeg]
	net-misc/curl
	virtual/opengl
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

post_src_unpack() {
	mv "${WORKDIR}"/SuperTux* "${S}" || die
}

src_prepare() {
	cmake_src_prepare

	# This is not a developer release so switch the logo to the non-dev one.
	sed -e 's@logo_dev@logo@' \
		-i data/images/objects/logo/logo.sprite || die
}

src_configure() {
	append-cxxflags -std=c++11

	local mycmakeargs=(
		-DWERROR=OFF
		-DINSTALL_SUBDIR_BIN=bin
		-DINSTALL_SUBDIR_DOC=share/doc/${PF}
		-DINSTALL_SUBDIR_SHARE=share/${PN}2
		-DENABLE_SQDBG="$(usex debug)"
		-DUSE_SYSTEM_PHYSFS=ON
	)
	cmake_src_configure
}