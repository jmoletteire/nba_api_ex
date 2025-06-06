defmodule NBA.API.Live do
  @moduledoc false

  @base_url "https://cdn.nba.com/static/json/liveData"

  @headers [
    {"Host", "cdn.nba.com"},

    # Identifies your client (browser-like helps prevent blocking)
    {"User-Agent",
     "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36"},

    # What content types the client will accept (e.g. JSON)
    {"Accept",
     "text/html,application/json,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},

    # Enables gzip/br compression to save bandwidth
    {"Accept-Encoding", "gzip, deflate, br"},

    # Preferred language — affects localized responses (if applicable)
    {"Accept-Language", "en-US,en;q=0.9"},

    # Prevents caching - useful when data should always be fresh
    {"Cache-Control", "max-age=0"}
  ]

  @doc false
  def get(endpoint, params \\ [], opts \\ [headers: @headers]) do
    # Ensure headers are set to default if not provided
    opts =
      if Keyword.get(opts, :headers, []) in [nil, []] do
        Keyword.put(opts, :headers, @headers)
      else
        opts
      end

    # Make the request using the base request function
    # Pass the base URL, endpoint, parameters, and options
    NBA.API.Base.request(@base_url, endpoint, params, opts)
  end
end
