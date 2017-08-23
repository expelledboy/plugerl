-module(plugerl_tests).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

over_test() ->
    EunitListeners = [eunit_tty, eunit_progress],
    Check = fun(Listener) -> ?assert(lists:member(Listener, EunitListeners)) end,
    Results = plugerl:over(eunit_listener, Check),
    ?assertEqual(length(Results), length(EunitListeners)).
