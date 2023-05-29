return {
    race = "タルタル♂", -- 必須項目。指定できる記述は resources/races.lua 参照。
    level = 99, -- オプション。指定したレベル以下のアイテムに絞り込みます。指定しないと装備Lvでフィルタしません。ItemLevelには非対応。
    job = "青", -- 必須項目。指定できる記述は resources/jobs.lua 参照。
    {
        topmost = 5,
        sortkey = "命中",
    },
    {
        topmost = 5,
        sortkey = "二刀流",
        property = "二刀流"
    },
    {
        topmost = 5,
        sortkey = "ストアTP",
        property = "ストアTP"
    },
    {
        topmost = 5,
        sortkey = "被ダメージ",
    },
    {
        topmost = 5,
        sortkey = "ファストキャスト",
        sortkey2 = "ヘイスト",
    },
    {
        topmost = 5,
        sortkey = "ヘイスト",
        sortkey2 = "ファストキャスト",
    },
    {
        topmost = 10,
        sortkey = "魔命",
        sortkey2 = "魔攻",
        is_sum = true,
    },
    {
        topmost = 5,
        sortkey = "STR",
        sortkey2 = "MND",
        frac1 = 0.5,
        frac2 = 0.5,
        is_sum = true,
    },
    {
        topmost = 5,
        sortkey = "STR",
        sortkey2 = "MND",
        frac1 = 0.3,
        frac2 = 0.5,
        is_sum = true,
    },
}