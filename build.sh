#/bin/sh
cd `dirname $0`

# clean up
rm -rf target

# build
mkdir target
cd src

zip --verbose \
    --recurse-paths \
    ../target/oke-handson-prerequisites *
