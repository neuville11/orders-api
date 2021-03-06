class OrderItem < ApplicationRecord
  include Filterable
  include ErrorMessages

  belongs_to :order
  belongs_to :recipient

  validate :within_daily_gift_limit, :within_recipient_limit
  validate :order_not_shipped_or_cancelled, on: :update

  validates :recipient_id, presence: true

  enum gift_type: { MUG: 1, T_SHIRT: 2, HOODIE: 3, STICKER: 4 }

  private

  def within_daily_gift_limit
    old_quantity = attribute_in_database('quantity') || 0
    already_ordered = order.school.ordered_gifts_on(order.date) - old_quantity
    return unless (already_ordered + quantity) > MAX_GIFTS_PER_DAY

    OrderItem.add_count_error(errors: errors, label: 'Gift', message: I18n.t('order_item.max_gifts', max_gifts: MAX_GIFTS_PER_DAY))
  end

  def within_recipient_limit
    recipients = if order.recipient_id_list.include? recipient_id
                   order.recipient_count
                 else
                   order.recipient_count + 1
                 end
    return unless recipients > MAX_RECIPIENTS_PER_ORDER

    OrderItem.add_count_error(errors: errors, label: OrderItem.to_s, message: I18n.t('order_item.limit_error', max_recipients: MAX_RECIPIENTS_PER_ORDER))
  end

  def order_not_shipped_or_cancelled
    return unless order.ORDER_SHIPPED? || order.ORDER_CANCELLED?

    OrderItem.add_status_error(errors, I18n.t('oder_item.modify_error', order_status: order.status))
  end
end
