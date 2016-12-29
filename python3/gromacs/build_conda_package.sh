echo "Y\n" | conda update conda
echo "Y\n" | conda update conda-build

conda-build .

OUT=$(conda-build . --output)

cp $OUT /root/
cp -r /tmp/gromacs_build/versions/gromacs-4.6.7/gnu/* /root/gromacs

cd ..
rm gromacs/*.sh gromacs/meta.yaml
cp /root/get_gmx gromacs/

bunzip2 *.bz2
tar rvf $(ls *.tar) gromacs/
bzip2 *.tar
