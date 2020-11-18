# vim:set ft= ts=4 sw=4 et:

use Test::Nginx::Socket::Lua;
use Cwd qw(cwd);

repeat_each(1);

plan tests => repeat_each() * ( 3*blocks() );

my $pwd = cwd();

our $HttpConfig = qq{
    lua_package_path "$pwd/lib/?.lua;;";
    #lua_package_cpath "/usr/local/openresty-debug/lualib/?.so;/usr/local/openresty/lualib/?.so;;";
};

no_long_string();
#no_diff();

run_tests();

__DATA__

=== TEST 1: enabled
--- http_config eval: $::HttpConfig
--- config
    location = /t {
        content_by_lua_block{
            local stub_status = require "resty.stub_status"
            local enabled = stub_status:enabled()
            ngx.say(enabled)
        }
    }
--- request
    GET /t
--- response_body_like
^true|false.*$
--- no_error_log
[error]



=== TEST 2: get info
--- http_config eval: $::HttpConfig
--- config
    location = /t {
        content_by_lua_block{
            local stub_status = require "resty.stub_status"
            local info = stub_status:get_info()
            ngx.say(info['accepted'], info['handled'], info['requests'], info['active'], info['reading'], info['writing'], info['waiting'])
        }
    }
--- request
    GET /t
--- response_body
0000000

--- no_error_log
[error]
