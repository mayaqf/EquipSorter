local _races = require "resources.races"
_races[510] = {id=510,en="All races",ja="全種族",gender="♂♀"}
_races[212] = {id=212,en="♀",ja="♀",gender="♀"}
_races[298] = {id=298,en="♂",ja="♂",gender="♂"}
_races[96] = {id=96,en="TarTar",ja="タルタル",gender="♂♀"}

local races = {res = _races}

function races.get_race(id)
    if type(id) ~= "number" then return "nil" end
    if id == _races[510].id then return _races[510].ja
    elseif id == _races[212].id then return _races[212].ja
    elseif id == _races[298].id then return _races[298].ja
    end
    for _, v in pairs(_races) do
        if ((id >> v.id ) & 1) == 1 then return v.ja end
    end
    return "不明"
end


function races.get_race_id(race)
    for i, v in pairs(_races) do
        if v.en == race or v.ja == race then
            return 1 << v.id
        end
    end
    return nil
end

return races