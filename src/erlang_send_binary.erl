-module(erlang_send_binary).

-compile({parse_transform, ct_expand}).

-define(ITERATIONS, 100000).

% metadata copied from a trace of an HTTP put request, not using a vclock
-define(BINARY_CONST(Size),
    ct_expand:term(
        binary:copy(<<"a">>, Size)
    )
).

%%% ============================================================================
%%% Riak objects with metadata
%%% ============================================================================

horse_empty() ->
    Pid = spawn_link(fun receive_and_wait/0),
    send_message(?ITERATIONS, Pid, << >>).

horse_10() ->
    Pid = spawn_link(fun receive_and_wait/0),
    send_message(?ITERATIONS, Pid, ?BINARY_CONST(10)).

horse_63() ->
    Pid = spawn_link(fun receive_and_wait/0),
    send_message(?ITERATIONS, Pid, ?BINARY_CONST(63)).

horse_64() ->
    Pid = spawn_link(fun receive_and_wait/0),
    send_message(?ITERATIONS, Pid, ?BINARY_CONST(64)).

horse_65() ->
    Pid = spawn_link(fun receive_and_wait/0),
    send_message(?ITERATIONS, Pid, ?BINARY_CONST(65)).

horse_100() ->
    Pid = spawn_link(fun receive_and_wait/0),
    send_message(?ITERATIONS, Pid, ?BINARY_CONST(100)).

horse_1000() ->
    Pid = spawn_link(fun receive_and_wait/0),
    send_message(?ITERATIONS, Pid, ?BINARY_CONST(1000)).

%%% ============================================================================
%%% Helper functions
%%% ============================================================================

receive_and_wait() ->
    receive
        just_wait_here ->
            ok  
    after
        infinity -> ok
    end.

send_message(0, _, _) ->
    ok;
send_message(N, Pid, Msg) ->
    Pid ! Msg,
    send_message(N-1, Pid, Msg).