#!/bin/bash
#make symlinks
ln -sf ${ECO_STORAGE_FOLDER} ${ECO_SERVER_FILES}/Storage
ln -sf ${ECO_CONFIG_FOLDER} ${ECO_SERVER_FILES}/Configs
#start server
cd ${ECO_SERVER_FILES} 
mono EcoServer.exe -nogui