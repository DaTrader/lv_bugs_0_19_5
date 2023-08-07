defmodule LvBugs0195.Items.Color do
  @enforce_keys [ :id, :name, :rgb]
  defstruct @enforce_keys

  def new( args) do
    struct!( __MODULE__, args)
  end
end
