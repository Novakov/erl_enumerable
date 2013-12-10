-module(enumerable).

-export([start/2, current/1, next/1, yield/1, to_list/1, take/2, where/2, range/3, select_many/2, count/1, empty/0, from_list/1]).

-callback enumerate(Args :: tuple()) -> none().

-spec yield(tuple(value, any()) | eos | break) -> none().
-spec start(module(), list()) -> pid().
-spec next(pid()) -> any().
-spec current(pid()) -> any().

-include_lib("eunit/include/eunit.hrl").

start(Module, Args) ->
        Wrapper = fun() ->
                wait_for_start(),
                Module:enumerate(Args),
                yield(eos)
        end,
        Pid = spawn_link(Wrapper),
        Pid.

wait_for_start() ->
        receive
                {From, next} ->
                        ok;
                {From, _} ->
                        From ! not_started,
                        wait_for_start()
        end.

yield({value, Current}) ->
        receive
                {From, current} ->
                        From ! {value, Current},
                        yield({value, Current});

                {From, next} ->
                        next
        end;
yield(eos) ->
        receive
                {From, _} ->
                        From ! eos,
                        yield(eos)
        end;
yield(break) ->
        yield(eos).

current(Pid) ->
        Pid ! {self(), current},
        receive
                {value, Value} -> Value;
                eos -> eos;
                not_started -> not_started
        end.

next(Pid) ->
        Pid ! {self(), next},
        current(Pid).

to_list(_, eos, Acc) -> Acc;
to_list(E, Value, Acc) -> to_list(E, next(E), Acc ++ [Value]).

to_list(E) ->
        to_list(E, next(E), []).

take(E, Count) ->
        take_enumerable:start(E, Count).

where(E, Predicate) ->
        where_enumerable:start(E, Predicate).

range(Start, To, Step) ->
        range_enumerable:start(Start, To, Step).

select_many(E, Expand) ->
        select_many_enumerable:start(E, Expand).

count(_, eos, Count) -> Count;
count(E, _, Count) -> count(E, next(E), Count + 1).

count(E) ->
        count(E, next(E), 0).

empty() ->
        empty_enumerable:start().

from_list(List) ->
        list_enumerable:start(List).