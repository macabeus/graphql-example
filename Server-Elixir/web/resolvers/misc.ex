defmodule Myapp.ResolversMisc do
  def format_errors_messages(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
    |> Enum.map(fn {key, value} -> "#{key} - #{value}" end)
  end
end
