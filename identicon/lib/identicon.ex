defmodule Identicon do
  @moduledoc """
    A module for creating identicon images
  """

  @doc """
    Modules entrypoint, asks for an input and then generates an image
    with name *imput*.png
  """
  def main do
    input = String.trim(IO.gets("String to use: "))
    input
    |> hash_input
    |> get_color
    |> build_grid
    |> filter_grid
    |> build_pixel_map
    |> generate_image
    |> save_image(input)
  end

  def save_image(image_binary, filename) do
    File.write("#{filename}.png", image_binary)
  end

  def generate_image(%Identicon.Image{pixel_map: pixel_map, color: color}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  @doc """
  Creates a pixel map for a grid of a struct. Made for a 250x250 (50x50) image

  ## Example

  iex> Identicon.build_pixel_map(%Identicon.Image{grid: [{2, 1}, {2, 3}]})
  %Identicon.Image{
    color: nil,
    grid: [{2, 1}, {2, 3}],
    hex: nil,
    pixel_map: [{{50, 0}, {100, 50}}, {{150, 0}, {200, 50}}]
  }
 """
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50
      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}
      {top_left, bottom_right}
    end
    %Identicon.Image{image | pixel_map: pixel_map}
  end

  @doc """
  Filters the grid value of a struct, so only rows with even values are left

  ## Example

      iex> Identicon.filter_grid(%Identicon.Image{grid: [{1, 0}, {2, 1}, {3, 2}, {2, 3}]})
      %Identicon.Image{
        color: nil,
        grid: [{2, 1}, {2, 3}],
        hex: nil,
        pixel_map: nil
      }
  """
  def filter_grid(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end
    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Hashes the input, hash will further be used for image generation.
  returns an Identicon.Image struct with hex value filled

  ## Example

      iex> Identicon.hash_input("asdf")
      %Identicon.Image{
         color: nil,
         grid: nil,
         hex: [145, 46, 200, 3, 178, 206, 73, 228, 165, 65, 6, 141, 73, 90, 181, 112],
         pixel_map: nil
      }
  """
  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  @doc """
  Method for obtaining the color from the hex of a struct.
  Returns a new struct with a color key filled.

  ## Example

      iex> Identicon.get_color(%Identicon.Image{hex: [1, 2, 3, 4, 5, 6]})
      %Identicon.Image{
         color: {1, 2, 3},
         grid: nil,
         hex: [1, 2, 3, 4, 5, 6],
         pixel_map: nil
      }
  """
  def get_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
  Creates a grid for the identicon to be rendered from
  Returns a struct with filled grid parameter

  ## Example

      iex> Identicon.build_grid(%Identicon.Image{hex: [1, 2, 3, 4, 5, 6]})
      %Identicon.Image{
         color: nil,
         grid: [{1, 0}, {2, 1}, {3, 2}, {2, 3}, {1, 4}, {4, 5}, {5, 6}, {6, 7}, {5, 8}, {4, 9}],
         hex: [1, 2, 3, 4, 5, 6],
         pixel_map: nil
      }
  """
  def build_grid(%Identicon.Image{hex: hex_list} = image) do
    grid =
      hex_list
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index
    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Mirrors the row of 3 elements

  ## Example

      iex> Identicon.mirror_row([1, 2, 3])
      [1, 2, 3, 2, 1]
  """
  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end
end
