defmodule SayNext.Worker do
  use GenServer

  @say ["next"]
  # @say ["shut up"]

  @spec start_link(GenServer.options()) :: GenServer.on_start()
  def start_link(opts \\ []), do: GenServer.start_link(__MODULE__, [opts])

  def child_spec(opts) do
    %{
      id: __MODULE__,
      restart: :transient,
      start: {__MODULE__, :start_link, opts},
      type: :worker
    }
  end

  def init(_init_arg), do: {:ok, %{said_it: 0, status: :say_it}, 100}

  def handle_continue(:wait_for_it, state) do
    IO.puts("Pausing for effect...")
    {:noreply, %{state | status: :pause_for_effect}, Enum.random(1_200..2_600)}
  end

  def handle_info(:timeout, state) do
    IO.puts("NEXT")

    {:spawn_executable, System.find_executable("say")}
    |> Port.open(args: @say)
    |> Port.monitor()

    {:noreply, %{state | status: :saying_it}}
  end

  def handle_info({:DOWN, _ref, :port, _obj, _reason}, state) do
    {:noreply, %{state | said_it: state.said_it + 1, status: :said_it}, {:continue, :wait_for_it}}
  end
end
