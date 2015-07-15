PROJECT = horsetheperfs

dep_horse = git https://github.com/andytill/horse master
dep_parse_trans = git https://github.com/uwiger/parse_trans 2.9.2
DEPS = horse parse_trans

SHELL_OPTS = -sname ${PROJECT} -setcookie ${PROJECT}

include erlang.mk

deps/horse:
	git clone -n -- https://github.com/extend/horse $(DEPS_DIR)/horse
	cd $(DEPS_DIR)/horse ; git checkout -q master
	$(MAKE) -C $(DEPS_DIR)/horse

perfs: ERLC_OPTS += -DPERF=1 +'{parse_transform, horse_autoexport}'
perfs: clean deps deps/horse app
	$(gen_verbose) erl -noshell -pa ebin deps/horse/ebin \
		-eval 'horse:app_perf($(PROJECT)), init:stop().'