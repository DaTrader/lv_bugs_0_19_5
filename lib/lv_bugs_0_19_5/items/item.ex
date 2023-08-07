defmodule LvBugs0195.Items.Item do
  @enforce_keys [ :id, :name, :qty]
  defstruct @enforce_keys

  def new( args) do
    struct!( __MODULE__, args)
  end
end
