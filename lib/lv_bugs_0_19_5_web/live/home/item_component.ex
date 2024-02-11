defmodule LvBugs0195Web.Live.Home.ItemComponent do
  use LvBugs0195Web, :live_component
  alias LvBugs0195.Items

  @impl true
  def mount( socket) do
    socket =
      socket
      |> stream_configure( :colors, dom_id: &dom_id( &1, myself( socket)))
      |> assign_ensuring( :init)
      |> assign_open_select_letter( false)
      |> assign_color_index( 0)
      |> assign_carousel_state( nil)

    { :ok, socket}
  end

  @impl true
  def update( %{ event: :carousel_loop}, socket) do
    socket =
      if socket.assigns.carousel_state do
        socket
        |> assign_carousel_state( :move)
        |> ensure_assigns_available()
      else
        socket
      end

    { :ok, socket}
  end

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

        "open_select_letter" ->
          assign_open_select_letter( socket, true)

        "close_select_letter" ->
          assign_open_select_letter( socket, false)

        "select_letter" ->
          assign_open_select_letter( socket, false)

        "start_carousel" ->
          socket
          |> assign_carousel_state( :move)
          |> ensure_assigns_available()

        "stop_carousel" ->
          assign_carousel_state( socket, nil)
      end

    { :noreply, socket}
  end

  defp pick_color( color_id, socket) do
    colors = socket.assigns.colors

    if color = Enum.find( colors, & &1.id == color_id) do
      socket
      # this is not a bug, to reorder you need to first delete and then insert
      |> stream_delete(:colors, color)
      |> stream_insert(:colors, color, at: 0)
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

  defp ensure_assigns_available( %{ assigns: %{ carousel_state: :move}} = socket) do
    %{
      id: id,
      colors: colors,
      color_index: color_index
    } = socket.assigns

    send_update_after( __MODULE__, %{ id: id, event: :carousel_loop}, 2000)

    socket
    # this is not a bug, to reorder you need to first delete and then insert
    |> stream_delete( :colors, Enum.at( colors, color_index))
    |> stream_insert( :colors, Enum.at( colors, color_index), at: 0)
    |> assign_color_index( rem( color_index + 1, length( colors)))
    |> assign_carousel_state( :wait)
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

  defp assign_open_select_letter( socket, open_select_letter?) do
    assign( socket, :open_select_letter?, open_select_letter?)
  end

  defp assign_color_index( socket, color_index) do
    assign( socket, :color_index, color_index)
  end

  defp assign_carousel_state( socket, carousel_state) do
    assign( socket, :carousel_state, carousel_state)
  end

  embed_templates "item_component/*"
end
