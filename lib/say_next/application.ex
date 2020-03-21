defmodule SayNext.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {SayNext.Worker, []}
    ]

    opts = [strategy: :one_for_one, name: SayNext.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
