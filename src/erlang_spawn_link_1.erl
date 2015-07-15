-module(erlang_spawn_link_1).

-define(ITERATIONS, 200000).

horse_spawn_link_sleep_fun_on_one_proc() ->
    horse:repeat(?ITERATIONS,
        spawn_link(fun () -> timer:sleep(1000) end)
    ).

horse_spawn_link_fun_on_one_proc() ->
    horse:repeat(?ITERATIONS,
        spawn_link(fun () -> ok end)
    ).