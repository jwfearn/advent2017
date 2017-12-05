require Integer

defmodule D03P1 do
  def distance(1), do: 0
  def distance(n) when is_integer(n) and n > 1 do
    root = :math.sqrt(n)
    pitch = ceil_odd(root) - 1 # linear distance between centers
    v = div(pitch, 2) # vertical distance
    phase = (pitch - 1) * (pitch - 1) + v # n of first center
    d = rem(n - phase, pitch)
    h = if d < v do d else pitch - d end # horizontal distance
    v + h
  end

  def ceil_odd(n) when is_float(n), do: n |> Float.ceil |> trunc |> ceil_odd
  def ceil_odd(n) when is_integer(n) and Integer.is_even(n), do: n + 1
  def ceil_odd(n), do: n
end

ExUnit.start()

defmodule D03P1Test do
  use ExUnit.Case

  test "case 1", do: assert D03P1.distance(1) == 0

  test "case 2", do: assert D03P1.distance(12) == 3
  test "case 3", do: assert D03P1.distance(23) == 2
  test "case 4", do: assert D03P1.distance(45) == 4
  test "case 5", do: assert D03P1.distance(46) == 3
  test "case 6", do: assert D03P1.distance(47) == 4
  test "case 7", do: assert D03P1.distance(48) == 5
  test "case 8", do: assert D03P1.distance(49) == 6
  test "case 9", do: assert D03P1.distance(1024) == 31

  test "puzzle" do
    input = 361_527
    actual = D03P1.distance(input)
    IO.puts("\nDay 3, part 1\ninput: #{input}\noutput: #{actual}")
    assert actual == 326
  end
end
