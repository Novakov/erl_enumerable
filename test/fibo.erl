%% Copyright
-module(fibo).
-author("Novakov").

-behaviour(enumerable).

-export([enumerate/1, start/0]).

-import(enumerable, [yield/1]).

enumerate({A, B}) ->
        yield({value, A}),
        enumerate({B, A + B}).

start() -> enumerable:start(?MODULE, {1,1}).