class ChangeUserIdInLikesToBigint < ActiveRecord::Migration[5.2]
  def change
    change_column :likes, :user_id, :bigint, using: 'user_id::bigint', null: false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
    # using: 'company_id::integer'
  end
end
