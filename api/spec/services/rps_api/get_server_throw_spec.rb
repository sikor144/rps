# spec/services/rps_api/get_server_throw_spec.rb
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe RpsApi::GetServerThrow do
  subject { described_class.new }

  let(:base_url) { ENV['RPS_API_BASE_URL'] }
  let(:endpoint) { "#{base_url}/rps-stage/throw" }

  describe '#call' do
    context 'when the response is successful' do
      before do
        stub_request(:get, endpoint)
          .to_return(status: 200, body: { throw: 'rock' }.to_json, headers: { 'Content-Type' => 'application/json' })
      end

      it 'returns the server throw' do
        response = subject.call
        expect(response['throw']).to eq('rock')
      end
    end

    context 'when the response is a 400' do
      before do
        stub_request(:get, endpoint).to_return(status: 400)
      end

      it 'raises a BadRequestError' do
        expect { subject.call }.to raise_error(RpsApi::BadRequestError, 'Bad Request')
      end
    end

    context 'when the response is a 404' do
      before do
        stub_request(:get, endpoint).to_return(status: 404)
      end

      it 'raises a NotFoundError' do
        expect { subject.call }.to raise_error(RpsApi::NotFoundError, 'Not Found')
      end
    end

    context 'when the response is a server error' do
      before do
        stub_request(:get, endpoint).to_return(status: 500)
      end

      it 'raises a ServerError' do
        expect { subject.call }.to raise_error(RpsApi::ServerError, 'Server Error: 500')
      end
    end

    context 'when the response times out' do
      before do
        stub_request(:get, endpoint).to_timeout
      end

      it 'raises a TimeoutError' do
        expect { subject.call }.to raise_error(RpsApi::TimeoutError, 'Request timed out')
      end
    end
  end
end
