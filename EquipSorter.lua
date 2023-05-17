--[[
EquipSorter v0.1.0

Copyright © 2023, Mayaqf
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of <addon name> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <your name> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

require "print_sjis"
require "property_table"
require "strings"
require "category"
require "print_property"
require "csv_exporter"
require "sort"
require "slots"

local items = require "resources/items"
local item_desc = require "resources/item_descriptions"
jobs = require "jobs"
races = require "races"
local exported, category = init_category()
local integ_equip = init_category()

local data_src = {
    --[[ list here "data/GeawSwapExportedItemss.lua" ]]
    "data/Mayaqf 2023-05-12 20-08-24.lua",
}


function table_contains(t, val)
    for _, v in pairs(t) do
        if type(val) == "string" then
            if val:find(v, 1, true) then
                return true
            end
        elseif type(val) == "number" then
            if v == val then
                return true
            end
        end
    end
    return false
end


function read_exported_file(filename)
    local data = {}
    io.input(filename)
    local line = io.read()
    while line do
        local cat = ""
        local name = "name"
        local augments = "augments"
        local key, value = string.match(line, "(.-)=(.+)")
        if type(key) == "string" and (table_contains(category, key) or key:contains("ear")) then
            cat = key:gsub(" ", "")
            if cat:find("ring",1,true) then
                cat = "ring"
            elseif cat:find("ear",1,true) then
                cat = "earring"
            end
            local exp = {name="",augments=""}
            if not value:find(name, 1, true) then
                -- value= legs="ヘルクリアトラウザ",
                name = value:stripchars([[",]])
                exp.name = name
                table.insert(exported[cat], exp)
            else
                -- value= { name="hoge", augments={...}},
                key, value = value:match("(.-)=(.+)") -- key= { name , value= "hoge", augments={...}},
                name = value:split(",")[1]:gsub('"', "") -- name = "hoge"
                key, value = value:match("(.-)=(.+)") -- key= "hoge", augments" . value= "{...}},
                augments = value
                exp.name = name
                exp.augments = augments:slice(1, #augments - 2)
                table.insert(exported[cat], exp)
            end
        end
        line = io.read()
    end
end


---@param name "items.ja" : string
function parse_property(name)
    local property = init_property_table()
    local id
    for _,v in pairs(items) do
        if v.ja == name then
            id = v.id
            break
        end
    end
    if id == nil then 
        print_sjis("can't find "..'"'..name..'" in items.')
        error()
    end
    local item = items[id] or {}
    local desc = item_desc[id] and item_desc[id].ja or ""

    property.name = item.ja
    property.races = item.races
    property.jobs = item.jobs
    property.level = item.level or nil
    property.slots = item.slots or nil
    property.item_level = item.item_level or nil

    -- description
    local descs = desc:gsub("\n", " ")
    local props = descs:split(" ")
    for _, s in pairs(props) do
        for k, v in pairs(property) do
            if type(v) == "table" and type(k) == "number" and s:startswith(v.ja) then
                if s:find("スキル",1,true) then goto others end
                local sb = s:stripchars(v.ja)
                if v.suffix then
                    sb = sb:stripchars(v.suffix)
                    property[k].suffix = v.suffix
                end
                property[k].value = tonumber(sb, 10) or sb
                goto continue
            end
        end
        ::others::
        table.insert(property["その他"], s)
        ::continue::
    end
    return property
end


function integration_augments()
    for catkey, vals in pairs(exported) do
        for i, val in pairs(vals) do
            local prop = parse_property(val.name)
            local augments = val.augments:stripchars([["'{}]]):split(",") or {}
            local augfoundlist = {}
            for k, v in pairs(prop) do
                if type(v) == "table" and v.aug then
                    for ai, av in pairs(augments) do
                        for _, a in pairs(v.aug) do
                            if av:trim():startswith(a) then
                                local aug = av:stripchars(a):trim()
                                if v.suffix then
                                    aug = aug:stripchars(v.suffix)
                                end
                                prop[k].value = (type(prop[k].value) == "number" and prop[k].value or 0) + (tonumber(aug, 10) or 0)
                                table.insert(augfoundlist, ai)
                            end
                        end
                    end
                end
            end
            if val.augments ~= "" then
                local new_augments = {}
                for ni,nv in pairs(augments) do
                    if not table_contains(augfoundlist, ni) then
                        table.insert(new_augments, augments[ni])
                    end
                end
                if #new_augments > 1 then
                    augments = table.concat(new_augments, ",")
                    table.insert(prop["その他"], "augments="..augments:enclose("{", "}"))
                end
            end
            table.insert(integ_equip[catkey], prop)
        end
    end
end

--[[GearSwapでExportした所持品を読み込み]]
for _,v in pairs(data_src) do
    read_exported_file(v)
end

--[[itemsとAugmentsを統合]]
integration_augments()

local filter = require "filter.sample"

csv_exporter(integ_equip, filter)

