fx_version "cerulean"
lua54 "yes"
game "gta5"

name "A script"
version "0.0.1"
description "desc"
author "Groot Development"

shared_scripts{
	"@ox_lib/init.lua",
	"locales/locale.lua",
	"locales/translations/*.lua",
	"src/shared/*.lua",
}

-- Uncomment if you'r using nuis
-- ui_page 'web/build/index.html'
-- files {
--    'web/build/index.html',
--    'web/build/**/*',
--    -- 'web/itemImage/*.png',
-- }

server_scripts{
	"bridge/**/server.lua",
	"src/server/*.lua",
}
client_scripts {
   'bridge/**/client.lua',
   'src/client/*.lua',
}