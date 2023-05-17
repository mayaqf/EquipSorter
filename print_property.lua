function print_property(prop)
    print_sjis("name: "..(prop.name or "nil").." 種族: "..races.get_race(prop.races))
    local p = {}
    local key
    table.insert(p, property_tostring(prop, "Ｄ"))
    table.insert(p, property_tostring(prop, "防"))
    table.insert(p, property_tostring(prop, "隔"))
    table.insert(p, property_tostring(prop, "HP"))
    table.insert(p, property_tostring(prop, "MP"))
    print_sjis(table.concat(p, " "))
    p = {}
    table.insert(p, property_tostring(prop, "STR"))
    table.insert(p, property_tostring(prop, "DEX"))
    table.insert(p, property_tostring(prop, "VIT"))
    table.insert(p, property_tostring(prop, "AGI"))
    table.insert(p, property_tostring(prop, "INT"))
    table.insert(p, property_tostring(prop, "MND"))
    table.insert(p, property_tostring(prop, "CHR"))
    print_sjis(table.concat(p, " "))
    p = {}
    table.insert(p, property_tostring(prop, "命中"))
    table.insert(p, property_tostring(prop, "飛命"))
    table.insert(p, property_tostring(prop, "魔命"))
    table.insert(p, property_tostring(prop, "攻"))
    table.insert(p, property_tostring(prop, "飛攻"))
    table.insert(p, property_tostring(prop, "魔攻"))
    table.insert(p, property_tostring(prop, "回避"))
    table.insert(p, property_tostring(prop, "魔回避"))
    table.insert(p, property_tostring(prop, "魔防"))
    print_sjis(table.concat(p, " "))
    p = {}
    table.insert(p, property_tostring(prop, "魔法ダメージ"))
    table.insert(p, property_tostring(prop, "ヘイスト"))
    table.insert(p, property_tostring(prop, "二刀流"))
    table.insert(p, property_tostring(prop, "ストアTP"))
    table.insert(p, property_tostring(prop, "敵対心"))
    table.insert(p, property_tostring(prop, "ファストキャスト"))
    table.insert(p, property_tostring(prop, "クリティカルヒット"))
    table.insert(p, property_tostring(prop, "ダブルアタック"))
    table.insert(p, property_tostring(prop, "トリプルアタック"))
    table.insert(p, property_tostring(prop, "クワッドアタック"))
    table.insert(p, property_tostring(prop, "モクシャ"))
    print_sjis(table.concat(p, " "))
    p = {}
    table.insert(p, property_tostring(prop, "被ダメージ"))
    table.insert(p, property_tostring(prop, "被物理ダメージ"))
    table.insert(p, property_tostring(prop, "被魔法ダメージ"))
    table.insert(p, property_tostring(prop, "被ブレスダメージ"))
    print_sjis(table.concat(p, " "))
    p = {}
    for i = 1 , #prop["その他"] do
        print_sjis(prop["その他"][i])
    end
    print_sjis("level: "..(prop.level or "nil").."～ "..jobs.get_jobs(prop.jobs))
    if prop.item_level then print_sjis("<ItemLevel: "..prop.item_level..">") end
    print()
end
