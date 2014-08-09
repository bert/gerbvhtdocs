# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

S=${WORKDIR}/${P} 
DESCRIPTION="A free Gerber file viewer"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz" 
HOMEPAGE="http://gerbv.geda-project.org"
 
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE="png"

DEPEND="=x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2*
		png? ( media-libs/libpng )
        png? ( media-libs/gdk-pixbuf )"

src_compile(){
    local myconf
    use png || myconf="--disable-exportpng"

	./configure ${myconf} --prefix=/usr --host=${CHOST} || die
	emake || die
} 
 
src_install() { 
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS
	dodoc README TODO
}
