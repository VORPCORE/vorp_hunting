fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author 'VORP | rubi216 | Artzalez'
description 'A Hunting script for vorp core framework'
repository 'https://github.com/VORPCORE/VORP-Hunting'
lua54 'yes'

shared_script "config.lua"

client_scripts {
    '@vorp_core/client/dataview.lua',
    'client/main.lua',
}
server_script 'server/main.lua'



--dont touch
version '1.0.5'
vorp_checker 'yes'
vorp_name '^4Resource version Check^3'
vorp_github 'https://github.com/VORPCORE/VORP-Hunting'
