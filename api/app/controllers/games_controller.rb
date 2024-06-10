# frozen_string_literal: true

# Controller for the game
class GamesController < ApplicationController
  before_action :validate_throw, only: :play

  def play
    result = Rps::Throw.new(player_throw: player_throw).call
    render json: result
  rescue RpsApi::Error => e
    render json: { error: e.message }, status: e.status
  end

  private

  def player_throw
    params.require(:player_throw)
  end

  def validate_throw
    return if Rps::Throw::THROWS.include?(player_throw)

    render json: { error: 'Invalid throw' }, status: :bad_request
  end
end
