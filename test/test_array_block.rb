require 'minitest/autorun'
require_relative '../lib/rekey'


class RekeyArrayBlockTest < Minitest::Test

  def setup
    @input = [*1..3]
  end

  def test_all
    assert_equal({
        1 => 1,
        2 => 2,
        3 => 3,
      },
      @input.rekey {|v| v }
    )

    assert_equal({
        2 => 1,
        4 => 2,
        6 => 3,
      },
      @input.rekey {|v| v * 2 }
    )

    assert_equal({
        '1' => 1,
        '2' => 2,
        '3' => 3,
      },
      @input.rekey {|v| v.to_s }
    )

    assert_equal(
      { nil => 3 },
      @input.rekey {|v| nil }
    )
  end

end
