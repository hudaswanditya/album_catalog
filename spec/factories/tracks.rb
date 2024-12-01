FactoryBot.define do
  factory :track do
    title { Faker::Music::GratefulDead.song }
    artist_name { Faker::Music.band }
    duration { Faker::Number.between(from: 100, to: 300) }
    album
  end
end

