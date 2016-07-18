echo 4.6.7,$PREFIX/pkgs/$PKG_NAME-$PKG_VERSION-py27_1/gromacs/bin/GMXRC >> ~/.gromacs_versions

mkdir -p ~/.local/bin

cp $PREFIX/pkgs/$PKG_NAME-$PKG_VERSION-py27_1/gromacs/get_gmx ~/.local/bin
cp $PREFIX/pkgs/$PKG_NAME-$PKG_VERSION-py27_1/gromacs/get_gmx ~/
