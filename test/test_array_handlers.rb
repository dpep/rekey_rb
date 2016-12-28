require 'minitest/autorun'
require 'rekey'


class RekeyArrayHandlersTest < Minitest::Test

  def setup
    @input = [*1..3]
  end

  def test_both
    assert_equal({
        1 => 1,
        2 => 2,
        3 => 3,
      },
      @input.rekey(:to_i, :to_i)
    )

    assert_equal({
        '1' => 1.0,
        '2' => 2.0,
        '3' => 3.0,
      },
      @input.rekey(:to_s, :to_f)
    )

    assert_equal({
        '1' => 1.0,
        '2' => 2.0,
        '3' => 3.0,
      },
      @input.rekey('to_s', 'to_f')
    )
  end

  def test_keys
    assert_equal({
        '1' => 1,
        '2' => 2,
        '3' => 3,
      },
      @input.rekey(:to_s)
    )

    assert_equal({
        '1' => 1,
        '2' => 2,
        '3' => 3,
      },
      @input.rekey('to_s')
    )

    assert_equal({
        1.0 => 1,
        2.0 => 2,
        3.0 => 3,
      },
      @input.rekey(:to_f)
    )

    assert_equal({
        1.0 => 1,
        2.0 => 2,
        3.0 => 3,
      },
      @input.rekey(&:to_f)
    )
  end

  def test_values
    assert_equal(
      @input,
      @input.rekey(nil, :to_i)
    )

    assert_equal(
      @input.map(&:to_f),
      @input.rekey(nil, :to_f)
    )

    assert_equal(
      @input.map(&:to_s),
      @input.rekey(nil, 'to_s')
    )
  end

end
