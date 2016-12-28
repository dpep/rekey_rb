require 'minitest/autorun'
require 'rekey'


class RekeyHashHandlersTest < Minitest::Test
  def setup
    @input = {
      a: 1,
      b: 2,
      c: 3,
    }
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
      @input.rekey(:to_s, :to_i)
    )

    assert_equal({
        '1' => 1.0,
        '2' => 2.0,
        '3' => 3.0,
      },
      @input.rekey('to_s', 'to_i')
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
        1.0 => 1,
        2.0 => 2,
        3.0 => 3,
      },
      @input.rekey(:to_f)
    )
  end

  def test_values
    assert_equal(
      @input,
      @input.rekey(nil, :to_i)
    )

    assert_equal({
        a: '1',
        b: '2',
        c: '3',
      },
      @input.rekey(nil, :to_s)
    )

    assert_equal({
        a: '1',
        b: '2',
        c: '3',
      },
      @input.rekey(nil, 'to_s')
    )
  end

end
