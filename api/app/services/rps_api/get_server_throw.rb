# frozen_string_literal: true

require_relative 'base'

module RpsApi
  # Service class to interact with the Rock Paper Scissors API
  class GetServerThrow < Base
    def call
      get('/rps-stage/throw')
    end
  end
end
