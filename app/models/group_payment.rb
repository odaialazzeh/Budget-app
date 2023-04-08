class GroupPayment < ApplicationRecord
  belongs_to :group, foreign_key: 'group_id', class_name: 'Group'
  belongs_to :payment, foreign_key: 'payment_id', class_name: 'Payment'
end
