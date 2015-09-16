defmodule Accumulator do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def post(pid, name) do
    GenServer.cast(pid, {:push, name})
  end

  def scores(pid, count) do
    GenServer.call(pid, :status)
    |> Enum.sort_by(&score/1)
    |> Enum.take(count)
    |> Enum.each(fn {name, score} -> IO.puts "#{name} #{score}" end)
  end

  #-----------------------------------------------------------------

  def handle_cast({:push, name}, list) do
    list = Map.update(list, name, 1, &(&1 + 1))
    {:noreply, list}
  end

  def handle_call(:status, _, list) do
    {:reply, Map.to_list(list), list}
  end

  defp score({_, score}), do: -score
end
