module Teamsupport
  class Arguments < Array
    # Provide an options method for reading argument options
    #
    # @example
    #   teamsupport_arguments = Teamsupport::Arguments.new(args)
    #   teamsupport_arguments.options
    #
    # @return [Hash]
    #
    # @api public
    attr_reader :options

    # Initializes a new Arguments object
    #
    # @param args [Hash]
    #
    # @return [Teamsupport::Arguments]
    #
    # @api private
    def initialize(args)
      @options = args.last.is_a?(::Hash) ? args.pop : {}
      super(args.flatten)
    end
  end
end
