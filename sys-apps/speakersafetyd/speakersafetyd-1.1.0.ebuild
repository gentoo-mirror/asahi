# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.3

EAPI=8

CRATES="
	alsa-sys@0.3.1
	alsa@0.9.1
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.18
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.7
	anstyle@1.0.10
	autocfg@1.4.0
	bitflags@2.9.0
	bumpalo@3.17.0
	cc@1.2.17
	cfg-if@1.0.0
	chrono@0.4.40
	clap-verbosity-flag@2.2.3
	clap@4.5.34
	clap_builder@4.5.34
	clap_derive@4.5.32
	clap_lex@0.7.4
	colorchoice@1.0.3
	colored@2.2.0
	configparser@3.1.0
	core-foundation-sys@0.8.7
	deranged@0.4.1
	equivalent@1.0.2
	hashbrown@0.15.2
	heck@0.5.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.62
	indexmap@2.8.0
	is_terminal_polyfill@1.70.1
	itoa@1.0.15
	js-sys@0.3.77
	json@0.12.4
	lazy_static@1.5.0
	libc@0.2.171
	log@0.4.27
	num-conv@0.1.0
	num-traits@0.2.19
	num_threads@0.1.7
	once_cell@1.21.3
	pkg-config@0.3.32
	powerfmt@0.2.0
	proc-macro2@1.0.94
	quote@1.0.40
	rustversion@1.0.20
	serde@1.0.219
	serde_derive@1.0.219
	shlex@1.3.0
	signal-hook-registry@1.4.2
	signal-hook@0.3.17
	simple_logger@4.3.3
	strsim@0.11.1
	syn@2.0.100
	time-core@0.1.4
	time-macros@0.2.22
	time@0.3.41
	unicode-ident@1.0.18
	utf8parse@0.2.2
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-shared@0.2.100
	wasm-bindgen@0.2.100
	windows-core@0.52.0
	windows-link@0.1.1
	windows-sys@0.48.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
"

inherit cargo udev

DESCRIPTION="Speaker protection daemon for embedded Linux systems"
HOMEPAGE="https://github.com/AsahiLinux/speakersafetyd/"
SRC_URI="https://github.com/AsahiLinux/speakersafetyd/archive/refs/tags/${PV}.tar.gz -> ${PN}-${PV}.tar.gz
${CARGO_CRATE_URIS}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm64"

DEPEND="
	acct-user/speakersafetyd
	media-libs/alsa-ucm-conf-asahi
"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_install() {
	cargo_src_install
	emake DESTDIR="${D}" install-data
	doinitd "${FILESDIR}/speakersafetyd-noroot"
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
