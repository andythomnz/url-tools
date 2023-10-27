require 'rails_helper'

RSpec.describe "WebLinks", type: :request do
  describe "#redirect" do
    let(:web_link) { create(:google_web_link) }
    let(:key) { web_link.key }

    before do
      get "/r/#{key}"
    end

    context "to a valid key" do
      it "HTTP redirects the key to the destination" do
        expect(response).to redirect_to web_link.destination
      end
    end

    context "to a non-existent key" do
      let(:key) { "FAKE" }

      it { expect(response).to be_not_found }
    end
  end
end
