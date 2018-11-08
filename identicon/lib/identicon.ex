defmodule Identicon do
  def main do
    String.trim(IO.gets "String to use: ")
    |> hash_input
    |> get_color
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{hex: hex}
  end

  def get_color(image) do
    # also viable
    # %Identicon.Image{hex: [red, green, blue | _tail]} = image
    # [red, green, blue]
    [r, g, b] = Enum.slice(image.hex, 0, 3)
  end
end
