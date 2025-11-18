#!/bin/bash

wget https://github.com/esmini/esmini/releases/download/v2.35.0/esmini-demo_Linux.zip
unzip -o esmini-demo_Linux.zip

wget -O cz_zlin_osgb.zip https://drive.google.com/uc?id=1tyDfd20Vcj0h8brzwn6VQrxfSZ-f4I60
unzip cz_zlin_osgb.zip -d database/cz_zlin

wget -O us_coldwater_osgb.zip https://drive.google.com/uc?id=1tyDfd20Vcj0h8brzwn6VQrxfSZ-f4I60
unzip us_coldwater_osgb -d database/us_coldwater

wget -O jp_taito_osgb.zip https://drive.google.com/uc?id=11h6v-PLedL1nKVtu-ZldbxabnESHGcfW
unzip jp_taito_osgb -d database/jp_taito