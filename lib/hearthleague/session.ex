defmodule Hearthleague.Session do
  def login(nerd, password) do
    case authenticate(nerd, password) do
      true -> {:ok, nerd}
      _ -> :error
    end
  end

  defp authenticate(nerd, password) do
    IO.inspect(nerd)
    case nerd do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, nerd.encrypted_password)
    end
  end
end
