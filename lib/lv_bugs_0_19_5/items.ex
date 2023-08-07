defmodule LvBugs0195.Items do
  alias LvBugs0195.Items.Item

  @appliances [
    "Refrigerator",
    "Washing Machine",
    "Microwave Oven",
    "Dishwasher",
    "Air Conditioner",
    "Vacuum Cleaner",
    "Clothes Dryer",
    "Coffee Maker",
    "Blender/Food Processor",
    "Electric Kettle",
    "Toaster/Toaster Oven",
    "Rice Cooker",
    "Slow Cooker/Crockpot",
    "Iron",
    "Food Storage Container",
    "Bread Maker",
    "Electric Fan",
    "Hair Dryer",
    "Water Heater",
    "Electric Stove/Induction Cooktop"
  ]

  def load_initial_batch() do
    [
      Item.new( id: "153f13d1-38c1-406d-9508-124706f94560", name: Enum.at( @appliances, 0), qty: 2),
      Item.new( id: "dbe1b639-64fa-4f72-b886-46c383b24f7e", name: Enum.at( @appliances, 1), qty: 5),
      Item.new( id: "1a738253-dfe8-4f0d-a319-9803af4154b3", name: Enum.at( @appliances, 2), qty: 21),
      Item.new( id: "0f7a80de-9c7b-43dd-9aad-8c6f46daa95d", name: Enum.at( @appliances, 3), qty: 8),
      Item.new( id: "da83a3ba-9831-4777-975a-42d80b405b32", name: Enum.at( @appliances, 4), qty: 15)
    ]
  end

  def new_item_id() do
    Ecto.UUID.generate()
  end

  def random_item_name() do
    Enum.random( @appliances)
  end
end
