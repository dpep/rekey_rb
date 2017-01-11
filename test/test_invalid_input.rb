require 'minitest/autorun'
require 'rekey'


class RekeyInvalidInputTest < Minitest::Test
  def setup
    @input = [*1..3]
  end


  def test_all
    assert_raises ArgumentError do
      @input.rekey
    end

    assert_raises ArgumentError do
      @input.rekey(:k) do |k| 1 end
    end

    assert_raises ArgumentError do
      @input.rekey(:k, :v) do |k| 1 end
    end
  end

end
