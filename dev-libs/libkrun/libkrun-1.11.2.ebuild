# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	aho-corasick@1.1.3
	allocator-api2@0.2.20
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	annotate-snippets@0.9.2
	anyhow@1.0.93
	async-trait@0.1.83
	atty@0.2.14
	autocfg@1.4.0
	backtrace@0.3.74
	base64@0.22.1
	bincode@1.3.3
	bindgen@0.69.5
	bitfield@0.15.0
	bitflags@1.3.2
	bitflags@2.6.0
	bumpalo@3.16.0
	byteorder@1.5.0
	bzip2-sys@0.1.11+1.0.8
	bzip2@0.5.0
	caps@0.5.5
	cc@1.2.1
	cexpr@0.6.0
	cfg-expr@0.15.8
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	chrono@0.4.38
	clang-sys@1.8.1
	codicon@3.0.0
	convert_case@0.6.0
	cookie-factory@0.3.3
	core-foundation-sys@0.8.7
	crc32fast@1.4.2
	crossbeam-channel@0.5.13
	crossbeam-utils@0.8.20
	curl-sys@0.4.78+curl-8.11.0
	curl@0.4.47
	dirs-sys@0.4.1
	dirs@5.0.1
	either@1.13.0
	env_logger@0.9.3
	equivalent@1.0.1
	flate2@1.0.35
	foldhash@0.1.3
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	futures@0.3.31
	getrandom@0.2.15
	gimli@0.31.1
	glob@0.3.1
	hashbrown@0.15.1
	heck@0.5.0
	hermit-abi@0.1.19
	hex@0.4.3
	humantime@2.1.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.61
	imago@0.1.4
	indexmap@2.6.0
	iocuddle@0.1.1
	itertools@0.12.1
	itoa@1.0.11
	jobserver@0.1.32
	js-sys@0.3.72
	kbs-types@0.8.0
	kvm-bindings@0.10.0
	kvm-ioctls@0.19.0
	lazy_static@1.5.0
	lazycell@1.3.0
	libc@0.2.164
	libloading@0.8.5
	libredox@0.1.3
	libspa-sys@0.8.0
	libspa@0.8.0
	libz-sys@1.1.20
	linux-loader@0.13.0
	log@0.4.22
	lru@0.12.5
	memchr@2.7.4
	memoffset@0.6.5
	memoffset@0.7.1
	minimal-lexical@0.2.1
	miniz_oxide@0.8.0
	nix@0.24.3
	nix@0.26.4
	nix@0.27.1
	nix@0.29.0
	nom@7.1.3
	num-traits@0.2.19
	object@0.36.5
	once_cell@1.20.2
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-sys@0.9.104
	openssl@0.10.68
	option-ext@0.2.0
	page_size@0.6.0
	pin-project-lite@0.2.15
	pin-utils@0.1.0
	pipewire-sys@0.8.0
	pipewire@0.8.0
	pkg-config@0.3.31
	ppv-lite86@0.2.20
	proc-macro2@1.0.89
	procfs@0.12.0
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rdrand@0.8.3
	redox_users@0.4.6
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	remain@0.2.14
	rustc-demangle@0.1.24
	rustc-hash@1.1.0
	rustc_version@0.4.1
	ryu@1.0.18
	schannel@0.1.26
	semver@1.0.23
	serde-big-array@0.5.1
	serde@1.0.215
	serde_bytes@0.11.15
	serde_derive@1.0.215
	serde_json@1.0.133
	serde_spanned@0.6.8
	sev@4.0.0
	shlex@1.3.0
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.5.7
	static_assertions@1.1.0
	syn@2.0.87
	system-deps@6.2.2
	target-lexicon@0.12.16
	termcolor@1.4.1
	thiserror-impl@1.0.69
	thiserror@1.0.69
	tokio@1.41.1
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.22
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing@0.1.40
	unicode-ident@1.0.13
	unicode-segmentation@1.12.0
	unicode-width@0.1.14
	uuid@1.11.0
	vcpkg@0.2.15
	version-compare@0.2.0
	virtio-bindings@0.2.4
	vm-fdt@0.3.0
	vm-memory@0.16.1
	vmm-sys-util@0.12.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.95
	wasm-bindgen-macro-support@0.2.95
	wasm-bindgen-macro@0.2.95
	wasm-bindgen-shared@0.2.95
	wasm-bindgen@0.2.95
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
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
	winnow@0.6.20
	yansi-term@0.1.2
	zerocopy-derive@0.6.6
	zerocopy-derive@0.7.35
	zerocopy@0.6.6
	zerocopy@0.7.35
	zstd-safe@7.2.1
	zstd-sys@2.0.13+zstd.1.5.6
	zstd@0.13.2
"

inherit cargo

DESCRIPTION="A dynamic library providing Virtualization-based process isolation capabilities"
HOMEPAGE="https://github.com/containers/libkrun"

SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/containers/libkrun/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="
	dev-libs/libkrunfw
	media-libs/virglrenderer
	media-video/pipewire
"
DEPEND="
	${RDEPEND}
"
src_compile() {
	unset ARCH
	emake PREFIX=/usr GPU=1 BLK=1 NET=1 SND=1
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
