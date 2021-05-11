FactoryBot.define do
	factory :order_item do
		order_id = 1
		recipient_id = 1
		gift_type = rand { 1..4 }
		quantity = 16
	end
end
