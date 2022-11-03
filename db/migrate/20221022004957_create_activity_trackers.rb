class CreateActivityTrackers < ActiveRecord::Migration[7.0]
  def change
    create_table 'activity_trackers', force: :cascade do |t|
      t.string 'ussd_body'
      t.string 'message_type'
      t.string 'page', default: ''
      t.string 'menu_function'
      t.string 'activity_type'
      t.string 'mobile_number'
      t.string 'session_id'
      t.string 'pagination_page', default: ''
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
    end

    add_index :activity_trackers, :mobile_number
  end
end
