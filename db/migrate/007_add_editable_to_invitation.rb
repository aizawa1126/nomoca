class AddEditableToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :editable, :boolean
  end
end
