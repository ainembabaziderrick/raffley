defmodule RaffleyWeb.Api.RaffleJSON do
  def render("index.json", %{raffles: raffles}) do
    %{
      raffles:
        for raffle <- raffles do
          %{
            id: raffle.id,
            prize: raffle.prize,
            description: raffle.description,
            status: raffle.status,
            ticket_price: raffle.ticket_price,
            charity_id: raffle.charity_id
          }
        end
    }
  end

  def render("show.json", %{raffle: raffle}) do
    %{
      raffle: data(raffle)
    }
  end

  def render("error.json", %{changeset: changeset}) do
    errors =
      Ecto.Changeset.traverse_errors(changeset, fn {msg, _opts} -> msg end)
    %{errors: errors}
  end

  defp data(raffle) do
    %{
      id: raffle.id,
      prize: raffle.prize,
      description: raffle.description,
      status: raffle.status,
      ticket_price: raffle.ticket_price,
      charity_id: raffle.charity_id
    }
  end


end
