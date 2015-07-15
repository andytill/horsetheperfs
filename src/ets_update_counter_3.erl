-module(ets_update_counter_3).

-define(ITERATIONS, 200000).

%%% ============================================================================
%%% single process, there is no concurrent access
%%% ============================================================================

%%
horse_update_counter() ->
    ets:new(tab, [named_table, set]),
    ets:insert(tab, {counter, 0}),
    horse:repeat(?ITERATIONS,
        ets:update_counter(tab, counter, 1)
    ).

%%
horse_update_counter_write_concurrency() ->
    ets:new(tab, [named_table, set, {write_concurrency, true}]),
    ets:insert(tab, {counter, 0}),
    horse:repeat(?ITERATIONS,
        ets:update_counter(tab, counter, 1)
    ).

%%
horse_update_counter_read_concurrency() ->
    ets:new(tab, [named_table, set, {read_concurrency, true}]),
    ets:insert(tab, {counter, 0}),
    horse:repeat(?ITERATIONS,
        ets:update_counter(tab, counter, 1)
    ).

%%
horse_update_counter_read_write_concurrency() ->
    ets:new(tab, [named_table, set, {write_concurrency, true}, 
                                    {read_concurrency, true}]),
    ets:insert(tab, {counter, 0}),
    horse:repeat(?ITERATIONS,
        ets:update_counter(tab, counter, 1)
    ).

%%% ============================================================================
%%% single process with an ordered_set, there is no concurrent access
%%% ============================================================================

%%
horse_update_counter_ordered_set() ->
    ets:new(tab, [named_table, ordered_set]),
    ets:insert(tab, {counter, 0}),
    horse:repeat(?ITERATIONS,
        ets:update_counter(tab, counter, 1)
    ).

%%
horse_update_counter_ordered_set_write_concurrency() ->
    ets:new(tab, [named_table, ordered_set, {write_concurrency, true}]),
    ets:insert(tab, {counter, 0}),
    horse:repeat(?ITERATIONS,
        ets:update_counter(tab, counter, 1)
    ).

%%
horse_update_counter_ordered_set_read_concurrency() ->
    ets:new(tab, [named_table, ordered_set, {read_concurrency, true}]),
    ets:insert(tab, {counter, 0}),
    horse:repeat(?ITERATIONS,
        ets:update_counter(tab, counter, 1)
    ).

%%
horse_update_counter_ordered_set_read_write_concurrency() ->
    ets:new(tab, [named_table, ordered_set, {write_concurrency, true}, 
                                    {read_concurrency, true}]),
    ets:insert(tab, {counter, 0}),
    horse:repeat(?ITERATIONS,
        ets:update_counter(tab, counter, 1)
    ).