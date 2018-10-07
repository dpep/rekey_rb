require 'minitest/autorun'
require_relative '../lib/rekey'


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

  def test_hash_array
    data = {
      a: [ 1, 2, 3 ],
      b: [ 4, 5, 6 ],
      c: [ 7, 8, 9 ],
    }

    assert_equal({
        a: 1,
        b: 4,
        c: 7,
      },
      data.rekey(nil, 0)
    )

    assert_equal({
        1 => 2,
        4 => 5,
        7 => 8,
      },
      data.rekey(0, 1)
    )
  end

  def test_hash_hash
    data = {
      a: { i: 1, v: 2 },
      b: { i: 2, v: 4 },
      c: { i: 3, v: 6 },
    }

    assert_equal({
        a: 1,
        b: 2,
        c: 3,
      },
      data.rekey(nil, :i)
    )

    assert_equal({
        1 => 2,
        2 => 4,
        3 => 6,
      },
      data.rekey(:i, :v)
    )

  end

end
