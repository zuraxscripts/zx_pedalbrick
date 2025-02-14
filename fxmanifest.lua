fx_version  'cerulean'
game        'gta5'
lua54       'yes'

description 'PedalBrick'
author      'ZuraxDev'

version '1.0.0'

files {
    'client.lua',
    'server.lua'
}

shared_script {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'config.lua'
}
client_script {
    'client.lua',
}
server_script {
    'server.lua',

}