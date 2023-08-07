defmodule LvBugs0195Web.Live.Home.ItemListComponent do
  use LvBugs0195Web, :live_component
  alias LvBugs0195.Items
  alias LvBugs0195.Items.Item

  @impl true
  def mount( socket) do
    socket =
      socket
      |> stream_configure( :items, dom_id: &dom_id/1)
      |> assign_ensuring( :stream)

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
  def handle_event( event, _params, socket) do
    socket =
      case event do
        "prepend_random_item" ->
          stream_insert( socket, :items, new_random_item(), at: 0)

        "append_random_item" ->
          stream_insert( socket, :items, new_random_item())

        "reset_items" ->
          stream( socket, :items, Items.load_initial_batch(), reset: true)
      end

    { :noreply, socket}
  end

  defp ensure_assigns_available( socket)

  defp ensure_assigns_available( %{ assigns: %{ ensuring: :stream}} = socket) do
    socket
    |> stream( :items, Items.load_initial_batch())
    |> assign_ensuring( nil)
  end

  defp ensure_assigns_available( socket) do
    socket
  end

  defp new_random_item() do
    qty = Enum.random( 1 .. 50)

    item = Item.new(
      id: Items.new_item_id(),
      name: Items.random_item_name(),
      qty: qty
    )

    if rem( qty, 2) == 0 do
      item
    else
      %{ client_update: :whatever, item: item, id: item.id}
    end
  end

  defp dom_id( item) do
    "Item-#{ item.id}"
  end

  # Assigns

  defp assign_ensuring( socket, ensuring) do
    assign( socket, :ensuring, ensuring)
  end
end
