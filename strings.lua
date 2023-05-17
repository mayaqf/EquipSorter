--[[
    A few string helper functions.
    Based on Windower library
]]

local string = require "string"

_meta = _meta or {}

-- Returns true if the string contains a substring.
function string.contains(str, sub)
    return str:find(sub, nil, true) ~= nil
end

local rawsplit = function(str, sep, maxsplit, include, raw)
    if not sep or sep == '' then
        local res = {}
        local key = 0
        for c in str:gmatch('.') do
            key = key + 1
            res[key] = c
        end

        return res, key
    end

    maxsplit = maxsplit or 0
    if raw == nil then
        raw = true
    end

    local res = {}
    local key = 0
    local i = 1
    local startpos, endpos
    local match
    while i <= #str + 1 do
        -- Find the next occurence of sep.
        startpos, endpos = str:find(sep, i, raw)
        -- If found, get the substring and append it to the table.
        if startpos then
            match = str:sub(i, startpos - 1)
            key = key + 1
            res[key] = match

            if include then
                key = key + 1
                res[key] = str:sub(startpos, endpos)
            end

            -- If maximum number of splits reached, return
            if key == maxsplit - 1 then
                key = key + 1
                res[key] = str:sub(endpos + 1)
                break
            end
            i = endpos + 1
        -- If not found, no more separators to split, append the remaining string.
        else
            key = key + 1
            res[key] = str:sub(i)
            break
        end
    end

    return res, key
end


function string.split(str, sep, maxsplit, include, raw)
    local res, key = rawsplit(str, sep, maxsplit, include, raw)

    if _meta.L then
        res.n = key
        return setmetatable(res, _meta.L)
    end

    if _meta.T then
        return setmetatable(res, _meta.T)
    end

    return res
end


-- Returns a string with Lua pattern characters escaped.
function string.escape(str)
    return (str:gsub('[[%]%%^$*()%.%+?-]', '%%%1'))
end

-- Alias to string.sub, with some syntactic sugar.
function string.slice(str, from, to)
    return str:sub(from or 1, to or #str)
end


-- Removes leading and trailing whitespaces and similar characters (tabs, newlines, etc.).
function string.trim(str)
    return str:match('^%s*(.-)%s*$')
end

-- Removes all characters in chars from str.
function string.stripchars(str, chars)
    return (str:gsub('['..chars:escape()..']', ''))
end

-- Checks if a string is empty.
function string.empty(str)
    return str == ''
end

-- Checks it the string starts with the specified substring.
function string.startswith(str, substr)
    return str:sub(1, #substr) == substr
end

-- Checks it the string ends with the specified substring.
function string.endswith(str, substr)
    return str:sub(-#substr) == substr
end

-- Encloses a string in start and finish. If only one argument is provided, it will enclose it with that string both at the beginning and the end.
function string.enclose(str, start, finish)
    finish = finish or start
    return start..str..finish
end


--[[
Copyright © 2013-2015, Windower
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of Windower nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Windower BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]
