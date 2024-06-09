# frozen_string_literal: true

module RpsApi
  class Error < StandardError
    attr_reader :status

    def initialize(message, status)
      super(message)
      @status = status
    end
  end

  class NotFoundError < Error
    def initialize(message = 'Not Found')
      super(message, :not_found)
    end
  end

  class BadRequestError < Error
    def initialize(message = 'Bad Request')
      super(message, :bad_request)
    end
  end

  class ServerError < Error
    def initialize(message = 'Server Error')
      super(message, :internal_server_error)
    end
  end

  class UnexpectedError < Error
    def initialize(message = 'Unexpected Error')
      super(message, :internal_server_error)
    end
  end

  class TimeoutError < Error
    def initialize(message = 'Request timed out')
      super(message, :internal_server_error)
    end
  end
end
