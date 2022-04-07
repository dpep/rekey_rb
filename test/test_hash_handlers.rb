require_relative 'test_helper'


class RekeyHashHandlersTest < Minitest::Test

  def setup
    @input = {
      a: 1,
      b: 2,
      c: 3,
    }
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


  def test_hash_array
    data = {
      a: [ 1, 2, 3 ],
      b: [ 4, 5, 6 ],
      c: [ 7, 8, 9 ],
    }

    assert_equal({
        1 => 2,
        4 => 5,
        7 => 8,
      },
      data.rekey(0, 1)
    )

    assert_equal({
        1 => 3,
        4 => 6,
        7 => 9,
      },
      data.rekey(:min, :max)
    )
  end


  def test_hash_hash
    data = {
      a: { i: 1, v: 2 },
      b: { i: 2, v: 4 },
      c: { i: 3, v: 6 },
    }

    assert_equal({
        1 => { i: 1, v: 2 },
        2 => { i: 2, v: 4 },
        3 => { i: 3, v: 6 },
      },
      data.rekey(:i)
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
