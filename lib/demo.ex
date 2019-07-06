defmodule Demo do
  def child_spec(_args) do
    Redix.child_spec({"redis://localhost:6379", name: Demo.Redis})
  end

  def run(n) do
    IO.puts("Memory before: #{memory()}")

    0..n
    |> Enum.map(fn idx-> ["SET", "key:#{idx}", "value:#{idx}"] end)
    |> save()

    IO.puts("Memory after: #{memory()}")

    :ok
  end

  defp save(commands) do
    Redix.noreply_pipeline(Demo.Redis, commands)
  end

  defp memory do
    :erlang.memory() |> Keyword.get(:total)
  end
end
