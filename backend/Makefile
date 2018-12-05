tests:
	MIX_ENV=test mix test
	cd assets && npm run test

lint:
	mix credo list
	cd assets && npm run lint

.PHONY: elixir-install
elixir-install:
	mix local.hex --force
	mix local.rebar --force
	mix deps.get
	mix compile

.PHONY: elixir-db-create
elixir-db-create:
	mix ecto.setup

elixir-release:
	cd assets && npm run-script deploy && cd ..
	@for task in "compile" "phx.digest" "release"; do \
		MIX_ENV=prod mix "$$task"; \
	done

elixir-preserve-release:
	mkdir -p "/artifacts/elixir"
	cp -R _build/prod/rel/* "/artifacts/elixir"
	mkdir -p "/artifacts/elixir/kr/releases/0.0.1/priv"
	cp -R "/code/priv/static" "/artifacts/elixir/kr/releases/0.0.1/priv"
	cp -R "/code/priv/repo" "/artifacts/elixir/kr/releases/0.0.1/priv"

node-install:
	mkdir -p '/code/assets/node_modules'
	cd '/code/assets' && npm install
	chmod -R 775 '/code/assets/node_modules'
