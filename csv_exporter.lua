require "print_sjis"

function csv_exporter(integ_equip, filter)
    local header = {
        '部位',
        '名称',
        'Lv',
        'ItemLevel',
        'Ｄ',
        '防',
        '隔',
        'HP','MP',
        'STR','DEX','VIT','AGI','INT','MND','CHR',
        '命中','飛命','魔命',
        '攻','飛攻','魔攻',
        '回避','魔回避','魔防',
        '魔法ﾀﾞﾒｰｼﾞ','魔命ｽｷﾙ',
        'ﾍｲｽﾄ[%]','二刀流','ｽﾄｱTP','敵対心',
        'ﾌｧｽﾄｷｬｽﾄ[%]','ｸﾘﾃｨｶﾙﾋｯﾄ[%]','魔法ｸﾘﾃｨｶﾙﾋｯﾄ',
        'ﾀﾞﾌﾞﾙｱﾀｯｸ[%]','ﾄﾘﾌﾟﾙｱﾀｯｸ[%]','ｸﾜｯﾄﾞｱﾀｯｸ[%]',
        'ﾓｸｼｬ','MBﾀﾞﾒｰｼﾞ[%]','MBﾀﾞﾒｰｼﾞII[%]',
        '被ﾀﾞﾒｰｼﾞ[%]',
        '被物理ﾀﾞﾒｰｼﾞ[%]',
        '被魔法ﾀﾞﾒｰｼﾞ[%]',
        '被ﾌﾞﾚｽﾀﾞﾒｰｼﾞ[%]',
        'その他'
    }
    
    local date = os.date("*t")
    local datestr = string.format("%04d%02d%02d_%02d%02d%02d",date.year,date.month,date.day,date.hour,date.min,date.sec)
    for _, f in pairs(filter) do
        if type(f) ~= "table" then goto continue end
        f.race = f.race or filter.race
        f.job = f.job or filter.job
        f.level = f.level or filter.level
        local filename = "csv/"..f.race.."_"..f.job.."_Lv"..f.level.."_"..f.sortkey..(f.frac1 or "").."_"..(f.sortkey2 or "")..(f.frac2 or "").."_"..datestr..".csv"
        local fh = io.open(to_sjis(filename), "wb")
        io.output(fh)
        fh:write(table.concat(header, ",").."\r\n")

        for key,vs in pairs(integ_equip) do
            local list, result = sort(vs, f)
            
            if #list > 0 then
                for _,l in ipairs(list) do
                    local props = {}
                    table.insert(props, get_slot_ja(key))
                    table.insert(props, l.name)
                    table.insert(props, tostring(l.level))
                    table.insert(props, tostring(l.item_level))
                    for _,v in ipairs(l) do
                        table.insert(props, tostring(v.value))
                    end
                    table.insert(props, '"'..table.concat(l["その他"], "\n")..'"')
                    fh:write(table.concat(props, ",").."\r\n")
                end
            else
                fh:write(get_slot_ja(key)..","..result.."\r\n")
            end
            fh:write()
        end

        fh:flush()
        fh:close()
        ::continue::
    end
end

