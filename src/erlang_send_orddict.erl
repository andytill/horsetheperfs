%%% benchmarking sending an erlang orddict in an erlang message

-module(erlang_send_orddict).

-compile({parse_transform, ct_expand}).

-define(ITERATIONS, 300000).

% metadata copied from a trace of an HTTP put request, not using a vclock
-define(STRING_CONST,
    ct_expand:term(
        dict:from_list([
            {<<"content-type">>, "text/plain"},
            {<<"index">>, []},
            {<<"Links">>, []},
            {<<"X-Riak-Last-Modified">>, ""},
            {<<"X-Riak-Meta">>, ""},
            {<<"X-Riak-VTag">>, "HqMC7KfTrAS5TQQE20yjx"}
        ])
    )
).

%%% ============================================================================
%%% Riak objects with metadata
%%% ============================================================================

horse_send_an_empty_dict() ->
    Pid = spawn_link(
        fun() ->
            receive
                just_wait_here ->
                    ok  
            after
                infinity -> ok
            end
        end),
    send_message(?ITERATIONS, Pid, dict:new()).

% metadata copied from a trace of an HTTP put request, not using a vclock
-define(DICT_CONST,
    ct_expand:term(
        dict:from_list([
            {<<"content-type">>, "text/plain"},
            {<<"index">>, []},
            {<<"Links">>, []},
            {<<"X-Riak-Last-Modified">>, ""},
            {<<"X-Riak-Meta">>, ""},
            {<<"X-Riak-VTag">>, <<"HqMC7KfTrAS5TQQE20yjx">>}
        ])
    )
).

horse_send_a_small_dict() ->
    Pid = spawn_link(
        fun() ->
            receive
                just_wait_here ->
                    ok  
            after
                infinity -> ok
            end
        end),
    send_message(?ITERATIONS, Pid, ?DICT_CONST).

%%% ============================================================================
%%% Helper functions
%%% ============================================================================

send_message(0, _, _) ->
    ok;
send_message(N, Pid, Msg) ->
    Pid ! Msg,
    send_message(N-1, Pid, Msg).