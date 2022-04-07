require_relative 'test_helper'


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
        1 => 1,
        2 => 2,
        3 => 3,
      },
      @input.rekey(&:itself)
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

    assert_equal(
      { 123 => 3 },
      @input.rekey { 123 }
    )
  end

end
