require 'strings'

function sort(t, filter)
    local list = {}
    local ret = {}
    local raceid = races.get_race_id(filter.race)
    local jobid = jobs.get_job_id(filter.job)

    for i,v in pairs(t) do
        -- race check
        if not(v.races & raceid == raceid) then
            goto continue
        end
        -- level check
        if filter.level and v.level > filter.level then
            goto continue
        end
        -- job check
        if not(v.jobs & jobid == jobid) then
            goto continue
        end
        table.insert(list, v)

        -- sort
        local key1indx = get_sortkey_index(filter.sortkey)
        if not key1indx then
            print_sjis(string.format("sortkey(%s) was not found.", filter.sortkey))
            error()
        end
        local key2indx
        if filter.sortkey2 then
            key2indx = get_sortkey_index(filter.sortkey2)
            if not key2indx then
                print_sjis(string.format("sortkey2(%s) was not found.", filter.sortkey2))
                error()
            end
        end
        local frac1 = filter.frac1 or 1
        local frac2 = filter.frac2 or 1
        local is_sum = type(filter.is_sum) == "boolean" and filter.is_sum or false

        if filter.property then
            table.sort(list, function (a, b) return property_order(a, b, filter.property) end)
        end

        if filter.sortkey2 ~= nil then
            if filter.is_sum then
                if frac1 > frac2 then
                    table.sort(list, function (a, b) return simple_order(a, b, key2indx) end)
                    table.sort(list, function (a, b) return simple_order(a, b, key1indx) end)
                else
                    table.sort(list, function (a, b) return simple_order(a, b, key1indx) end)
                    table.sort(list, function (a, b) return simple_order(a, b, key2indx) end)
                end
                table.sort(list, function (a, b) return sum_order(a, b, key1indx, key2indx, frac1, frac2) end)
            else
                table.sort(list, function (a, b) return simple_order(a, b, key2indx) end)
                table.sort(list, function (a, b) return simple_order(a, b, key1indx) end)
            end
        else
            table.sort(list, function (a, b) return simple_order(a, b, key1indx) end)
        end

        ::continue::
    end

    local keyindx1 = get_sortkey_index(filter.sortkey)
    local keyindx2
    if filter.sortkey2 then 
        keyindx2 = get_sortkey_index(filter.sortkey2)
    end
    if #list == 0 then return {}, "not found." end
    local count = 0
    local index = 1
    while true do
        if list[index][keyindx1].value ~= "" 
            or (keyindx2 and list[index][keyindx2].value ~= "")
            or (filter.property and (table.concat(list[index]['その他'], " ") or ""):contains(filter.property)) then
            table.insert(ret, list[index])
            count = count + 1
        end
        index = index + 1
        if index > #list or count >= filter.topmost then
            break
        end
    end
    
    if #ret == 0 then
        return {}, "not found."
    else
        return ret, "found "..#ret.."."
    end
end

--- 単項目の単純比較
function simple_order(a, b, id)
    return (math.abs(tonumber(a[id].value) or 0)) > (math.abs(tonumber(b[id].value) or 0))
end

--- 係数を掛けた結果の合計で比較
function sum_order(a, b, id1, id2, frac1, frac2)
    return (math.abs((tonumber(a[id1].value) or 0) * frac1) + math.abs((tonumber(a[id2].value) or 0) * frac2))
    > (math.abs((tonumber(b[id1].value) or 0) * frac1) + math.abs((tonumber(b[id2].value) or 0) * frac2))
end

--- プロパティに指定文字が含まれるか
function property_order(a, b, prop)
    return (table.concat(a['その他']," ") or ""):contains(prop) and not (table.concat(b['その他']," ") or ""):contains(prop)
end

--- property_table 内の sortkey の index を取得。
function get_sortkey_index(sortkey)
    local proptbl = init_property_table()
    for i,v in ipairs(proptbl) do
        if sortkey == v.en or sortkey == v.ja then
            return i
        end
    end
    return nil
end
