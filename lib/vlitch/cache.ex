defmodule Cache do
  require Logger

  def start_link do
    Agent.start_link(fn -> Map.new end, name: __MODULE__)
  end

  @doc """
  Gets a value by `key`, if it's not present load it with `load_fn`
  """
  def get(key, load_fn, ttl) do
    ttl_val = Agent.get(__MODULE__, &Map.get(&1, key))
    case ttl_val do
      nil -> update_and_get(key, load_fn.(key), ttl)
      {-1, val} -> val
      {ttl, val} ->
        case now() do
          t when ttl <= t -> update_and_get(key, load_fn.(key), ttl)
          _ ->
            Logger.debug("Cache contained key: [#{inspect key}], value:\n#{inspect(val) |> String.slice(0, 150)} ...")
            val
        end
    end
  end

  defp update_and_get(key, val, ttl) do
    Logger.debug("Cache did not contain key: [#{inspect key}], or its TTL timed out. Fetched value from source:\n#{inspect(val) |> String.slice(0, 150)} ...")
    Agent.update(__MODULE__, &Map.put(&1, key, {ttl(ttl), val}))
    val
  end

  @doc """
  Puts the `value` for the given `key` and an optional `TTL`.
  """
  def put(key, value, ttl) do
    Agent.update(__MODULE__,
      &Map.put(&1, key, {ttl(ttl), value}))
  end

  def put(key, value) do
    Agent.update(__MODULE__,
      &Map.put(&1, key, {-1, value}))
  end

  defp now() do
    {ms, s, _} = :os.timestamp
    timestamp = (ms * 1_000_000 + s)
    timestamp
  end

  defp ttl(seconds) do
    {ms, s, _} = :os.timestamp
    timestamp = (ms * 1_000_000 + (s + seconds))
    timestamp
  end
end
