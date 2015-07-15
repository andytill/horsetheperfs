-module(timer_sleep_1).

-define(ITERATIONS, 200000).

horse_timer_sleep_zero() ->
    horse:repeat(?ITERATIONS,
        timer:sleep(0)
    ).