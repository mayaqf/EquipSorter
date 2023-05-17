local _slots = {
    main = {id=1,ja="メイン"},
    sub = {id=2,ja="サブ"},
    head = {id=16,ja="頭"},
    body = {id=32,ja="胴"},
    hands = {id=64,ja="両手"},
    legs = {id=128,ja="両脚"},
    feet = {id=256,ja="両足"},
    neck = {id=512,ja="首"},
    waist = {id=1024,ja="腰"},
    earring = {id=6144,ja="イヤリング"},
    ring = {id=24576,ja="指輪"},
    back = {id=32768,ja="背"},
    range = {id=4,ja="遠隔"},
    ammo = {id=8,ja="矢弾"},
}

function get_slot_ja(slot_cat)
    for k,v in pairs(_slots) do
        if slot_cat == k then
            return v.ja
        end
    end
    return nil
end