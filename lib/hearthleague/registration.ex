defmodule Hearthleague.Registration do
	import Ecto.Changeset, only: [put_change: 3]

  def add_hashed_password(changeset) do
    changeset
			|> put_change(:encrypted_password, hash_password(changeset.params["password"]))
  end

	defp hash_password(password) do
		Comeonin.Bcrypt.hashpwsalt(password)
	end
end
