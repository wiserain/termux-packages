TERMUX_PKG_HOMEPAGE=https://rclone.org/
TERMUX_PKG_DESCRIPTION="rsync for cloud storage"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@wiserain"
TERMUX_PKG_VERSION=1.54.1
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/wiserain/rclone.git
TERMUX_PKG_GIT_BRANCH=v$TERMUX_PKG_VERSION-$TERMUX_PKG_REVISION

termux_step_make_install() {
	cd $TERMUX_PKG_SRCDIR

	termux_setup_golang

	mkdir -p .gopath/src/github.com/rclone
	ln -sf "$PWD" .gopath/src/github.com/rclone/rclone
	export GOPATH="$PWD/.gopath"

	go build -v -o rclone --ldflags "-s -X github.com/rclone/rclone/fs.Version=$TERMUX_PKG_GIT_BRANCH"

	# XXX: Fix read-only files which prevents removal of src dir.
	chmod u+w -R .

	cp rclone $TERMUX_PREFIX/bin/rclone
	mkdir -p $TERMUX_PREFIX/share/man/man1/
	cp rclone.1 $TERMUX_PREFIX/share/man/man1/
	zip $HOME/termux-packages/debs/rclone-$TERMUX_PKG_GIT_BRANCH-termux-$TERMUX_ARCH.zip rclone
}
