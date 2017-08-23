Plugerl
=======

[![Travis](https://img.shields.io/travis/expelledboy/plugerl.svg)](https://travis-ci.org/expelledboy/plugerl)
[![Hex.pm](https://img.shields.io/hexpm/v/plugerl.svg)](https://hex.pm/packages/plugerl)
[![Hex.pm](https://img.shields.io/hexpm/dt/plugerl.svg)](https://hex.pm/packages/plugerl)

Most simple plugin system using Erlang behaviours.

### Usage

Module that uses plugins.

```erlang
-callback install(Config :: map()) -> ok | {error, atom()}.

main() ->
    Config = project:config(),
    plugerl:over(my_behaviour, with_my_behaviours(Config)),
    loop().

loop() ->
    receive Msg -> io:format("~p~n", [Msg]) end,
    loop().

with_my_behaviours(Config) ->
    fun(Plugin) ->
        Plugin:install(Config)
    end.
```

Plugin module.

```erlang
install(Config) ->
    Timeout = maps:get(timeout, Config, 10),
    timer:send_interval(Timeout, from_plugin).
```
