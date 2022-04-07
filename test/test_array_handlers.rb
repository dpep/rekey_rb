require_relative 'test_helper'


class RekeyArrayHandlersTest < Minitest::Test

  def setup
    @input = [*1..3]
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


  def test_array_indices
    array_data = [
      [ 1, 2, 3 ],
      [ 4, 5, 6 ],
      [ 7, 8, 9 ],
    ]

    assert_equal({
        1 => 3,
        4 => 6,
        7 => 9,
      },
      array_data.rekey(0, 2)
    )

    array_data = [
      [ 1 ],
      [ 2, 1 ],
      [ 3, 2, 1 ],
    ]
    assert_equal({
        1 => 1,
        2 => 2,
        3 => 3,
      },
      array_data.rekey(0, :count)
    )
  end


  def test_hash_indices
    data = [
      { i: 1, v: 'a' },
      { i: 2, v: 'b' },
      { i: 3, v: 'c' },
    ]

    assert_equal({
        1 => data[0],
        2 => data[1],
        3 => data[2],
      },
      data.rekey(:i)
    )

    assert_equal({
        1 => 'a',
        2 => 'b',
        3 => 'c',
      },
      data.rekey(:i, :v)
    )
  end


end
