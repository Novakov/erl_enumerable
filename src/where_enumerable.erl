%% Copyright
-module(where_enumerable).
-author("Novakov").

-behaviour(enumerable).

%% API
-export([start/2, enumerate/1]).

enumerate({Base, Predicate}) ->
        BaseValue = enumerable:next(Base),
        case BaseValue of
                eos -> ok;
                X -> case Predicate(X) of
                        true -> enumerable:yield({value, BaseValue});
                        false -> skip
                     end,
                     enumerate({Base, Predicate})
        end.

start(Base, Predicate) ->
        enumerable:start(?MODULE, {Base, Predicate}).