#!/bin/bash
DOWNLOAD_HOST=$1
URI_PART=$2
DIST_DIR=$3
echo ***************************************************
echo DOWNLOAD_HOST: ${DOWNLOAD_HOST}
echo URI_PART:      ${URI_PART}
echo DIST_DIR:      ${DIST_DIR}
echo ***************************************************
wget "http://$DOWNLOAD_HOST/$URI_PART/Sheboygan.mgp"
sudo mv Sheboygan.mgp /tmp/
wget "http://$DOWNLOAD_HOST/$URI_PART/$DIST_DIR/mginstallubuntu.sh"
REPLACE=URL="http://$DOWNLOAD_HOST/$URI_PART/$DIST_DIR"
sed -i 's#URL="\$URL_ROOT\/\$URL_PART"#'"$REPLACE"'#g' mginstallubuntu.sh
cp /vagrant/smoke_test.sh .
chmod +x smoke_test.sh
chmod +x mginstallubuntu.sh
sudo ./mginstallubuntu.sh --headless --with-sdf --with-shp --with-ogr --with-gdal --with-sqlite
echo Wait 10s before running smoke test
sleep 10s
sudo ./smoke_test.sh