defmodule Api do
  use HTTPoison.Base

  def process_url(url) do
    "https://hacker-news.firebaseio.com/v0/#{url}.json"
  end
end
