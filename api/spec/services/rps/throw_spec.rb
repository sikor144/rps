# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Rps::Throw do
  let(:player_throw) { 'rock' }
  let(:service) { described_class.new(player_throw: player_throw) }

  describe '#call' do
    context 'when the server returns a throw' do
      before do
        allow_any_instance_of(RpsApi::GetServerThrow).to receive(:call)
          .and_return({ 'body' => 'scissors' })
      end

      it 'returns "Player wins" if player wins' do
        expect(service.call).to eq('Player wins')
      end

      it 'returns "Computer wins" if computer wins' do
        allow_any_instance_of(RpsApi::GetServerThrow).to receive(:call)
          .and_return({ 'body' => 'paper' })
        expect(service.call).to eq('Computer wins')
      end

      it 'returns "Draw" if it is a draw' do
        allow_any_instance_of(RpsApi::GetServerThrow).to receive(:call)
          .and_return({ 'body' => 'rock' })
        expect(service.call).to eq('Draw')
      end
    end

    context 'when the server call fails' do
      before do
        allow_any_instance_of(RpsApi::GetServerThrow).to receive(:call)
          .and_raise(RpsApi::TimeoutError)
      end

      it 'generates a random throw and determines the result' do
        allow(service).to receive(:generate_random_throw).and_return('scissors')
        expect(service.call).to eq('Player wins')

        allow(service).to receive(:generate_random_throw).and_return('paper')
        expect(service.call).to eq('Computer wins')

        allow(service).to receive(:generate_random_throw).and_return('rock')
        expect(service.call).to eq('Draw')
      end
    end
  end
end
