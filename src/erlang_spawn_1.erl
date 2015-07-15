-module(erlang_spawn_1).

-define(ITERATIONS, 200000).

horse_spawn_sleep_fun_on_one_proc() ->
    horse:repeat(?ITERATIONS,
        spawn(fun () -> timer:sleep(1000) end)
    ).


horse_spawn_fun_on_one_proc() ->
    horse:repeat(?ITERATIONS,
        spawn(fun () -> ok end)
    ).