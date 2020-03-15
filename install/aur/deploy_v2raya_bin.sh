#!/bin/bash
cd $srcdir
sha1sums_i686=$(sha1sum v2raya_linux_386_$VERSION | awk '{print $1}')
sha1sums_x86_64=$(sha1sum v2raya_linux_amd64_$VERSION | awk '{print $1}')
sha1sums_armv6h=$(sha1sum v2raya_linux_arm_$VERSION | awk '{print $1}')
sha1sums_armv7h=$sha1sums_armv6h
sha1sums_aarch64=$(sha1sum v2raya_linux_arm64_$VERSION | awk '{print $1}')
sha_service=$(sha1sum v2raya.service | awk '{print $1}')
sha_png=$(sha1sum v2raya.png | awk '{print $1}')
sha_desktop=$(sha1sum v2raya.desktop | awk '{print $1}')

mkdir -p /tmp/prepare/v2raya-bin
cd /tmp/prepare/v2raya-bin
cp "$srcdir"/install/aur/v2raya-bin/* ./
cp "$srcdir"/install/universal/v2raya.desktop ./
cp "$srcdir"/install/universal/v2raya.png ./
cp "$srcdir"/install/universal/v2raya.service ./

sed -i s/{{pkgver}}/"${VERSION:1}"/g PKGBUILD .SRCINFO
sed -i s/{{sha1sums_i686}}/"${sha1sums_i686}"/g PKGBUILD .SRCINFO
sed -i s/{{sha1sums_x86_64}}/"${sha1sums_x86_64}"/g PKGBUILD .SRCINFO
sed -i s/{{sha1sums_armv6h}}/"${sha1sums_armv6h}"/g PKGBUILD .SRCINFO
sed -i s/{{sha1sums_armv7h}}/"${sha1sums_armv7h}"/g PKGBUILD .SRCINFO
sed -i s/{{sha1sums_aarch64}}/"${sha1sums_aarch64}"/g PKGBUILD .SRCINFO
sed -i s/{{sha_service}}/"${sha_service}"/g PKGBUILD .SRCINFO
sed -i s/{{sha_png}}/"${sha_png}"/g PKGBUILD .SRCINFO
sed -i s/{{sha_desktop}}/"${sha_desktop}"/g PKGBUILD .SRCINFO

cd /tmp/
git clone ssh://aur@aur.archlinux.org/v2raya-bin.git
cd v2raya-bin
cp -f /tmp/prepare/v2raya-bin/* ./
git add .
git commit -m "release $VERSION"
git push -u -f origin master
cd $srcdir #回项目目录