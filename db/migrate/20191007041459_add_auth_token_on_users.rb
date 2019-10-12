class AddAuthTokenOnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :auth_token, :string
    add_index :users, :auth_token, unique: true
    
    # 因為會有舊的使用者在你的 db 裡面，所以要幫他們產生 auth_token
    User.all.each do |user|
      user.regenerate_auth_token
      # regenerate_xxx 是 has_secure_token 提供的方法
      # 可以重新產生一組 token
    end
  end
end
