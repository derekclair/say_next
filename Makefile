default: install start

install:
	@mix do \
		local.hex --force, \
		local.rebar --force, \
		deps.get
	@mix

release.start:
	_build/prod/rel/cli/bin/cli start
release:
	@MIX_ENV=prod mix release cli

start:
	@iex -S mix
