require_relative 'test_helper'


class RekeyRegexpTest < Minitest::Test

  def setup
    @input = [
      [ 'a', 'aa', 'b', 'ba', 'dd' ],
      [ 'b', 'c', 'bc', 'de' ],
    ]
  end

  def test_stuff
    assert_equal({
        'a' => ['a', 'aa', 'ba'],
        'b' => [],
      },
      @input.rekey(0, /a/)
    )

    assert_equal({
        ['dd'] => ['b', 'ba'],
        ['de'] => ['b', 'bc'],
      },
      @input.rekey(/d/, /b/)
    )
  end

end
