FactoryBot.define do
  factory :album do
    name { Faker::Music.album }
    state { :draft } 

		trait :published do
			state { :published }
		end
  end
end
