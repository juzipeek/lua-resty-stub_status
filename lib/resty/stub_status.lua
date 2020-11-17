-- Copyright (C) zhoucj

local ffi = require "ffi"
local C = ffi.C

local pcall = pcall
local tonumber = tonumber
local ngx = ngx
local log = ngx.log
local DEBUG = ngx.DEBUG


if ffi.arch == "x86" then
    ffi.cdef[[
        typedef uint32_t                    ngx_atomic_uint_t;
    ]]
else
    ffi.cdef[[
        typedef uint64_t                    ngx_atomic_uint_t;
    ]]
end

ffi.cdef[[
    typedef volatile ngx_atomic_uint_t  ngx_atomic_t;

    ngx_atomic_t         *ngx_stat_accepted;
    ngx_atomic_t         *ngx_stat_handled;
    ngx_atomic_t         *ngx_stat_requests;
    ngx_atomic_t         *ngx_stat_active;
    ngx_atomic_t         *ngx_stat_reading;
    ngx_atomic_t         *ngx_stat_writing;
    ngx_atomic_t         *ngx_stat_waiting;
]]

local _M = {}
_M._VERSION = "0.01"

local function symbol_exist(lib, symbol)
    if lib[symbol] then
        return true
    end

    return false
end

local enabled = false
do
    local ok, exist = pcall(symbol_exist, C, "ngx_stat_accepted")
    if ok and exist then
        enabled = true
    end
end

function _M.enabled()
    return enabled
end

function _M.get_info()
    local accepted = 0
    local handled = 0
    local requests = 0

    local active = 0
    local reading = 0
    local writing = 0
    local waiting = 0

    if enabled then
        accepted = tonumber(C.ngx_stat_accepted[0])
        handled = tonumber(C.ngx_stat_handled[0])
        requests = tonumber(C.ngx_stat_requests[0])

        active = tonumber(C.ngx_stat_active[0])
        reading = tonumber(C.ngx_stat_reading[0])
        writing = tonumber(C.ngx_stat_writing[0])
        waiting = tonumber(C.ngx_stat_waiting[0])
    end

    log(DEBUG, "accepted:", accepted, "handled:", handled, "requests:", requests,
        "active:", active, "reading:", reading, "writing:", writing, "waiting:", waiting)

    return {
        accepted = accepted,
        handled = handled,
        requests = requests,

        active = active,
        reading = reading,
        writing = writing,
        waiting = waiting,
    }
end

return _M
