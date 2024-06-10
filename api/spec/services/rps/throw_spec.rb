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
        result = service.call
        expect(result[:result]).to eq('Player wins')
        expect(result[:computer_throw]).to eq('scissors')
        expect(result[:player_throw]).to eq('rock')
      end

      it 'returns "Computer wins" if computer wins' do
        allow_any_instance_of(RpsApi::GetServerThrow).to receive(:call)
          .and_return({ 'body' => 'paper' })
        result = service.call
        expect(result[:result]).to eq('Computer wins')
        expect(result[:computer_throw]).to eq('paper')
        expect(result[:player_throw]).to eq('rock')
      end

      it 'returns "Draw" if it is a draw' do
        allow_any_instance_of(RpsApi::GetServerThrow).to receive(:call)
          .and_return({ 'body' => 'rock' })
        result = service.call
        expect(result[:result]).to eq('Draw')
        expect(result[:computer_throw]).to eq('rock')
        expect(result[:player_throw]).to eq('rock')
      end
    end

    context 'when the server call fails' do
      before do
        allow_any_instance_of(RpsApi::GetServerThrow).to receive(:call)
          .and_raise(RpsApi::TimeoutError)
      end

      it 'generates a random throw and returns "Player wins" if player wins' do
        allow(service).to receive(:random_throw).and_return('scissors')
        result = service.call
        expect(result[:result]).to eq('Player wins')
        expect(result[:computer_throw]).to eq('scissors')
        expect(result[:player_throw]).to eq('rock')
      end

      it 'generates a random throw and returns "Computer wins" if computer wins' do
        allow(service).to receive(:random_throw).and_return('paper')
        result = service.call
        expect(result[:result]).to eq('Computer wins')
        expect(result[:computer_throw]).to eq('paper')
        expect(result[:player_throw]).to eq('rock')
      end

      it 'generates a random throw and returns "Draw" if it is a draw' do
        allow(service).to receive(:random_throw).and_return('rock')
        result = service.call
        expect(result[:result]).to eq('Draw')
        expect(result[:computer_throw]).to eq('rock')
        expect(result[:player_throw]).to eq('rock')
      end
    end
  end
end
