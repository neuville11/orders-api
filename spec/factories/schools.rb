FactoryBot.define do
	factory :school do
		name { 'School1' }
		address { 'Address1' }
	end

	factory :random_school, class: 'School' do
		name { Faker::University.name }
		address { Faker::Address.street_address }
	end
end
