PREFIX_EFFECTIVE=$PREFIX

# strip PREFIX to package level
# needed when using environments
# does not break when not using them

while true; do
  resp=$(echo $PREFIX_EFFECTIVE | grep -q envs)
  if [ $? -eq 0 ]; then
    PREFIX_EFFECTIVE=$(dirname $PREFIX_EFFECTIVE)
    continue
  fi
  break
done

# edit the paths in the RC files

INSTALL_DIR=$PREFIX_EFFECTIVE/pkgs/$PKG_NAME-$PKG_VERSION-py27_1/gromacs
INSTALL_BIN=$INSTALL_DIR/bin
INSTALL_SHARE=$INSTALL_DIR/share


sed -i "s|.*GMXRC.bash.*|. $INSTALL_BIN/GMXRC.bash|" $INSTALL_BIN/GMXRC
sed -i "s|.*GMXRC.csh.*|. $INSTALL_BIN/GMXRC.csh|" $INSTALL_BIN/GMXRC
sed -i "s|.*GMXRC.zsh.*|source $INSTALL_BIN/GMXRC.zsh|" $INSTALL_BIN/GMXRC

# BASH
sed -i "s|GMXBIN=.*|GMXBIN=$INSTALL_DIR/bin|" $INSTALL_BIN/GMXRC.bash
sed -i "s|GMXLDLIB=.*|GMXLDLIB=$INSTALL_DIR/lib|" $INSTALL_BIN/GMXRC.bash
sed -i "s|GMXMAN=.*|GMXMAN=$INSTALL_DIR/share/man|" $INSTALL_BIN/GMXRC.bash
sed -i "s|GMXDATA=.*|GMXDATA=$INSTALL_DIR/share/gromacs|" $INSTALL_BIN/GMXRC.bash

# CSH
sed -i "s|setenv GMXBIN.*|setenv GMXBIN $INSTALL_DIR/bin|" $INSTALL_BIN/GMXRC.csh
sed -i "s|setenv GMXLDLIB.*|setenv GMXLDLIB $INSTALL_DIR/lib|" $INSTALL_BIN/GMXRC.csh
sed -i "s|setenv GMXMAN.*|setenv GMXMAN $INSTALL_DIR/share/man|" $INSTALL_BIN/GMXRC.csh
sed -i "s|setenv GMXDATA.*|setenv GMXDATA $INSTALL_DIR/share/gromacs|" $INSTALL_BIN/GMXRC.csh

# ZSH
sed -i "s|GMXBIN=.*|GMXBIN=$INSTALL_DIR/bin|" $INSTALL_BIN/GMXRC.zsh
sed -i "s|GMXLDLIB=.*|GMXLDLIB=$INSTALL_DIR/lib|" $INSTALL_BIN/GMXRC.zsh
sed -i "s|GMXMAN=.*|GMXMAN=$INSTALL_DIR/share/man|" $INSTALL_BIN/GMXRC.zsh
sed -i "s|GMXDATA=.*|GMXDATA=$INSTALL_DIR/share/gromacs|" $INSTALL_BIN/GMXRC.zsh

# copy the path finding tool to $HOME
# for convenience of user

cp $INSTALL_DIR/get_gmx $HOME/

echo 4.6.7,$INSTALL_BIN/GMXRC >> ~/.gromacs_versions

