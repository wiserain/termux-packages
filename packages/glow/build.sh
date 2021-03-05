TERMUX_PKG_HOMEPAGE=https://github.com/charmbracelet/glow
TERMUX_PKG_DESCRIPTION="Render markdown on the CLI, with pizzazz!"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@charmbracelet"
TERMUX_PKG_VERSION=1.3.0
TERMUX_PKG_SRCURL=https://github.com/charmbracelet/glow/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=828d8453f026a24cd7a6dcf8d97213fe713cadcfab7ca969d5f4c8338d88bb86
TERMUX_PKG_RECOMMENDS=git

termux_step_make() {
        termux_setup_golang

        cd "$TERMUX_PKG_SRCDIR"

        mkdir -p "${TERMUX_PKG_BUILDDIR}/src/github.com/charmbracelet"
        cp -a "${TERMUX_PKG_SRCDIR}" "${TERMUX_PKG_BUILDDIR}/src/github.com/charmbracelet/glow"
        cd "${TERMUX_PKG_BUILDDIR}/src/github.com/charmbracelet/glow"

        go get -d -v
        go build
}

termux_step_make_install() {
        install -Dm700 ${TERMUX_PKG_BUILDDIR}/src/github.com/charmbracelet/glow/glow \
                $TERMUX_PREFIX/bin/glow
}
