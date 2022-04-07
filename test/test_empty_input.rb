require 'set'

require_relative 'test_helper'


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
  end

end
