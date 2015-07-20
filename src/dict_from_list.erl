-module(dict_from_list).

horse_2_elements() ->
	horse:repeat(
		10000, 
		dict:from_list([{"andy", 234234234}, {"bob", 2345235345345}])
	).