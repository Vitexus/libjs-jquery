#!/bin/bash
rm -rf build

cd ~/Projects/3RDParty/jquery
git pull
#nodejs install
npm install
npm run build
npm run dist

VERSION=`cat package.json | grep '"version":' | awk -F '"' '{ print $4 }'`
#BUILD=`cat  ./build | perl -ne 'chomp; print join(".", splice(@{[split/\./,$_]}, 0, -1), map {++$_} pop @{[split/\./,$_]}), "\n";'`
#echo $BUILD > build
BUILD=1

#CHANGES=`cat CHANGELOG.md | awk -vRS="##" 'NR<=2' ORS="##" | grep -v "##"`
tar -czf ~/Projects/Packaging/libjs-jquery/libjs-jquery_$VERSION.orig.tar.gz .
cd ~/Projects/Packaging/libjs-jquery
#dch -v $VERSION-1 --package libjs-twitter-bootstrap $CHANGES
dch -v $VERSION-$BUILD --package libjs-jquery "Debianized $VERSION"

echo $VERSION > version.txt

debuild -i -us -uc -b

cd ..
#~/bin/publish-deb-packages.sh
