-module(ets_update_counter_3).

%%% ============================================================================
%%% single process threads, there is no concurrent access
%%% ============================================================================

%%
horse_update_counter() ->
    ets:new(tab, [named_table, set]),
    ets:insert(tab, {counter, 0}),
    horse:repeat(100000,
        ets:update_counter(tab, counter, 1)
    ).

%%
horse_update_counter_write_concurrency() ->
    ets:new(tab, [named_table, set, {write_concurrency, true}]),
    ets:insert(tab, {counter, 0}),
    horse:repeat(100000,
        ets:update_counter(tab, counter, 1)
    ).

%%
horse_update_counter_read_concurrency() ->
    ets:new(tab, [named_table, set, {read_concurrency, true}]),
    ets:insert(tab, {counter, 0}),
    horse:repeat(100000,
        ets:update_counter(tab, counter, 1)
    ).

%%
horse_update_counter_read_write_concurrency() ->
    ets:new(tab, [named_table, set, {write_concurrency, true}, 
                                    {read_concurrency, true}]),
    ets:insert(tab, {counter, 0}),
    horse:repeat(100000,
        ets:update_counter(tab, counter, 1)
    ).