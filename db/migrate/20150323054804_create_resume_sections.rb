class CreateResumeSections < ActiveRecord::Migration
  def change
    create_table :resume_sections do |t|
    	t.integer :position
    	t.integer :resume_id

      t.timestamps
    end
  end
end
