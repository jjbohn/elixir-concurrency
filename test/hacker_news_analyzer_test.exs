defmodule HackerNewsAnalyzerTest do
  use ExUnit.Case
  doctest HackerNewsAnalyzer

  @tag timeout: 1000 * 1000
  test "the truth" do
    HackerNewsAnalyzer.run
  end
end
