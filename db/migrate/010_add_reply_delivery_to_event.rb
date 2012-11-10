class AddReplyDeliveryToEvent < ActiveRecord::Migration
  def change
    add_column :events, :reply_delivery, :datetime
  end
end
