echo "Y\n" | conda update conda
echo "Y\n" | conda update conda-build

conda-build .

OUT=$(conda-build . --output)

INSTALL_DIR=$(echo $(dirname $OUT)/$(basename $OUT | cut -d'.' -f1-5) | sed "s|conda-bld/linux-64|pkgs|")/gromacs

INSTALL_BIN=$INSTALL_DIR/bin
INSTALL_SHARE=$INSTALL_DIR/share

cp $OUT /root/
cp -r /tmp/gromacs_build/versions/gromacs-4.6.7/gnu/* /root/gromacs

sed -i "s|.*GMXRC.bash.*|. $INSTALL_BIN/GMXRC.bash|" bin/GMXRC
sed -i "s|.*GMXRC.csh.*|. $INSTALL_BIN/GMXRC.csh|" bin/GMXRC
sed -i "s|.*GMXRC.zsh.*|source $INSTALL_BIN/GMXRC.zsh|" bin/GMXRC

# BASH
sed -i "s|GMXBIN=.*|GMXBIN=$INSTALL_DIR/bin|" bin/GMXRC.bash
sed -i "s|GMXLDLIB=.*|GMXLDLIB=$INSTALL_DIR/lib|" bin/GMXRC.bash
sed -i "s|GMXMAN=.*|GMXMAN=$INSTALL_DIR/share/man|" bin/GMXRC.bash
sed -i "s|GMXDATA=.*|GMXDATA=$INSTALL_DIR/share/gromacs|" bin/GMXRC.bash

# CSH
sed -i "s|setenv GMXBIN.*|setenv GMXBIN $INSTALL_DIR/bin|" bin/GMXRC.csh
sed -i "s|setenv GMXLDLIB.*|setenv GMXLDLIB $INSTALL_DIR/lib|" bin/GMXRC.csh
sed -i "s|setenv GMXMAN.*|setenv GMXMAN $INSTALL_DIR/share/man|" bin/GMXRC.csh
sed -i "s|setenv GMXDATA.*|setenv GMXDATA $INSTALL_DIR/share/gromacs|" bin/GMXRC.csh

# ZSH
sed -i "s|GMXBIN=.*|GMXBIN=$INSTALL_DIR/bin|" bin/GMXRC.zsh
sed -i "s|GMXLDLIB=.*|GMXLDLIB=$INSTALL_DIR/lib|" bin/GMXRC.zsh
sed -i "s|GMXMAN=.*|GMXMAN=$INSTALL_DIR/share/man|" bin/GMXRC.zsh
sed -i "s|GMXDATA=.*|GMXDATA=$INSTALL_DIR/share/gromacs|" bin/GMXRC.zsh

cd ..
rm gromacs/*.sh gromacs/meta.yaml
cp /root/get_gmx gromacs/

bunzip2 *.bz2
tar rvf $(ls *.tar) gromacs/
bzip2 *.tar
