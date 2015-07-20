# Horse the Perfs

Horse the Perfs is infrastructure for micro benchmarks. It provides the test runner, timing and logging for new micro benchmarks so that they can be written efficiently and run in a repeatable way. Lastly, it is a collection of micro benchmarks that can be re-run against new hardware and VM targets. 

Most of the interesting stuff is done using a [fork](https://github.com/andytill/horse) the excellent [horse](https://github.com/extend/horse) library.

### How to run

Clone and cd to the `horsetheperfs` directory and run:

    make deps perfs

After the firse time, only `make perfs` is necessary.

### How to add tests

Detailed information about adding horse tests can be found [there](https://github.com/andytill/horse).

In short, add a function to a new or existing erlang module in src. The function name must start with `horse_` for it to be picked up by the `horse` test runner.

If `horse:repeat/2` appears in the function, for example:

```erlang
horse_perf_test() ->
    horse:repeat(100, binary:copy(<<"hello">>)).
```

This is transformed by horse parse transform into a call tail recursive function that calls `binary:copy/1` 100 hundred times.

Variables that are created outside of the call to repeat are not accessible because they are not passed to the generated function. For example, the following will not compile.

```erlang
horse_perf_test() ->
    Bin = <<"hello">>,
    horse:repeat(100, binary:copy(Bin)).
```

Each horse function is run and timed in its own function so that garbage collection from other tests will not affect the results.

### How to profile tests

Tests can be profiled using [eflame](https://github.com/slfritchie/eflame) by changing the first part of the test name from `horse_` to `horse_eflame_`. When this is run using `make perfs` tracing is applied while the test function is executed and a flame graph is generated in the profiling directory.

Running the test with eflame profiling turned on takes much longer than without, so is only supposed to be temporary for debugging and the test duration is not a useful measurement in itself.  For this reason, the text **PROFILING** is output at the end of the result line to make this obvious.