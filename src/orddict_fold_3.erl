-module(orddict_fold_3).

-compile({parse_transform, ct_expand}).

-define(ITERATIONS, 50000).

-define(DICT_CONSTANT(Size), ct_expand:term([{N,N} || N <- lists:seq(1, Size)])).

horse_empty_dict() ->
	horse:repeat(
		?ITERATIONS, 
		orddict:fold(fun(_, _, Acc) -> Acc end, acc, orddict:new())).

horse_10_elements() ->
	horse:repeat(
		?ITERATIONS, 
		orddict:fold(fun(_, _, Acc) -> Acc end, acc, ?DICT_CONSTANT(10))).

horse_100_elements() ->
	horse:repeat(
		?ITERATIONS, 
		orddict:fold(fun(_, _, Acc) -> Acc end, acc, ?DICT_CONSTANT(100))).

horse_1000_elements() ->
	horse:repeat(
		?ITERATIONS, 
		orddict:fold(fun(_, _, Acc) -> Acc end, acc, ?DICT_CONSTANT(1000))).