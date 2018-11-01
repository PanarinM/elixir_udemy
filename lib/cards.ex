defmodule Cards do
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

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

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
end
