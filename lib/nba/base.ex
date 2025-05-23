defmodule NBA.API.Base do
  @moduledoc """
  Shared HTTP request logic for NBA API modules.
  Handles param sorting, URL construction, request, and response parsing.
  """

  alias Req

  @doc """
  Fetches data from the NBA API.
  ## Parameters
  - `base_url`: The base URL for the API (e.g., "https://stats.nba.com/stats").
  - `endpoint`: The API endpoint to fetch data from.
  - `params`: A keyword list of query parameters to include in the request.
  - `opts`: Additional options for the request (see: https://hexdocs.pm/req/Req.html#new/1).
  ## Returns
  - `{:ok, response}`: A tuple containing the status and parsed response body.
  - `{:error, reason}`: An error tuple with the reason for failure.
  ## Notes
  - Sorts the parameters by key to ensure consistent ordering.
  - Encodes the parameters into a query string and constructs the full URL.
  - Handles various HTTP response statuses and returns appropriate error messages.
  - Uses the Req library for making HTTP requests.
  ## Example
      iex> NBA.API.Base.request("https://stats.nba.com/stats", [], "playerawards", PlayerID: 2544)
      {:ok, %{status: 200, body: %{"resultSets" => [%{"rowSet" => rows, "headers" => headers}]}}}
  """
  @spec request(String.t(), String.t(), keyword(), keyword()) ::
          {:ok, map()} | {:error, any()}
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

      # BoxScore and PBP API responses are usually in the form of a
      # JSON object with a "game" key containing the data
      {:ok,
       %Req.Response{
         status: status,
         body: %{"game" => game}
       }} ->
        {:ok, %{status: status, data: game}}

      # Odds API responses are usually in the form of a
      # JSON object with a "games" key containing the data
      {:ok,
       %Req.Response{
         status: status,
         body: %{"games" => games}
       }} ->
        {:ok, %{status: status, data: games}}

      # Scoreboard API responses are usually in plain text format
      # with a "scoreboard" key containing the data
      {:ok, %Req.Response{status: status, body: body}} when is_binary(body) ->
        case Jason.decode(body) do
          {:ok, %{"scoreboard" => scoreboard}} ->
            {:ok, %{status: status, data: scoreboard}}

          {:ok, decoded} ->
            {:error, "Unexpected JSON structure: #{inspect(decoded)}"}

          {:error, err} ->
            {:error, "Failed to parse JSON: #{inspect(err)}"}
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
      {:ok, %Req.Response{status: status, body: body}} when is_map(body) ->
        {:ok, %{status: status, data: body}}

      {:ok, %Req.Response{status: status, body: body}} ->
        {:error, "Unrecognized JSON structure (#{status}): #{inspect(body)}"}

      {:ok, %Req.Response{status: status, body: nil}} ->
        {:error, "Empty response body (#{status})."}

      {:error, err} ->
        {:error, err}
    end
  end
end
