require "pluckit/pluck"
require "rekey/version"


module Rekey
  extend self

  def rekey(enumerable, key_handle = nil, value_handle = nil, &block)
    validate_input!(key_handle, value_handle, &block)

    key_value_fn = if enumerable.respond_to?(:keys)
      proc {|k, v| [k, v]}
    else
      proc {|v| [nil, v]}
    end

    # rekey input
    enumerable.each_with_object({}) do |*args, res|
      key, value = key_value_fn.call(*args)
      new_key = key
      new_value = value

      if block
        if block.arity < 2
          # block only wants value
          # arity -1 is a function pointer, eg. &:to_i
          new_key = block.call(value)
        else
          # block wants both key and value

          if key_value_fn.arity != 2
            raise ArgumentError.new(
              "rekey block requests key/value pair but only value available"
            )
          end

          new_key = block.call(key, value)
        end
      else
        new_key = PluckIt.pluckit(value, key_handle)
        new_value = PluckIt.pluckit(value, value_handle) if value_handle
      end

      # collect results
      res[new_key] = new_value
    end
  end


  private

  def validate_input!(key_handle, value_handle, &block)
    if block
      if (key_handle || value_handle)
        raise ArgumentError, "expected key / value handles, *or* block"
      end
    elsif key_handle.nil?
      raise ArgumentError, "key handle or block required"
    end
  end
end
