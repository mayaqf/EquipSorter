# EquipSorter
[GearSwap](https://github.com/Windower/Lua/tree/dev/addons/GearSwap) で Export した Itemリスト.lua ファイルと、Windower のリソースファイルを使用してソートした結果を csvファイルとして出力します。<br><br>

# Lua Version
Lua 5.4<br><br>

# 使用方法

1. EquipSorter/resources フォルダに以下の Windower の resファイルをコピーする
    * item_descriptions.lua
    * items.lua
    * jobs.lua
    * races.lua
    * slots.lua
    <br><br>
1. EquipSorter/data フォルダに、GearSwap で Export した Itemリスト.lua をコピーする。<br>GearSwap のコマンドは `gs export item all` など。詳しくは GearSwap の README を参照。<br><br>
1. EquipSorter/filter フォルダ内の sample.lua を参考に、自分用のフィルタ設定ファイルを作成する。sortkey に設定できる項目は、property_table.lua 内の `en="Accuracy",ja="命中"` となっているもの。 en か ja のどちらかで指定できます。<br>sortkey は2つまで対応。sortkey2 でソートしたあとにさらに sortkey でソートします。が、思ったような結果になっていない気がします……。<br><br>
1. EquipSorter.lua の以下のコード部分を変更して、GearSwap のファイル名に書き換えます。
    ``` lua
    local data_src = {
        --[[ list here "data/GeawSwapExportedItemss.lua" ]]
        "data/Mayaqf 2023-05-12 20-08-24.lua",
    }
    ```
1. また、さらにEquipSorter.lua の以下のコード部分を変更して、自分用に作成したフィルタ設定ファイルを指定します。
    ``` lua 
    local filter = require "filter.sample"
    ```
1. EquipSorter.lua を実行すると、csvフォルダにファイルが出力されます。<br><br>

# 注意点
出力する csvファイルの文字コードは UTF-8 (BOMなし) です。MS Excel ではそのまま文字化けして読めませんので、UTF-8 (BOMなし) -> UTF-8 (BOM付き) に変換するソフトを適宜使用してください。<br><br>

# LICENSE
see [LICENSE](https://github.com/mayaqf/EquipSorter/blob/main/LICENSE)
