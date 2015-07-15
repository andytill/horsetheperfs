-module(erlang_split_binary_2).

-compile({parse_transform, ct_expand}).

-define(ITERATIONS, 800000).

-define(BINARY_CONSTANT(Size), ct_expand:term(binary:copy(<<"1">>, Size))).

horse_split_binary_small_2() ->
    horse:repeat(
        ?ITERATIONS, 
        _ = split_binary(?BINARY_CONSTANT(50), 25)).

horse_split_binary_large_2() ->
    horse:repeat(
        ?ITERATIONS, 
        _ = split_binary(?BINARY_CONSTANT(10000), 5000)).

horse_split_binary_very_large_2() ->
    horse:repeat(
        ?ITERATIONS, 
        _ = split_binary(?BINARY_CONSTANT(100000), 50000)).


horse_syntax_split_binary_small_2() ->
    horse:repeat(
        ?ITERATIONS, 
        <<_:25/binary, _/binary>> = ?BINARY_CONSTANT(50)).

horse_syntax_split_binary_large_2() ->
    horse:repeat(
        ?ITERATIONS, 
        <<_:5000/binary, _/binary>> = ?BINARY_CONSTANT(10000)).

horse_syntax_split_binary_very_large_2() ->
    horse:repeat(
        ?ITERATIONS, 
        <<_:50000/binary, _/binary>> = ?BINARY_CONSTANT(100000)).
