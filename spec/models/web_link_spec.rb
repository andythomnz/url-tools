require 'rails_helper'

describe WebLink, type: :model do
  let(:web_link) { build(:google_web_link) }
  subject { web_link }

  context "#destination" do
    context "when destination is missing" do
      let(:web_link) { build(:google_web_link, destination: nil) }

      it { expect(subject).to be_invalid }
    end

    context "when destination is an HTTP URL" do
      let(:web_link) { build(:google_web_link, destination: "http://not-secure.com") }

      it { expect(subject).to be_invalid }
    end

    context "when destination is not a URL" do
      let(:web_link) { build(:google_web_link, destination: "abc123$") }

      it { expect(subject).to be_invalid }
    end

    context "when destination is a valid HTTPS URL" do
      it { expect(subject).to be_valid }
    end
  end

  context "#key" do
    context "when key is missing" do
      let(:web_link) { create(:google_web_link, key: nil) }

      it "auto generates a key" do
        expect(subject.key).to be_present
      end
    end

    context "when key is more than 10 chars long" do
      let(:web_link) { build(:google_web_link, key: "ABCDEFGHIJK") }

      it { expect(subject).to be_invalid }
    end

    context "when key is a six digit alphanumeric" do
      it { expect(subject).to be_valid }
    end
  end
end
