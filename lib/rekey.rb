require_relative 'rekey/rekey'

module Enumerable
  def rekey(key_handle = nil, value_handle = nil, &block)
    Rekey.rekey(self, key_handle, value_handle, &block)
  end
end
