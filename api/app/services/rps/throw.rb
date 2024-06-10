# frozen_string_literal: true

module Rps
  # Service to get the server throw or generate a random throw
  class Throw
    THROWS = %w[rock paper scissors].freeze
    WIN_CONDITIONS = {
      'rock' => ['scissors'],
      'scissors' => ['paper'],
      'paper' => ['rock']
    }.freeze

    def initialize(player_throw:)
      @player_throw = player_throw
    end

    def call
      result = determine_result

      {
        player_throw: player_throw,
        computer_throw: computer_throw,
        result: result
      }
    end

    private

    attr_reader :player_throw

    def computer_throw
      server_throw
    rescue RpsApi::TimeoutError, RpsApi::ServerError, RpsApi::UnexpectedError
      random_throw
    end

    def determine_result
      return 'Draw' if player_throw == computer_throw

      if WIN_CONDITIONS[player_throw].include?(computer_throw)
        'Player wins'
      elsif WIN_CONDITIONS[computer_throw].include?(player_throw)
        'Computer wins'
      else
        'Draw'
      end
    end

    def random_throw
      @random_throw ||= THROWS.sample
    end

    def server_throw
      @server_throw ||= RpsApi::GetServerThrow.new.call['body']
    end
  end
end
