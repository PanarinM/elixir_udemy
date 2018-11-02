defmodule Cards do
  @moduledoc """
    Module providing function to work with the deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suites = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # BAD way!
    # cards = for value <- values do
    #   for suit <- suites do
    #     "#{value} of #{suit}"
    #   end
    # end
    # List.flatten cards

    # GOOD way!
    for suit <- suites, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a cards

  ## Example

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Two of Clubs")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck to a `hand_size` and a remainder.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, amount) do
    Enum.split(deck, amount)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _} -> "plz, no yolo overhere"
    end
  end

  def create_hand(hand_size) do
    {hand, _} = Cards.create_deck |> Cards.shuffle |> Cards.deal(hand_size)
    hand
  end
end
