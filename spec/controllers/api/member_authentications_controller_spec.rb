# frozen_string_literal: true
require 'rails_helper'

describe Api::MemberAuthenticationsController do
  describe 'POST create' do
    let(:auth) { double('auth', valid?: true) }

    before do
      allow(MemberAuthenticationBuilder).to receive(:build) { auth }

      post :create, email: 'test@example.com', password: 'p', password_confirmation: 'p', page_id: '1'
    end

    it 'builds authentication' do
      expect(MemberAuthenticationBuilder).to have_received(:build)
        .with(password: 'p', password_confirmation: 'p', email: 'test@example.com')
    end

    context 'successfully creates authentication' do
      it 'returns with js snippet to redirect' do
        expect(response.body).to match("window.location = '/pages/1/follow-up'")
      end
    end

    context 'unsuccessfully creates authentication' do
      let(:auth) { double('auth', valid?: false, errors: [{foo: :bar}]) }

      it 'returns errors as json' do
        expect(response.status).to eq(422)
        expect(response.body).to eq([{foo: :bar}].to_json)
      end
    end
  end
end