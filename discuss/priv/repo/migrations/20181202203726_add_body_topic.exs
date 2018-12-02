defmodule Discuss.Repo.Migrations.AddBodyTopic do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :body, :string
    end
  end
end
