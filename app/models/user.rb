# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #articlesモデル（article.rb）のことを指す。userあたり複数記事があるため複数形で表記。Userが消えると紐づく記事が消去（Destroy）
  has_many :articles, dependent: :destroy

  #１つにUserに対してプロフィールは一つのため単数形で記述。Userが消えると紐づくプロフィールが消去（Destroy）
  has_one :profile, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorite_articles, through: :likes, source: :article

  delegate :age, :gender, to: :profile, allow_nil: true

  def has_writtern?(article)
    articles.exists?(id: article.id)
  end

  def has_liked?(article)
    likes.exists?(article_id: article.id)
  end

  def display_name
    # if profile && profile.nickname
    #   profile.nickname
    # else
    #   self.email.split('@').first
    # end

    #ぼっち演算子"&."（オプショナルチェイニングとも言う）。nilの時はnilエラーを発生することなくスルーされる
    profile&.nickname || self.email.split('@').first
  end

  #下の二つはuser.rb内でdelegateで定義したため削除
  # def birthday
  #   profile&.birthday
  # end

  # def gender
  #   profile&.gender
  # end

  def prepare_profile
    profile || build_profile
  end

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      "default-avatar.png"
    end
  end

end
