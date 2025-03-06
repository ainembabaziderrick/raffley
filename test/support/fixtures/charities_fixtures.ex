defmodule Raffley.CharitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Raffley.Charities` context.
  """

  @doc """
  Generate a unique charity name.
  """
  def unique_charity_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique charity slung.
  """
  def unique_charity_slung, do: "some slung#{System.unique_integer([:positive])}"

  @doc """
  Generate a charity.
  """
  def charity_fixture(attrs \\ %{}) do
    {:ok, charity} =
      attrs
      |> Enum.into(%{
        name: unique_charity_name(),
        slung: unique_charity_slung()
      })
      |> Raffley.Charities.create_charity()

    charity
  end
end
