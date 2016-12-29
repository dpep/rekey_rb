require 'minitest/autorun'
require 'rekey'


class RekeyRangeTest < Minitest::Test

  def setup
    @input = [
      [ 1, 2, 3 ],
      [ 4, 5, 6 ],
    ]
  end

  def test_stuff
    assert_equal([
        [ 1, 2 ],
        [ 4, 5 ],
      ],
      @input.rekey(nil, '0..1')
    )

    assert_equal([
        [ 2 ],
        [ 5 ],
      ],
      @input.rekey(nil, '1...2')
    )

    assert_equal({
        [ 2 ] => @input[0],
        [ 5 ] => @input[1],
      },
      @input.rekey('1...2')
    )

    assert_equal({
        3 => [ 1, 2 ],
        6 => [ 4, 5 ],
      },
      @input.rekey(2, '0..1')
    )
  end

end
