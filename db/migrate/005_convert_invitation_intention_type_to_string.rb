class ConvertInvitationIntentionTypeToString < ActiveRecord::Migration
  def change
    change_column :invitations, :intention, :string
  end
end
