# lib/nba/utils.ex
defmodule NBA.Utils do
  @moduledoc """
  Utility functions for NBA API modules.
  """

  @doc """
  Normalizes a player or team ID to an integer.
  """
  def integer_id(val) when is_integer(val), do: val
  def integer_id(val) when is_binary(val), do: String.to_integer(val)

  @doc """
  Normalizes a player or team ID to a string.
  """
  def string_id(val) when is_binary(val), do: val
  def string_id(val) when is_integer(val), do: Integer.to_string(val)

  @doc """
  Validates whether a player or team ID is either an integer or a numeric string.
  """
  def valid_id?(val) when is_integer(val), do: true
  def valid_id?(val) when is_binary(val), do: String.match?(val, ~r/^\d+$/)
  def valid_id?(_), do: false

  @doc """
  Validates input parameters and options against accepted types and required keys.
  Accepts keyword lists of parameters and options, a map of accepted types, and optionally a list of required param keys.
  Returns :ok if valid, or an error tuple if invalid.
  """
  @spec validate_input(keyword(), keyword(), map(), list()) ::
          :ok
          | {:error,
             {:missing_keys, list()}
             | {:invalid_keys, list()}
             | {:invalid_type, atom(), list(), any()}}
  def validate_input(params, opts, accepted_types, required_keys \\ [])

  def validate_input(params, opts, accepted_types, required_keys)
      when is_list(params) and is_list(opts) do
    # 1. Ensure all required keys are present
    missing = Enum.filter(required_keys, fn key -> Keyword.get(params, key) == nil end)

    if missing != [] do
      {:error, {:missing_keys, missing}}
    else
      # 2. Continue to type validation
      allowed_keys = Map.keys(accepted_types)
      invalid_keys = Keyword.keys(params) -- allowed_keys

      if invalid_keys != [] do
        {:error, {:invalid_keys, invalid_keys}}
      else
        Enum.reduce_while(accepted_types, :ok, fn {key, types}, acc ->
          case Keyword.get(params, key) do
            nil ->
              {:cont, acc}

            value ->
              cond do
                # Special case: accept numeric strings when integer is allowed
                types == [:integer, :string] and not valid_id?(value) ->
                  {:halt, {:error, {:invalid_type, key, types, value}}}

                Enum.any?(types, &type_check?(&1, value)) ->
                  {:cont, acc}

                true ->
                  {:halt, {:error, {:invalid_type, key, types, value}}}
              end
          end
        end)
      end
    end
  end

  def validate_input(_params, _opts, _types, _req), do: {:error, :invalid_input_format}

  @doc """
  Handles validation errors by returning a standardized error tuple.
  This function takes an error tuple from `validate_input/3` and returns a more user-friendly error message.
  """
  @spec handle_validation_error(any()) :: {:error, String.t()} | {:error, any()}
  def handle_validation_error({:error, {:missing_keys, keys}}) do
    {:error, "Missing required parameter(s): #{Enum.map_join(keys, ", ", &inspect/1)}"}
  end

  def handle_validation_error({:error, {:invalid_keys, keys}}) do
    {:error, "Invalid parameter(s): #{Enum.map_join(keys, ", ", &inspect/1)}"}
  end

  def handle_validation_error({:error, {:invalid_type, key, expected_types, value}}) do
    {:error,
     "Invalid type for #{key}: got #{inspect(value)}, accepts #{Enum.join(Enum.map(expected_types, &Atom.to_string/1), ", ")}"}
  end

  def handle_validation_error({:error, :invalid_input_format}) do
    {:error, "Parameters and Options must be keyword lists or nil"}
  end

  def handle_validation_error({:error, _} = err), do: err
  def handle_validation_error(other), do: {:error, {:unexpected, other}}

  @doc """
  Handles common API response errors.
  """
  def handle_api_error({:error, %Jason.DecodeError{}}), do: {:error, :decode_error}
  def handle_api_error({:error, _} = err), do: err
  def handle_api_error(other), do: {:error, {:unexpected, other}}

  defp type_check?(:string, val), do: is_binary(val)
  defp type_check?(:integer, val), do: is_integer(val)
  defp type_check?(:boolean, val), do: is_boolean(val)
  defp type_check?(:float, val), do: is_float(val)
  defp type_check?(_, _), do: false

  defmacro def_get_bang(base_module) do
    quote do
      def get!(params \\ [], opts \\ []) do
        case unquote(base_module).get(params, opts) do
          {:ok, result} ->
            result

          {:error, reason} ->
            raise ArgumentError, "Failed to fetch #{unquote(base_module)}: #{inspect(reason)}"
        end
      end
    end
  end
end
