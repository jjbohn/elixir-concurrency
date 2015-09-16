defmodule Analyzer do
  def run({:ok, acc} \\ Accumulator.start_link) do
    %{body: ids, status_code: 200} = Api.get!("topstories")

    ids = Poison.decode!(ids)

    items(ids, acc)
  end

  def items([], acc), do: acc
  def items([head | tail], acc) do
    item(head, acc)
    items(tail, acc)
  end

  def item(id, acc) do
    %{body: item, status_code: 200} = Api.get!("item/#{id}")

    handle_item(acc, Poison.decode!(item, as: Item))

    acc
  end

  def handle_item(_, %Item{deleted: true}), do: nil
  def handle_item(acc, item) do
    Accumulator.post(acc, item.by)
    items(kids(item), acc)
  end


  def kids(%Item{kids: nil}), do: []
  def kids(%Item{kids: kids}), do: kids
end
