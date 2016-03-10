class AddNoteToComments < ActiveRecord::Migration
  def change
    add_column :comments, :note, :integer
  end
end
