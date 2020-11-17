Name
====

lua-resty-stub_status - Use FFI get http_stub_status_module's info

Table of Contents
=================

* [Name](#name)
* [Status](#status)
* [Description](#description)
* [Synopsis](#synopsis)
* [Modules](#modules)
    * [resty.stub_status](#restystub_status)
        * [Methods](#methods)
            * [enabled](#enabled)
            * [get_info](#get_info)
* [Limitations](#limitations)
* [Installation](#installation)
* [TODO](#todo)
* [Bugs and Patches](#bugs-and-patches)
* [Author](#author)
* [Copyright and License](#copyright-and-license)
* [See Also](#see-also)

Status
======

This library is still under early development and is still experimental.

Description
===========

This Lua library access ngx_http_stub_status_module provides info, use this module do not need add new `location` with `stub_status` command.

Synopsis
========

```lua
    local stub_status = require "resty.stub_status"

    local enabled = stub_status:enabled()
    if not enabled then
        ngx.log(ngx.ERR, "should build with --with-http_stub_status_module configuration parameter")
        return
    end

    local info = stub_status:get_info()
    ngx.log(ngx.INFO,
        "Active connections:", info['active'],
        "accepts:", info['accepts'], "handled:", info['handled'], "requests:", info['requests'],
        "Reading:", info['reading'], "Writing:", info['writing'], "Waiting:", info['waiting'])
```

[Back to TOC](#table-of-contents)

Modules
=======

[Back to TOC](#table-of-contents)

resty.stub_status
----------------------

To load this module, just do this

```lua
    local server = require "resty.stub_status"
```

[Back to TOC](#table-of-contents)

### Methods

[Back to TOC](#table-of-contents)

#### enabled
`syntax: enabled = stub_status:enabled()`

Determine whether the current NGINX has a compiled with `--with-http_stub_status_module` configuration parameter.

Return value `true` for compiled with `http_stub_status_module` configuration parameter, other is `false`.

[Back to TOC](#table-of-contents)

#### get_info
`syntax: info = stub_status:get_info()`

Get stub status information.
Return value `info` is one `table` which contain keys: `active`, `accepts`, `handled`, `requests`, `reading`, `writing`, `waiting`. Each value is `number`.

*`active` correspond to `ngx_http_stub_status_module` module `Active connections` field*.
*`accepts` correspond to `ngx_http_stub_status_module` module `accepts` field*.
*`handled` correspond to `ngx_http_stub_status_module` module `handled` field*.
*`requests` correspond to `ngx_http_stub_status_module` module `requests` field*.
*`reading` correspond to `ngx_http_stub_status_module` module `Reading` field*.
*`writing` correspond to `ngx_http_stub_status_module` module `Writing` field*.
*`waiting` correspond to `ngx_http_stub_status_module` module `Waiting` field*.

[Back to TOC](#table-of-contents)

Limitations
===========

* When build NGINX/OpenResty should used `--with-http_stub_status_module` and `--with-luajit` configuration parameter.

[Back to TOC](#table-of-contents)

Installation
============

You need to configure the
[lua_package_path](https://github.com/chaoslawful/lua-nginx-module#lua_package_path)
directive to add the path of your lua-resty-stub_status source tree to ngx_lua's
Lua module search path, as in

```nginx
    # nginx.conf
    http {
        lua_package_path "/path/to/lua-resty-stub_status/lib/?.lua;;";
        ...
    }
```

and then load the library in Lua:

```lua
    local stub_status = require "resty.stub_status"
```

[Back to TOC](#table-of-contents)

TODO
====

[Back to TOC](#table-of-contents)

Copyright and License
=====================

This module is licensed under the BSD license.

Copyright (C) 2013-2017, by zhoucj <juzipeek@163.com>.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[Back to TOC](#table-of-contents)

See Also
========
* the ngx_lua module: http://wiki.nginx.org/HttpLuaModule
* the ngx_http_stub_status_module: http://nginx.org/en/docs/http/ngx_http_stub_status_module.html
* the FFI library: https://luajit.org/ext_ffi.html

[Back to TOC](#table-of-contents)

