-module(dict_fold_3).

-compile({parse_transform, ct_expand}).

-define(ITERATIONS, 100000).

-define(DICT_CONSTANT(Size), ct_expand:term(dict:from_list([{N,N} || N <- lists:seq(1, Size)]))).

horse_empty_dict() ->
	horse:repeat(
		?ITERATIONS,
		dict:fold(fun(_, _, Acc) -> Acc end, acc, dict:new())).

horse_10_elements() ->
	horse:repeat(
		?ITERATIONS, 
		dict:fold(fun(_, _, Acc) -> Acc end, acc, ?DICT_CONSTANT(10))).

horse_100_elements() ->
	horse:repeat(
		?ITERATIONS, 
		dict:fold(fun(_, _, Acc) -> Acc end, acc, ?DICT_CONSTANT(100))).

horse_1000_elements() ->
	horse:repeat(
		?ITERATIONS, 
		dict:fold(fun(_, _, Acc) -> Acc end, acc, ?DICT_CONSTANT(1000))).