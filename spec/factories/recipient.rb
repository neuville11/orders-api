FactoryBot.define do
	factory :recipient do
		school_id = 1
		name = 'Recipient1'
		address = 'Address1'
	end

	factory :random_recipient, class: School do
		school_id = 1
		name = Faker::Name.first_name
		address = Faker::Address.street_address
	end
end
