require 'rails_helper'

RSpec.describe "WebLinks", type: :request do
  describe "#redirect" do
    let(:web_link) { create(:google_web_link) }

    before do
      get "/r/#{web_link.key}"
    end

    it "HTTP redirects the key to the destination" do
      expect(response).to redirect_to web_link.destination
    end
  end
end
