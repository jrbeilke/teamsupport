module Teamsupport
  module Version
  module_function

    # Returns major version
    #
    # @return [Integer]
    #
    # @api private
    def major
      0
    end

    # Returns minor version
    #
    # @return [Integer]
    #
    # @api private
    def minor
      2
    end

    # Returns patch version
    #
    # @return [Integer]
    #
    # @api private
    def patch
      0
    end

    # Returns pre version
    #
    # @return [Integer, NilClass]
    #
    # @api private
    def pre
      nil
    end

    # Returns version as hash
    #
    # @return [Hash]
    #
    # @api private
    def to_h
      {
        major: major,
        minor: minor,
        patch: patch,
        pre: pre,
      }
    end

    # Returns version as array
    #
    # @return [Array]
    #
    # @api private
    def to_a
      [major, minor, patch, pre].compact
    end

    # Returns version as string
    #
    # @return [String]
    #
    # @api private
    def to_s
      to_a.join('.')
    end
  end
end
