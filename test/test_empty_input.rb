require 'minitest/autorun'
require 'rekey'


class RekeyEmptyInputTest < Minitest::Test

  def test_all
    assert_equal(
      {},
      [].rekey(:k, :v)
    )

    assert_equal(
      {},
      {}.rekey(:k, :v)
    )

    assert_equal(
      {},
      Set.new.rekey(:k, :v)
    )

    assert_equal(
      [],
      Set.new.rekey(nil, :k)
    )
  end

end
