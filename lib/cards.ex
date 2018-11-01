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

end
