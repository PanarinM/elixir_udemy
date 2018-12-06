defmodule Discuss.UserModel do
  use Discuss.Web, :model

  schema "users" do
    field :nickname, :string
    field :email, :string
    field :provider, :string
    field :token, :string

    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token, :nickname])
  end
end
