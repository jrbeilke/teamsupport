module Teamsupport
  # Custom error class for rescuing from all Teamsupport errors
  class Error < StandardError
    # Provide a code method for reading HTTP status code from Error
    #
    # @example
    #   teamsupport_error = Teamsupport::Error.new(code: 404)
    #   teamsupport_error.code
    #
    # @return [Integer]
    #
    # @api public
    attr_reader :code

    # Raised when Teamsupport returns a 4xx HTTP status code
    ClientError = Class.new(self)

    # Raised when Teamsupport returns the HTTP status code 400
    BadRequest = Class.new(ClientError)

    # Raised when Teamsupport returns the HTTP status code 401
    Unauthorized = Class.new(ClientError)

    # Raised when Teamsupport returns the HTTP status code 403
    Forbidden = Class.new(ClientError)

    # Raised when Teamsupport returns the HTTP status code 404
    NotFound = Class.new(ClientError)

    # Raised when Teamsupport returns the HTTP status code 406
    NotAcceptable = Class.new(ClientError)

    # Raised when Teamsupport returns the HTTP status code 422
    UnprocessableEntity = Class.new(ClientError)

    # Raised when Teamsupport returns the HTTP status code 429
    TooManyRequests = Class.new(ClientError)

    # Raised when Teamsupport returns a 5xx HTTP status code
    ServerError = Class.new(self)

    # Raised when Teamsupport returns the HTTP status code 500
    InternalServerError = Class.new(ServerError)

    # Raised when Teamsupport returns the HTTP status code 502
    BadGateway = Class.new(ServerError)

    # Raised when Teamsupport returns the HTTP status code 503
    ServiceUnavailable = Class.new(ServerError)

    # Raised when Teamsupport returns the HTTP status code 504
    GatewayTimeout = Class.new(ServerError)

    ERRORS = {
      400 => Teamsupport::Error::BadRequest,
      401 => Teamsupport::Error::Unauthorized,
      403 => Teamsupport::Error::Forbidden,
      404 => Teamsupport::Error::NotFound,
      406 => Teamsupport::Error::NotAcceptable,
      422 => Teamsupport::Error::UnprocessableEntity,
      429 => Teamsupport::Error::TooManyRequests,
      500 => Teamsupport::Error::InternalServerError,
      502 => Teamsupport::Error::BadGateway,
      503 => Teamsupport::Error::ServiceUnavailable,
      504 => Teamsupport::Error::GatewayTimeout,
    }.freeze

    class << self
      # Create a new error from an HTTP response
      #
      # @example
      #   teamsupport_error = Teamsupport::Error::ERRORS[code]
      #   teamsupport_error.from_response(body, headers) unless klass.nil?
      #
      # @param body [String]
      # @param headers [Hash]
      #
      # @return [Teamsupport::Error]
      #
      # @api public
      def from_response(body, _headers)
        message, code = parse_error(body)
        new(message, code)
      end

    private

      # Parses response body for errors
      #
      # @param body [String]
      #
      # @return [Array, nil]
      #
      # @api private
      def parse_error(body)
        if body.nil? || body.empty?
          ['', nil]
        elsif body[:error]
          [body[:error], nil]
        elsif body[:errors]
          extract_message_from_errors(body)
        end
      end

      # Extracts error messages from response body
      #
      # @param body [String]
      #
      # @return [Array]
      #
      # @api private
      def extract_message_from_errors(body)
        first = Array(body[:errors]).first
        if first.is_a?(Hash)
          [first[:message].chomp, first[:code]]
        else
          [first.chomp, nil]
        end
      end
    end

    # Initializes a new Error object
    #
    # @param message [Exception, String]
    # @param code [Integer]
    #
    # @return [Teamsupport::Error]
    #
    # @api private
    def initialize(message = '', code = nil)
      super(message)
      @code = code
    end
  end
end
