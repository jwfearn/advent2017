defmodule ReverseCaptcha do
  defstruct [
    hits: {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    previous_digit: nil
  ]

  def sum(n) when is_integer(n), do: n |> Integer.digits(10) |> sum
  def sum([_]), do: 0
  def sum([h | _] = digits) do
    digits
    |> Enum.reverse
    |> Enum.reduce(%ReverseCaptcha{previous_digit: h}, &hit(&1, &2))
    |> sum
  end
  def sum(%ReverseCaptcha{hits: hits}) do
    hits
    |> Tuple.to_list
    |> Enum.reduce(0, &(&1 + &2))
  end

  defp hit(digit, %ReverseCaptcha{previous_digit: digit, hits: hits} = rc) do
    %ReverseCaptcha{rc | hits: put_elem(hits, digit, digit)}
  end
  defp hit(digit, %ReverseCaptcha{} = rc) do
    %ReverseCaptcha{rc | previous_digit: digit}
  end
end

# to run tests locally: `elixir 01_inverse_captcha.exs`

ExUnit.start()

defmodule PhoneTest do
  use ExUnit.Case

  test "case 1" do
    assert 3 == ReverseCaptcha.sum(1122)
  end

  test "case 2" do
    assert 4 == ReverseCaptcha.sum(1111)
  end

  @tag :skip
  test "case 3" do
    assert 0 == ReverseCaptcha.sum(1234)
  end

  @tag :skip
  test "case 4" do
    assert 9 == ReverseCaptcha.sum(91212129)
  end
end
