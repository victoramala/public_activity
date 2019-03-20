# frozen_string_literal: true

# Migration responsible for creating a table with activities
class CreateProjectActivities < (ActiveRecord.version.release() < Gem::Version.new('5.2.0') ? ActiveRecord::Migration : ActiveRecord::Migration[5.2])
  # Create table
  def self.up
    create_table :project_activities do |t|
      t.belongs_to :trackable, :polymorphic => true
      t.belongs_to :owner, :polymorphic => true
      t.string  :key
      t.text    :parameters
      t.belongs_to :recipient, :polymorphic => true

      t.timestamps
    end

    add_index :project_activities, [:trackable_id, :trackable_type]
    add_index :project_activities, [:owner_id, :owner_type]
    add_index :project_activities, [:recipient_id, :recipient_type]
  end
  # Drop table
  def self.down
    drop_table :project_activities
  end
end
