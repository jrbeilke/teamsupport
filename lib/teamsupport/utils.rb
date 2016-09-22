module Teamsupport
  module Utils
  module_function

    # Returns new array with concatenated results of running block for every element
    #
    # @param enumerable [Enumerable]
    #
    # @return [Array, Enumerator]
    #
    # @api private
    def flat_pmap(enumerable)
      return to_enum(:flat_pmap, enumerable) unless block_given?
      pmap(enumerable, &Proc.new).flatten(1)
    end

    # Returns new array with the results of running block once for every element
    #
    # @param enumerable [Enumerable]
    #
    # @return [Array, Enumerator]
    #
    # @api private
    def pmap(enumerable)
      return to_enum(:pmap, enumerable) unless block_given?
      if enumerable.count == 1
        enumerable.collect { |object| yield(object) }
      else
        enumerable.collect { |object| Thread.new { yield(object) } }.collect(&:value)
      end
    end
  end
end
