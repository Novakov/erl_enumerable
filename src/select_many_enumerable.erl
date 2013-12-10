%% Copyright
-module(select_many_enumerable).
-author("Novakov").

-import(enumerable, [yield/1]).

%% API
-export([enumerate/1, start/2]).

yield_expanded(Expanded) when is_pid(Expanded) ->
        case enumerable:next(Expanded) of
                eos -> ok;
                Value ->
                        enumerable:yield({value, Value}),
                        yield_expanded(Expanded)
        end;
yield_expanded([]) -> ok;
yield_expanded([H|T]) ->
        yield({value, H}),
        yield_expanded(T).

enumerate({Base, Expand}) ->
        case enumerable:next(Base) of
           eos -> ok;
           BaseValue ->
                   Expanded = Expand(BaseValue),
                   yield_expanded(Expanded),
                   enumerate({Base, Expand})
        end.

start(Base, Expand) ->
        enumerable:start(?MODULE, {Base, Expand}).
