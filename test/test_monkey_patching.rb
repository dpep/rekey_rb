require 'minitest/autorun'
require 'set'
require_relative '../lib/rekey/rekey'


class MonkeyPatchingTest < Minitest::Test
  def test_lib_installed
    # `require 'rekey/rekey'` should load Rekey module
    assert Rekey
  end

  def test_no_monkey_patch
    assert_raises NoMethodError do
      [ 1, 2, 3 ].rekey 0
    end

    assert_raises NoMethodError do
      { a: 1 }.rekey 0
    end

    assert_raises NoMethodError do
      Set.new([ 1, 2, 3 ]).rekey 0
    end
  end

  def test_pluckit
    assert PluckIt

    assert_raises NoMethodError do
      [ 1, 2, 3 ].pluck 0
    end
  end
end
