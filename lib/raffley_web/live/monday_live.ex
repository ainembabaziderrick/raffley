defmodule RaffleyWeb.MondayLive do
  use RaffleyWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :greeting, "Hello")
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="monday">
      <h1>Monday Live</h1>
      <p><%= @greeting %></p>
    </div>
    """
  end
end
