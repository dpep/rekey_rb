require 'minitest/autorun'
require_relative '../lib/rekey'


class RekeyRegexpTest < Minitest::Test

  def setup
    @input = [
      [ 'a', 'aa', 'b', 'ba' ],
      [ 'b', 'c', 'bc' ],
    ]
  end

  def test_stuff
    assert_equal([
        ['a', 'aa', 'ba'],
        [],
      ],
      @input.rekey(nil, /a/)
    )

    assert_equal([
        ['b', 'ba'],
        ['b', 'bc'],
      ],
      @input.rekey(nil, /b/)
    )
  end

end
