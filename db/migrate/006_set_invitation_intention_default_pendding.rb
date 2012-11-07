class SetInvitationIntentionDefaultPendding < ActiveRecord::Migration
  def change
    change_column :invitations, :intention, :string, :default => 'pending'
  end
end
