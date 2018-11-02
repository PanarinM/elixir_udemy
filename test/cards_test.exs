defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck creates 20 cards" do
    deck_len = length(Cards.create_deck)
    assert deck_len == 20
  end

  test "shuffle is working" do
    deck = Cards.create_deck
    assert length(deck) == length(Cards.shuffle(deck))
    refute deck == Cards.shuffle(deck)
  end
end
