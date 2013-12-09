%% Copyright
-module(take_enumerable).
-author("Novakov").
-include_lib("eunit/include/eunit.hrl").
-behaviour(enumerable).

-import(enumerable,[yield/1, next/1]).

%% API
-export([enumerate/1, start/2]).

enumerate({_, 0}) -> ok;
enumerate({Base, Count}) ->
        Next = next(Base),
        yield({value, Next}),
        enumerate({Base, Count - 1}).

start(Base, Count) -> enumerable:start(?MODULE, {Base, Count}).

