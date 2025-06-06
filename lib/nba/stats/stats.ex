defmodule NBA.API.Stats do
  @moduledoc false

  @base_url "https://stats.nba.com/stats"

  @headers [
    {"Host", "stats.nba.com"},

    # Identifies your client (browser-like helps prevent blocking)
    {"User-Agent",
     "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0"},

    # What content types the client will accept (e.g. JSON)
    {"Accept", "application/json, text/plain, */*"},

    # Enables gzip/br compression to save bandwidth
    {"Accept-Encoding", "gzip, deflate, br"},

    # Preferred language — affects localized responses (if applicable)
    {"Accept-Language", "en-US,en;q=0.9"},

    # Custom NBA header — seems to flag request as coming
    # from stats.nba.com
    {"x-nba-stats-origin", "stats"},

    # Custom NBA token ("true") — unclear purpose but consistently
    # required by the API
    {"x-nba-stats-token", "true"},

    # Important for CORS checks - some endpoints reject requests without
    # the proper referer
    {"Referer", "https://stats.nba.com/"},

    # Prevents caching - useful when data should always be fresh
    {"Cache-Control", "no-cache"}
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
