defmodule Item do
  @derive [Poison.Encoder]
  defstruct [:by, :deleted, :kids]
end
