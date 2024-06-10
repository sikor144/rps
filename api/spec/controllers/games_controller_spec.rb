# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  render_views

  describe 'GET #play' do
    let(:player_throw) { 'rock' }

    context 'with a valid throw' do
      before do
        allow_any_instance_of(Rps::Throw).to receive(:call)
          .and_return({
                        player_throw: 'rock',
                        computer_throw: 'scissors',
                        result: 'Player wins'
                      })
      end

      it 'returns a successful response' do
        get :play, params: { player_throw: player_throw }
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['player_throw']).to eq('rock')
        expect(body['computer_throw']).to eq('scissors')
        expect(body['result']).to eq('Player wins')
      end
    end

    context 'with an invalid throw' do
      it 'returns a bad request error' do
        get :play, params: { player_throw: 'invalid_throw' }
        expect(response).to have_http_status(:bad_request)
        body = JSON.parse(response.body)
        expect(body['error']).to eq('Invalid throw')
      end
    end

    context 'when the service raises an error' do
      before do
        allow_any_instance_of(Rps::Throw).to receive(:call)
          .and_raise(RpsApi::ServerError.new)
      end

      it 'returns an internal server error' do
        get :play, params: { player_throw: player_throw }
        expect(response).to have_http_status(:internal_server_error)
        body = JSON.parse(response.body)
        expect(body['error']).to eq('Server Error')
      end
    end
  end
end
