# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.22.0
	adler@1.0.2
	aho-corasick@1.1.3
	anstream@0.6.14
	anstyle-parse@0.2.4
	anstyle-query@1.0.3
	anstyle-wincon@3.0.3
	anstyle@1.0.7
	anyhow@1.0.91
	autocfg@1.4.0
	backtrace@0.3.72
	bindgen@0.69.4
	bitflags@2.5.0
	bpaf@0.9.12
	byteorder@1.5.0
	bytes@1.6.0
	cc@1.0.99
	cexpr@0.6.0
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	clang-sys@1.7.0
	colorchoice@1.0.1
	const-str@0.6.2
	darling@0.14.4
	darling_core@0.14.4
	darling_macro@0.14.4
	derive_builder@0.11.2
	derive_builder_core@0.11.2
	derive_builder_macro@0.11.2
	either@1.11.0
	env_filter@0.1.0
	env_logger@0.11.3
	errno@0.3.8
	fastrand@2.1.0
	fnv@1.0.7
	futures-core@0.3.30
	futures-sink@0.3.30
	getrandom@0.2.15
	getset@0.1.5
	gimli@0.29.0
	glob@0.3.1
	hermit-abi@0.3.9
	hex@0.4.3
	humantime@2.1.0
	ident_case@1.0.1
	input-linux-sys@0.9.0
	input-linux@0.7.1
	io-lifetimes@1.0.11
	is_terminal_polyfill@1.70.0
	itertools@0.12.1
	itoa@1.0.11
	lazy_static@1.4.0
	lazycell@1.3.0
	libc@0.2.161
	libudev-sys@0.1.4
	linux-raw-sys@0.4.13
	lock_api@0.4.12
	log@0.4.21
	memchr@2.7.2
	memoffset@0.9.1
	minimal-lexical@0.2.1
	miniz_oxide@0.7.3
	mio@0.8.11
	neli-proc-macros@0.2.0-rc3
	neli@0.7.0-rc3
	nix@0.29.0
	nom@7.1.3
	num_cpus@1.16.0
	object@0.35.0
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	pin-project-lite@0.2.14
	pkg-config@0.3.31
	proc-macro-error-attr2@2.0.0
	proc-macro-error2@2.0.1
	proc-macro2@1.0.82
	procfs-core@0.17.0
	procfs@0.17.0
	quote@1.0.36
	redox_syscall@0.5.10
	regex-automata@0.4.6
	regex-syntax@0.8.3
	regex@1.10.4
	rustc-demangle@0.1.24
	rustc-hash@1.1.0
	rustix@0.38.34
	ryu@1.0.18
	scopeguard@1.2.0
	serde@1.0.203
	serde_derive@1.0.203
	serde_json@1.0.117
	shlex@1.3.0
	signal-hook-registry@1.4.2
	smallvec@1.14.0
	socket2@0.5.7
	strsim@0.10.0
	syn@1.0.109
	syn@2.0.61
	tempfile@3.10.1
	tokio-macros@2.3.0
	tokio-stream@0.1.15
	tokio-util@0.7.11
	tokio@1.38.0
	udev@0.9.1
	unicode-ident@1.0.12
	utf8parse@0.2.1
	uuid@1.10.0
	wasi@0.11.0+wasi-snapshot-preview1
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
"

RUST_MIN_VER="1.72.0"

inherit cargo

DESCRIPTION="Run programs from your system in a microVM"
HOMEPAGE="https://github.com/AsahiLinux/muvm"

SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/AsahiLinux/muvm/archive/refs/tags/${P}.tar.gz
"

S="${WORKDIR}/muvm-${P}"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 MIT Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~arm64"

BDEPEND="
	virtual/pkgconfig
"

DEPEND="
	>=dev-libs/libkrun-1.10.1
"
RDEPEND="
	${DEPEND}
	>=dev-libs/libkrunfw-4.7.1
	net-misc/passt
	net-misc/socat
"

src_compile() {
	cargo_src_compile --workspace
}

src_install() {
	local bin
	for bin in muvm{,-guest}; do
		dobin "$(cargo_target_dir)/$bin"
	done
	insinto /usr/share/wireplumber/scripts/client
	doins share/wireplumber/scripts/client/access-muvm.lua
	insinto /usr/share/wireplumber/wireplumber.conf.d
	doins share/wireplumber/wireplumber.conf.d/50-muvm-access.conf
}
