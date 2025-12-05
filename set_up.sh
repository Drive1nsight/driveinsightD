#!/bin/bash

mkdir -p app/esmini_visualizer_app
wget https://github.com/esmini/esmini/releases/download/v2.35.0/esmini-demo_Linux.zip
unzip -o esmini-demo_Linux.zip -d app/esmini_visualizer_app

wget -O cz_zlin_osgb.zip "https://drive.usercontent.google.com/download?id=1tyDfd20Vcj0h8brzwn6VQrxfSZ-f4I60&export=download&authuser=1&confirm=t&uuid=0780a4e4-5690-4980-a4b2-3bd2abc67afd&at=ALWLOp5rIL2CqQfS_zCl8yQAVFUO:1764925200101"
wget -O us_coldwater_osgb.zip "https://drive.usercontent.google.com/download?id=153cCDZyPK_QAt2Wi_7GQiH9mNkNvkt0T&export=download&authuser=1&confirm=t&uuid=d6b9e6c6-e5b2-470a-84e6-658ff616b4cb&at=ALWLOp5PVq-B2RLePZPDk4d_yZQr:1764925158758"
wget -O jp_taito_osgb.zip "https://drive.usercontent.google.com/download?id=11h6v-PLedL1nKVtu-ZldbxabnESHGcfW&export=download&authuser=1&confirm=t&uuid=62946ae1-bbb6-46e9-93df-cd7af87c47f8&at=ALWLOp68e7Oee9Q42QkL7xO9M7Z1:1764925035282"

unzip jp_taito_osgb.zip -d database/jp_taito
unzip cz_zlin_osgb.zip -d database/cz_zlin
unzip us_coldwater_osgb.zip -d database/us_coldwater
mv database/jp_taito/osgb_file.osgb database/jp_taito/jp_taito.osgb
mv database/cz_zlin/osgb_file.osgb database/cz_zlin/cz_zlin.osgb
mv database/us_coldwater/osgb_file.osgb database/us_coldwater/usa_coldwater.osgb