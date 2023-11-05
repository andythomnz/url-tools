FactoryBot.define do
  factory :google_web_link, class: "WebLink" do
    destination { "https://www.google.com" }
  end
end