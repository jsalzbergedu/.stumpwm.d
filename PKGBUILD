# Maintainer: Jacob Salzberg <jssalzbe@ncsu.edu>
pkgname=etoile-stumpwm
pkgver=0.1.0
pkgrel=1
pkgdesc="StumpWM étoile config"
arch=('any')
provides=('etoile-stumpwm')
url="https://github.com/jsalzbergedu/.stumpwm.d"
license=('MIT')
depends=()     # TODO
makedepends=() # TODO
source=("git+https://gitlab.com/jsalzbergedu/.stumpwm.d")
sha256sums=('SKIP')

package() {
    cd .stumpwm.d
    mkdir -p "$pkgdir/usr/bin/"
    cp startstump.sh "$pkgdir/usr/bin/"
}
