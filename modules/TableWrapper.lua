local concat = require('funclib').concat
local filter = require('funclib').filter
local map = require('funclib').map
local reduce = require('funclib').reduce

local exports = {}
local TableWrapper = {}

exports.wrap = function (tbl)
    assert(type(tbl) == "table")

    local mt = getmetatable(tbl) or {}
    mt.__index     = TableWrapper;
    return setmetatable(tbl, mt)
end


function TableWrapper:filter(filter_func)
    return exports.wrap(filter(self, filter_func))
end

function TableWrapper:map(map_func)
    return exports.wrap(map(self, map_func))
end

function TableWrapper:reduce(accum, reduce_func)
    local res = reduce(accum, self, reduce_func)
    return type(res) == "table" and exports.wrap(res) or res
end

function TableWrapper:concat(...)
    return exports.wrap(concat(self, ...))
end

function TableWrapper:keys()
    local res = {}
    for k,_ in pairs(self) do
        table.insert(k)
    end
    return exports.wrap(res)
end

return exports
