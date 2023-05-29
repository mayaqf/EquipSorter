function init_property_table()
    return {
        name = nil,
        races = nil,
        jobs = nil,
        level = nil,
        slots = nil,
        item_level = nil,
        {en="DMG:",ja="Ｄ",value= "", suffix= nil, aug={"DMG:"}},
        {en="DEF:",ja="防",value= "", suffix= nil, aug={"DEF:"}},
        {en="Delay:",ja="隔",value= "", suffix= nil, aug={"Delay:"}},
        {en="HP",ja="HP",value= "", suffix= nil, aug={"HP"}},
        {en="MP",ja="MP",value= "", suffix= nil, aug={"MP"}},
        {en="STR",ja="STR",value= "", suffix= nil, aug={"STR"}},
        {en="DEX",ja="DEX",value= "", suffix= nil, aug={"DEX"}},
        {en="VIT",ja="VIT",value= "", suffix= nil, aug={"VIT"}},
        {en="AGI",ja="AGI",value= "", suffix= nil, aug={"AGI"}},
        {en="INT",ja="INT",value= "", suffix= nil, aug={"INT"}},
        {en="MND",ja="MND",value= "", suffix= nil, aug={"MND"}},
        {en="CHR",ja="CHR",value= "", suffix= nil, aug={"CHR"}},
        {en="Accuracy",ja="命中",value= "", suffix= nil, aug={"Accuracy"}},
        {en="Ranged Accuracy",ja="飛命",value= "", suffix= nil, aug={"Rng. Acc."}},
        {en="Magic Accuracy",ja="魔命",value= "", suffix= nil, aug={"Mag. Acc."}},
        {en="Attack",ja="攻",value= "", suffix= nil, aug={"Attack"}},
        {en="Ranged Attack",ja="飛攻",value= "", suffix= nil, aug={"Rng. Atk."}},
        {en="Magic Atk. Bonus",ja="魔攻",value= "", suffix= nil, aug={"Mag.Atk.Bns.","Mag. Atk. Bns."}},
        {en="Evasion",ja="回避",value= "", suffix= nil, aug={"Evasion"}},
        {en="Magic Evasion",ja="魔回避",value= "", suffix= nil, aug={"Mag. Evasion"}},
        {en="Magic Def. Bonus",ja="魔防",value= "", suffix= nil, aug={"Mag. Def. Bns."}},
        {en="Magic Damage",ja="魔法ダメージ",value= "", suffix= nil, aug={"Mag. Dmg."}},
        {en="Magic Accuracy skill",ja="魔命スキル",value= "", suffix= nil, aug={}},
        {en="Haste",ja="ヘイスト",value= "", suffix="%", aug={"Haste"}},
        {en="Dual Wield",ja="二刀流",value= "", suffix= nil, aug={"Dual Wield"}},
        {en="Store TP",ja="ストアTP",value= "", suffix= nil, aug={"Store TP"}},
        {en="Enmity",ja="敵対心",value= "", suffix= nil, aug={"Enmity"}},
        {en="Fast Cast",ja="ファストキャスト",value= "", suffix="%", aug={"Fast Cast"}},
        {en="Critical hit rate ",ja="クリティカルヒット",value= "", suffix= "%", aug={"Critical hit rate "}},
        {en="Magic critical hit rate ",ja="魔法クリティカルヒット",value= "", suffix= nil, aug={"Magic crit. hit rate "}},
        {en="Double Attack",ja="ダブルアタック",value= "", suffix="%", aug={"Double Atk.","Double Attack","Dbl.Atk."}},
        {en="Triple Attack",ja="トリプルアタック",value= "", suffix="%", aug={"Triple Atk.","Triple Attack"}},
        {en="Quad Attack",ja="クワッドアタック",value= "", suffix="%", aug={"Quadruple Attack "}},
        {en="Subtle Blow",ja="モクシャ",value= "", suffix= nil, aug={"Subtle Blow"}},
        {en="Magic burst damage",ja="マジックバーストダメージ",value= "", suffix= nil, aug={"Magic burst dmg. ","Magic burst damage "}},
        {en="Magic burst damage II",ja="マジックバーストダメージII",value= "", suffix="%", aug={"Magic burst dmg. II","Magic burst damage II"}},
        {en="Damage taken ",ja="被ダメージ",value= "", suffix="%", aug={"Damage Taken "}},
        {en="Physical damage taken ",ja="被物理ダメージ",value= "", suffix="%", aug={"Phys. dmg. taken "}},
        {en="Magic damage taken ",ja="被魔法ダメージ",value= "", suffix="%", aug={"Magic dmg. taken "}},
        {en="Breath damage taken ",ja="被ブレスダメージ",value= "", suffix="%", aug={"Breath dmg. taken "}},
        ["その他"] = {},
    }
end

function property_tostring(prop, key)
    for k,v in pairs(prop) do
        if type(v) == "table" and v.ja and v.ja == key and type(v.value) == "number" then
            return key.."="..v.value..(v.suffix or "")
        end
    end
    return nil
end
