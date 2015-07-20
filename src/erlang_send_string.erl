-module(erlang_send_string).

-compile({parse_transform, ct_expand}).

-define(ITERATIONS, 100000).

% metadata copied from a trace of an HTTP put request, not using a vclock
-define(STRING_CONST(Length),
    ct_expand:term(
        string:copies("a", Length)
    )
).

%%% ============================================================================
%%% Riak objects with metadata
%%% ============================================================================

horse_empty() ->
    Pid = spawn_link(fun receive_and_wait/0),
    send_message(?ITERATIONS, Pid, "").

horse_10() ->
    Pid = spawn_link(fun receive_and_wait/0),
    send_message(?ITERATIONS, Pid, ?STRING_CONST(10)).

horse_100() ->
    Pid = spawn_link(fun receive_and_wait/0),
    send_message(?ITERATIONS, Pid, ?STRING_CONST(100)).

horse_1000() ->
    Pid = spawn_link(fun receive_and_wait/0),
    send_message(?ITERATIONS, Pid, ?STRING_CONST(1000)).

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