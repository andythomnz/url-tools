require 'rails_helper'

RSpec.describe "WebLinks", type: :request do
  let(:web_link) { create(:google_web_link) }

  describe "#redirect" do
    let(:key) { web_link.key }

    before { get "/r/#{key}" }

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

  describe "#create" do
    subject { -> { post "/web_links", params: { "web_link" => params } }}
    before { subject.call }

    context "with valid parameters" do
      let(:params) { { "key" => "ABC123", "destination" => "https://example.com" } }

      it { expect(WebLink.find_by_key(params["key"])).to be_present }
      it { expect(WebLink.last.attributes).to include params }
    end

    context "with invalid parameters" do
      let(:params) { { key: "AAAAAAAAAAAAAAAA", destination: "example" } }

      it { expect{subject.call}.to_not change{WebLink.count} }
      it { expect(response).to have_http_status :unprocessable_entity }
    end
  end

  describe "#show" do
    before { get "/web_links/#{web_link.id}" }

    it { expect(response).to be_ok }
  end
end
