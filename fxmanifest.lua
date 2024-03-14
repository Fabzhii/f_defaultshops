fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_script '@es_extended/imports.lua'
shared_script '@ox_lib/init.lua'

author 'fabzhii'
description 'F-DefaultShop by fabzhii'
version '1.0.0'

client_script {
    "config.lua",
    "client.lua",
}

server_script {
    "config.lua",
    "server.lua" ,
}