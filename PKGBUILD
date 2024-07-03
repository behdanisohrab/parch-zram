# Maintainer: Sohrab Behdani <behdanisohrab@gmail.com>

_pkgname=parch-zram
pkgname=parch-zram
pkgver=1.0
pkgrel=1
pkgdesc="Script to dynamically enable ZRAM on a Raspberry Pi or other Linux system"
arch=('any')
url="https://github.com/behdanisohrab/parch-zram"
makedepends=("git")
source=("git+$url.git"
        "$pkgname.service")
sha256sums=("SKIP"
            "787e4059fa027c89e664a9380d049adf6615fe726708b408c430e5cdf0060f26")

package() {
    install -Dm755 $_pkgname/zram.sh $pkgdir/usr/bin/$pkgname
    install -Dm644 $_pkgname/$pkgname.service $pkgdir/usr/lib/systemd/system/$pkgname.service
}
