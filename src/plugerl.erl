-module(plugerl).

-ifdef(TEST).
-compile(export_all).
-endif.

-export([ over/2 ]).

over(Behaviour, Fun) when is_atom(Behaviour), is_function(Fun, 1) ->
    Plugins = find_modules(Behaviour),
    lists:map(Fun, Plugins).

%% --

find_modules(Behaviour) ->
    %% TODO cache modules with behaviours
    Mods = [ Mod || {Mod, _} <- code:all_loaded() ],
    lists:filter(behaviour(Behaviour), Mods).

behaviour(Behaviour) ->
    fun(Mod) ->
            Attributes = Mod:module_info(attributes),
            Behaviours = proplists:get_value(behaviour, Attributes, []),
            lists:member(Behaviour, Behaviours)
    end.
