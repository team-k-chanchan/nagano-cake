class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #会員氏名のメソッド
  def full_name
    first_name + last_name
  end

  #バリデーション
  validates :first_name, :last_name, :kana_first_name, :kana_last_name,
            :postal_code, :address, :phone_number, :email,
            presence: true
  validates :kana_first_name, :kana_last_name,
            format: {with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/, message: "全角カタカナのみで入力して下さい"}
  validates :postal_code, length: {is: 7}, numericality: { only_integer: true }
  validates :phone_number, numericality: { only_integer: true }

end
