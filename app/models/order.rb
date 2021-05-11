class Order < ApplicationRecord
  include Filterable
  include ErrorMessages

  belongs_to :school
  has_many :items, class_name: 'OrderItem'
  has_many :recipients, through: :items

  accepts_nested_attributes_for :items

  validates :school_id, presence: true
  validates :date, presence: true
  validate :correct_order_flow, :order_not_shipped_or_cancelled, on: :update

  before_save :flag_if_status_changed_to_shipped

  enum status: {
    ORDER_RECEIVED: 1, ORDER_PROCESSING: 2, ORDER_SHIPPED: 3, ORDER_CANCELLED: 4
  }

  ORDER_SHIPPED = 'ORDER_SHIPPED'
  SHIPPED_AND_CANCELLED_ORDER = %w[ORDER_CANCELLED].push ORDER_SHIPPED

  def gift_count
    items.map(&:quantity).reduce(:+)
  end

  def recipient_id_list
    @recipient_id_list ||= items.map(&:recipient_id).uniq
  end

  def recipient_count
    @recipient_count ||= recipient_id_list.count
  end

  private

  def flag_if_status_changed_to_shipped
    flag_for_notification if status == ORDER_SHIPPED && old_status != ORDER_SHIPPED
  end

  def order_not_shipped_or_cancelled
    return unless SHIPPED_AND_CANCELLED_ORDER.include? old_status

    Order.add_status_error(errors, I18n.t('order.flow.modify_error', old_status: old_status))
  end

  def correct_order_flow
    order_old_status = Order.statuses[old_status]
    new_status = Order.statuses[status]
    return if ORDER_CANCELLED? || new_status == order_old_status + 1 || new_status == order_old_status

    Order.add_status_error(errors, I18n.t('order.flow.error'))
  end

  def old_status
    @old_status = attribute_in_database('status')
  end

  def flag_for_notification
    self.notify_user = true
  end
end
