defmodule DemoWeb.FormLive do
  use Phoenix.LiveView
  require Plug.Conn


  def render(assigns), do: DemoWeb.FormView.render("index.html", assigns)

  def mount(_session, socket) do
    state = %{
      fruit: "",
      is_modal_open: false,
    }
    {:ok, assign(socket, state)}
  end

  # def handle_info(:tick, socket) do
  #   {:noreply, assign(socket, time: :calendar.local_time())}
  # end

  def handle_event("form_change", %{"fruit" => fruit}, socket) do
    IO.puts "validating on change (phx_change)"
    IO.inspect fruit
    {:noreply, assign(socket, fruit: fruit)}
  end

  def handle_event("toggle_modal", _val, socket) do
    IO.puts "Modal Clicked"
    IO.inspect socket.assigns.is_modal_open
    is_open_value = if socket.assigns.is_modal_open, do: false, else: true
    {:noreply, assign(socket, is_modal_open: is_open_value)}
  end

  def handle_event("save", val, socket) do
    IO.puts "saving form (phx_submit)"
    IO.inspect val
    {:noreply, update(socket, val, val)}
  end
end
