defmodule Raffley.Charities.Charity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "charities" do
    field :name, :string
    field :slung, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(charity, attrs) do
    charity
    |> cast(attrs, [:name, :slung])
    |> validate_required([:name, :slung])
    |> unique_constraint(:slung)
    |> unique_constraint(:name)
  end
end
