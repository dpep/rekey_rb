require 'pluckit/pluck'


module Rekey
  VERSION = '2.0.1'

  class << self

    def rekey(enumerable, key_handle = nil, value_handle = nil, &block)
      # validate input
      validate_input key_handle, value_handle, &block

      key_fn = if enumerable.respond_to?(:keys)
        proc {|k, v| k}
      else
        proc {|v| nil}
      end

      value_fn = if enumerable.respond_to?(:values)
        proc {|k, v| v}
      else
        proc {|v| v}
      end

      # determine return type
      res = if key_handle or block or enumerable.respond_to?(:keys)
        {}
      else
        []
      end

      # rekey input
      enumerable.each do |*args|
        key = key_fn.call *args
        value = value_fn.call *args
        new_key = key
        new_value = value

        if block
          if block.arity <= 0
            # function pointer, eg. &:to_i
            new_key = block.call value
          elsif block.arity == 1
            # standard block
            new_key = block.call value
          else
            # block that wants both key and value
            new_key = block.call key, value
          end
        else
          new_key = PluckIt.pluck value, key_handle if key_handle
          new_value = PluckIt.pluck value, value_handle if value_handle
        end

        # collect results
        if res.is_a? Array
          unless new_key.nil?
            # safeguard against stupidity
            raise ArgumentError.new(
              "not expecting a key value, got: #{new_key}"
            )
          end

          res.push new_value
        else
          res[new_key] = new_value
        end
      end

      res
    end


    private

    def validate_input key_handle, value_handle, &block
      if block
        if (key_handle or value_handle)
          raise ArgumentError.new 'expected key / value handles, *or* block'
        end
      else
        unless key_handle or value_handle
          raise ArgumentError.new 'key_handle and/or value_handle are required'
        end
      end
    end


  end
end


module Enumerable
  def rekey(key_handle = nil, value_handle = nil, &block)
    Rekey.rekey self, key_handle, value_handle, &block
  end
end
