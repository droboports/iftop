CPPFLAGS="${CPPFLAGS:-} -I${DEPS}/include/ncurses"
CFLAGS="${CFLAGS:-} -ffunction-sections -fdata-sections"
LDFLAGS="-L${DEPS}/lib -Wl,--gc-sections"

### NCURSES ###
_build_ncurses() {
local VERSION="5.9"
local FOLDER="ncurses-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://ftp.gnu.org/gnu/ncurses/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEPS}" --datadir="${DEST}/share" --without-shared
make
make install
popd
}

### LIBPCAP ###
_build_libpcap() {
local VERSION="1.7.4"
local FOLDER="libpcap-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://www.tcpdump.org/release//${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEPS}" --disable-shared --with-pcap=linux
make
make install
popd
}

### IFTOP ###
_build_iftop() {
local VERSION="0.17"
local FOLDER="iftop-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://www.ex-parrot.com/pdw/iftop/download/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEST}" --with-libpcap="${DEPS}"
make
make install
popd
}

### BUILD ###
_build() {
  _build_ncurses
  _build_libpcap
  _build_iftop
  _package
}
