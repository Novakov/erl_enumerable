-module(enumerable_tests).
-include_lib("eunit/include/eunit.hrl").

-compile(export_all).

static_enum_move_next_test() ->
        E = static:start(),
        ?assertEqual(not_started, enumerable:current(E)),
        ?assertEqual(0, enumerable:next(E)),
        ?assertEqual(1, enumerable:next(E)),
        ?assertEqual(2, enumerable:next(E)).

static_enum_eos_at_end_test() ->
        E = static:start(),
        enumerable:next(E),
        enumerable:next(E),
        enumerable:next(E),
        ?assertEqual(eos, enumerable:next(E)),
        ?assertEqual(eos, enumerable:current(E)),
        ?assertEqual(eos, enumerable:current(E)).

fibo_test() ->
        E = fibo:start(),
        ?assertEqual(1, enumerable:next(E)),
        ?assertEqual(1, enumerable:next(E)),
        ?assertEqual(2, enumerable:next(E)),
        ?assertEqual(3, enumerable:next(E)),
        ?assertEqual(5, enumerable:next(E)).

to_list_test() ->
        E = static:start(),
        List = enumerable:to_list(E),
        ?assertEqual([0,1,2], List).

take_test() ->
        E = fibo:start(),
        First5 = enumerable:take(E, 5),
        ?assertEqual([1,1,2,3,5], enumerable:to_list(First5)).

range_test() ->
        R = enumerable:range(1, 10, 1),
        ?assertEqual(lists:seq(1, 10), enumerable:to_list(R)).

where_test() ->
        R = enumerable:range(1, 10, 1),
        W = enumerable:where(R, fun(X) -> X rem 3 =:= 0 end),
        ?assertEqual([3,6,9], enumerable:to_list(W)).

select_many_list_test() ->
        R = enumerable:range(1,2,1),
        SM = enumerable:select_many(R, fun(X) -> [X, X] end),
        ?assertEqual([1,1,2,2], enumerable:to_list(SM)).

select_many_enum_test() ->
        R = enumerable:range(1,2,1),
        SM = enumerable:select_many(R, fun(X) -> enumerable:range(1,2,1) end),
        ?assertEqual([1,2,1,2], enumerable:to_list(SM)).

count_test() ->
        R = enumerable:range(1,2,1),
        ?assertEqual(2, enumerable:count(R)).

empty_test() ->
        E = enumerable:empty(),
        ?assertEqual([], enumerable:to_list(E)).

from_list_test() ->
        L = [1,2,3,4],
        E = enumerable:from_list(L),
        ?assertEqual(L, enumerable:to_list(E)).