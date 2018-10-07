require 'minitest/autorun'
require_relative '../lib/rekey'


class RekeyRangeTest < Minitest::Test

  def setup
    @input = [
      [ 1, 2, 3 ],
      [ 4, 5, 6 ],
    ]
  end

  def test_stuff
    assert_equal({
        [ 1, 2 ] => [ 1, 2, 3 ],
        [ 4, 5 ] => [ 4, 5, 6 ],
      },
      @input.rekey(0..1)
    )

    assert_equal({
        3 => [ 1, 2 ],
        6 => [ 4, 5 ],
      },
      @input.rekey(2, 0..1)
    )
  end

end
