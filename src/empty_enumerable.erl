%% Copyright
-module(empty_enumerable).
-author("Novakov").

-behaviour(enumerable).

%% API
-export([start/0, enumerate/1]).

enumerate(_) -> ok.

start()->
        enumerable:start(?MODULE, none).
