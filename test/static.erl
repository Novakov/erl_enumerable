%% Copyright
-module(static).
-author("Novakov").

-behaviour(enumerable).

-import(enumerable, [yield/1]).

%% API
-export([enumerate/1, start/0]).

enumerate(_) ->
        yield({value, 0}),
        yield({value, 1}),
        yield({value, 2}),
        ok.

start() -> enumerable:start(?MODULE, []).