%% Copyright
-module(range_enumerable).
-author("Novakov").

-behaviour(enumerable).

%% API
-export([start/3, enumerate/1]).

enumerate({Current, To, Step}) when Current > To -> ok;
enumerate({Current, To, Step}) ->
        enumerable:yield({value, Current}),
        enumerate({Current + Step, To, Step}).


start(Start, To, Step) ->
     enumerable:start(?MODULE, {Start, To, Step}).