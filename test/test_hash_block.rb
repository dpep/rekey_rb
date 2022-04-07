require_relative 'test_helper'


class RekeyHashBlockTest < Minitest::Test
  def setup
    @input = {
      a: 1,
      b: 2,
      c: 3,
    }
  end

  def test_arity1_keys
    assert_equal({
        1 => 1,
        2 => 2,
        3 => 3,
      },
      @input.rekey {|v| v }
    )

    assert_equal({
        '1' => 1,
        '2' => 2,
        '3' => 3,
      },
      @input.rekey {|v| v.to_s }
    )

    # it can use Arrays as Hash keys...if you really want to
    assert_equal({
        [1] => 1,
        [2] => 2,
        [3] => 3,
      },
      @input.rekey {|v| [v] }
    )
  end

  def test_arity2_keys
    assert_equal({
        1 => 1,
        2 => 2,
        3 => 3,
      },
      @input.rekey {|k, v| v }
    )

    assert_equal({
        a: 1,
        b: 2,
        c: 3,
      },
      @input.rekey {|k, v| k }
    )

    assert_equal({
        'aa' => 1,
        'bb' => 2,
        'cc' => 3,
      },
      @input.rekey {|k, v| k.to_s * 2 }
    )
  end

  def test_nil_key
    assert_equal(
      { nil => 3 },
      @input.rekey {|k, v| nil }
    )
  end

end
