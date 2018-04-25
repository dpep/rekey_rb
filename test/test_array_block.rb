require 'minitest/autorun'
require 'rekey'


class RekeyArrayBlockTest < Minitest::Test

  def setup
    @input = [*1..3]
  end

  def test_keys
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
  end

  def test_nil_key
    assert_equal(
      { nil => 3 },
      @input.rekey {|k, v| nil }
    )
  end

end
