defmodule NBA.API.Base do
  @moduledoc false

  alias Req

  @doc false
  def request(base_url, endpoint, params, opts) do
    # Sort parameters by key to ensure consistent ordering
    # This matters for some requests that are sensitive to parameter order
    sorted_params = Enum.sort_by(params, fn {k, _} -> to_string(k) end)

    # Encode parameters into a query string and construct the full URL
    # - `URI.encode_query/1` is used to encode the parameters into a query string
    # - `then/2` is used to create the final URL
    # Example:
    #   params = [Season: "2022-23", PlayerID: 2544]
    #   sorted_params = [PlayerID: 2544, Season: "2022-23"]
    #   encoded_params = URI.encode_query(sorted_params)
    #   url = "https://stats.nba.com/stats/#{endpoint}?#{encoded_params}"
    #   url = "https://stats.nba.com/stats/playerawards?PlayerID=2544&Season=2022-23"
    #
    url =
      if sorted_params == [] do
        "#{base_url}/#{endpoint}"
      else
        URI.encode_query(sorted_params)
        |> then(&"#{base_url}/#{endpoint}?#{&1}")
      end

    # IO.inspect(url, label: "URL")
    # IO.inspect(opts[:headers], label: "Headers")

    # Make the HTTP GET request and parse the response
    case Req.get(url, opts) do
      {:ok, %Req.Response{status: status, body: %{"resultSets" => sets}}}
      when is_list(sets) ->
        formatted =
          sets
          |> Enum.map(fn %{"name" => name, "headers" => headers, "rowSet" => rows} ->
            {
              name,
              Enum.map(rows, fn row -> Enum.zip(headers, row) |> Map.new() end)
            }
          end)
          |> Enum.into(%{})

        {:ok, %{status: status, data: formatted}}

      # Stats API responses are usually in the form of a JSON object
      # with a "resultSets" key containing the data
      {:ok,
       %Req.Response{
         status: status,
         body: %{"resultSets" => [%{"rowSet" => rows, "headers" => headers}]}
       }} ->
        formatted =
          rows
          |> Enum.map(&Enum.zip(headers, &1))
          |> Enum.map(&Enum.into(&1, %{}))

        {:ok, %{status: status, data: formatted}}

      {:ok,
       %Req.Response{
         status: status,
         body: %{"resultSet" => %{"rowSet" => rows, "headers" => headers}}
       }} ->
        formatted =
          rows
          |> Enum.map(&Enum.zip(headers, &1))
          |> Enum.map(&Enum.into(&1, %{}))

        {:ok, %{status: status, data: formatted}}

      # Live BoxScore and PBP API responses are usually in the form of a
      # JSON object with a "game" key containing the data
      {:ok,
       %Req.Response{
         status: status,
         body: %{"game" => game}
       }} ->
        {:ok, %{status: status, data: game}}

      # Live Odds API responses are usually in the form of a
      # JSON object with a "games" key containing the data
      {:ok,
       %Req.Response{
         status: status,
         body: %{"games" => games}
       }} ->
        {:ok, %{status: status, data: games}}

      # Live Scoreboard API responses are usually in plain text format
      # with a "scoreboard" key containing the data
      {:ok, %Req.Response{status: status, body: body}} when is_binary(body) ->
        case Jason.decode(body) do
          {:ok, %{"scoreboard" => scoreboard}} ->
            {:ok, %{status: status, data: scoreboard}}

          {:ok, decoded} ->
            {:error, "Unexpected JSON structure: #{inspect(decoded)}"}

          {:error, err} ->
            {:error, err}
        end

      {:ok, %Req.Response{status: 400}} ->
        {:error, "Bad request (400). Check your query parameters."}

      {:ok, %Req.Response{status: 401}} ->
        {:error, "Unauthorized (401). NBA may be rejecting requests without proper headers."}

      {:ok, %Req.Response{status: 403}} ->
        {:error, "Forbidden (403). You may be blocked or missing required headers."}

      {:ok, %Req.Response{status: 404}} ->
        {:error, "Endpoint not found (404). Check the endpoint name."}

      {:ok, %Req.Response{status: 429}} ->
        {:error, "Rate limited (429). Too many requests — try again later."}

      {:ok, %Req.Response{status: 500..599 = status}} ->
        {:error, "NBA API server error (#{status}). Try again later."}

      # Handle unexpected JSON structures
      {:ok, %Req.Response{status: status, body: nil}} ->
        {:error, "Empty response body (#{status})."}

      {:ok, %Req.Response{status: status, body: body}} when is_map(body) ->
        {:ok, %{status: status, data: body}}

      {:ok, %Req.Response{status: status, body: body}} ->
        {:error, "Unrecognized JSON structure (#{status}): #{inspect(body)}"}

      {:error, err} ->
        {:error, err}
    end
  end
end
