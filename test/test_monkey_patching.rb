require 'minitest/autorun'
require 'set'

$LOAD_PATH.unshift 'lib'
require 'rekey/rekey'


class MonkeyPatchingTest < Minitest::Test
  def test_not_installed
    if defined? Rekey::VERSION
      # entire library was loaded, so these tests are invalid.
      # this happens when run through `rake`
      skip
    end

    # `require 'pluckit/pluck'` should load PluckIt
    # but not monkey patch
    assert_raises NoMethodError do
      [ 1, 2, 3 ].rekey 0
    end

    assert_raises NoMethodError do
      { a: 1 }.rekey 0
    end

    assert_raises NoMethodError do
      Set.new([ 1, 2, 3 ]).rekey 0
    end

    puts 'no monkey patching'
  end


end
