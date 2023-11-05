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

  context "#expires_at" do
    context "when creating a new WebLink" do
      let(:web_link) { create(:google_web_link) }

      it "sets the expiration 6 months into the future" do
        expect(subject.expires_at).to be_within(1.minute).of(6.months.from_now.at_end_of_day)
      end
    end
  end

  context ".active" do
    let!(:active) { create(:google_web_link, expires_at: 2.days.from_now) }
    let!(:active_2) { create(:google_web_link, expires_at: 2.months.from_now) }
    let!(:active_3) { create(:google_web_link, expires_at: 5.months.from_now) }

    let!(:expired) { create(:google_web_link, expires_at: 5.minutes.ago) }
    let!(:expired_2) { create(:google_web_link, expires_at: 5.months.ago) }

    it "includes 3 active WebLinks in the collection" do
      expect(WebLink.active).to include active, active_2, active_3
    end

    it "does not include the 2 expired WebLinks in the collection" do
      expect(WebLink.active).to_not include expired, expired_2
    end
  end
end
