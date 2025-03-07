defmodule Raffley.Raffles do
  alias Raffley.Charities.Charity
  alias Raffley.Raffles.Raffle
  alias Raffley.Repo
  import Ecto.Query

  def list_raffles do
    Repo.all(Raffle)
  end

  def filter_raffles(filter) do
    Raffle
    |> with_status(filter["status"])
    |> search_by(filter["q"])
    |> sort(filter["sort_by"])
    |> with_charity(filter["charity"])
    |> preload(:charity)
    |> Repo.all()
  end

  defp with_charity(query, slung) when slung in ["", nil], do: query

  defp with_charity(query, slung) do
    # from r in query,
    #   join: c in Charity,
    #   on: r.charity_id == c.id,
    #   where: c.slung == ^slung

    from r in query,
      join: c in assoc(r, :charity),
      where: c.slung == ^slung
  end

  defp with_status(query, status) when status in ~W(upcoming open closed) do
    where(query, status: ^status)
  end

  defp with_status(query, _), do: query

  defp search_by(query, q) do
    where(query, [r], ilike(r.prize, ^"%#{q}%"))
  end

  defp search_by(query, _), do: query



  defp sort(query, "prize") do
    order_by(query, :prize)
  end

  defp sort(query, "ticket_price_desc") do
    order_by(query, desc: :ticket_price)
  end

  defp sort(query, "ticket_price_asc") do
    order_by(query, asc: :ticket_price)
  end

  defp sort(query, "charity") do
    from r in query,
      join: c in assoc(r, :charity),
      order_by: c.name
  end

  defp sort(query, _) do
    order_by(query, :id)
  end



  def get_raffle!(id) do
    Repo.get!(Raffle, id)
    |> Repo.preload(:charity)
  end

  def featured_raffles(raffle) do
    Process.sleep(2000)

    Raffle
    |> where(status: :open)
    |> where([r], r.id != ^raffle.id)
    |> order_by(desc: :ticket_price)
    |> limit(3)
    |> Repo.all()
  end
end
