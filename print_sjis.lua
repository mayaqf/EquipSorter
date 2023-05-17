require "strings"
local UTF8toSJIS = require("UTF8toSJIS")
local UTF8SJIS_table = "Utf8Sjis.tbl"
local fht = io.open(UTF8SJIS_table, "r")

--[[ shift-jisに変換してコンソールに出力 ]]
function print_sjis(str)
    local s = UTF8toSJIS:UTF8_to_SJIS_str_cnv(fht, str)
    if s:gsub(" ", ""):len() > 0 then
        print(s)
    end
end

function to_sjis(str)
    return UTF8toSJIS:UTF8_to_SJIS_str_cnv(fht, str)
end