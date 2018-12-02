defmodule Discuss.TopicModel do
  use Discuss.Web, :model

  schema "topics" do
    field(:title, :string)
    field(:body, :string)
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body])
    |> validate_required([:title, :body])
  end
end
