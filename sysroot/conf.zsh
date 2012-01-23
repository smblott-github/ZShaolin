

mkdir -p system
rm -rf system/*
rsync -dar --files-from=system.tree --delete . system/

for i in `find system`; do
    file $i | grep 'executable, ARM' > /dev/null
    if [ $? = 0 ]; then
	$TOOLCHAIN/bin/$TARGET-strip $i
    fi
done

cd system/bin
# symlink shells
ln -s zsh sh
ln -s zsh ash
ln -s zsh bash
cd ../..

VER=`cat $ZHOME/VERSION`
tar cfz $ZHOME/system-$VER.tar.gz system

cd $ZHOME
stat system-$VER.tar.gz
cp system-$VER.tar.gz termapk/assets/system-$VER.tar.gz.mp3
cp sysroot/pack/bin/busybox termapk/assets/busybox.mp3
chmod -x termapk/assets/busybox.mp3
