require 'minitest/autorun'
require_relative '../lib/rekey'


class RekeyInvalidInputTest < Minitest::Test
  def setup
    @input = [*1..3]
  end


  def test_nil
    assert_raises ArgumentError do
      @input.rekey
    end

    assert_raises ArgumentError do
      @input.rekey nil
    end

    assert_raises ArgumentError do
      @input.rekey nil, :v
    end

    # unfortunately, these still pass
    @input.rekey(nil) {|v| v}
    @input.rekey(nil, nil) {|v| v}
  end


  def test_handles_and_block
    assert_raises ArgumentError do
      @input.rekey(:k) {|k| 1}
    end

    assert_raises ArgumentError do
      @input.rekey(:k, :v) {|k| 1}
    end
  end


  def test_block_underflow
    # block requesting key and value, but @input
    # doesn't have keys
    assert_raises ArgumentError do
      @input.rekey {|k, v| 1}
    end
  end


end
