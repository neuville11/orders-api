FactoryBot.define do
	factory :order do
		school_id { 1 }
		status { 1 }
		date { Date.today }
		notify_user { true }
	end
end
