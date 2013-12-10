%% Copyright
-module(list_enumerable).
-author("Novakov").

-behaviour(enumerable).

%% API
-export([start/1, enumerate/1]).

enumerate([]) -> done;
enumerate([H|Tail]) ->
        enumerable:yield({value, H}),
        enumerate(Tail).

start(List) ->
        enumerable:start(?MODULE, List).
