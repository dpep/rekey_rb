require 'awesome_print'
require 'byebug'

module Rekey
  class << self

    def rekey(enumerable, key_handle = nil, value_handle = nil, &block)
      # validate input
      if block
        if (key_handle or value_handle)
          raise ArgumentError.new 'expected key / value handles, *or* block'
        end
      else
        unless key_handle or value_handle
          raise ArgumentError.new 'expected key_handle or value_handle'
        end
      end

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

      res = nil
      # determine return type.  generally a Hash, except when input
      # is an Array and key_handle is null
      if block
        res = {}
      else
        res = (key_handle or enumerable.respond_to?(:keys)) ? {} : []
      end

      enumerable.each do |*args|
        key = key_fn.call *args
        value = value_fn.call *args
        new_key = key
        new_value = value

        if block
          if block.arity <= 0
            # function pointer
            new_key = block.call value
          elsif block.arity == 1
            # standard block
            new_key = block.call value
          else
            new_key, new_value = block.call key, value
          end
        else
          new_key = pull value, key_handle if key_handle
          new_value = pull value, value_handle if value_handle
        end

        # collect results
        if res.is_a? Array
          res.push new_value
        else
          res[new_key] = new_value
        end
      end

      res
    end


    private

    def pull v, handle
          # byebug
      if v.respond_to? handle
        if v.method(handle).arity <= 0
          v.send handle
        else
          v.send handle, v
        end
      else

      end
    end

  end
end


module Enumerable
  def rekey(key_handle = nil, value_handle = nil, &block)
    Rekey.rekey self, key_handle, value_handle, &block
  end
end
