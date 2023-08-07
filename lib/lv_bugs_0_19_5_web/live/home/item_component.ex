defmodule LvBugs0195Web.Live.Home.ItemComponent do
  use LvBugs0195Web, :live_component
  alias LvBugs0195.Items

  @impl true
  def mount( socket) do
    socket =
      socket
      |> stream_configure( :colors, dom_id: &dom_id( &1, myself( socket)))
      |> assign_ensuring( :init)

    { :ok, socket}
  end

  @impl true
  def update( new_assigns, socket) do
    socket =
      socket
      |> assign( new_assigns)
      |> ensure_assigns_available()

    { :ok, socket}
  end

  @impl true
  def handle_event( event, params, socket) do
    socket =
      case event do
        "pick_color" ->
          pick_color( Map.fetch!( params, "color"), socket)

        "reset_colors" ->
          colors = socket.assigns.colors
          stream( socket, :colors, colors, reset: true)
      end

    { :noreply, socket}
  end

  defp pick_color( color_id, socket) do
    colors = socket.assigns.colors

    if color = Enum.find( colors, & &1.id == color_id) do
      stream_insert( socket, :colors, color, at: 0)
    else
      socket
    end
  end

  defp ensure_assigns_available( socket)

  defp ensure_assigns_available( %{ assigns: %{ ensuring: :init}} = socket) do
    colors = Items.load_available_colors()

    socket
    |> stream( :colors, colors)
    |> assign_colors( colors)
    |> assign_ensuring( nil)
  end

  defp ensure_assigns_available( socket) do
    socket
  end

  defp dom_id( color, myself) do
    "Color-#{ color.id}-#{ myself}"
  end

  defp myself( socket) do
    socket.assigns.myself
  end

  # assigns

  defp assign_colors( socket, colors) do
    assign( socket, :colors, colors)
  end

  defp assign_ensuring( socket, ensuring) do
    assign( socket, :ensuring, ensuring)
  end
end
