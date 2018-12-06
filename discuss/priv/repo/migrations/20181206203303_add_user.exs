defmodule Discuss.Repo.Migrations.AddUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string)
      add(:provider, :string)
      add(:token, :string)
      add(:nickname, :string)

      timestamps
    end
  end
end
