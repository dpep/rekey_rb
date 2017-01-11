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

    assert_raises TypeError do
      {}.rekey do |k| 1 end
    end
  end

end
