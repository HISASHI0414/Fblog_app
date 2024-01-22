# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { minimum: 2, maximum: 100}
  validates :title, format: { with: /\A(?!\@)/}
  
  validates :content, presence: true
  validates :content, length: { minimum: 10, maximum: 1000}
  validates :content, uniqueness: true

  validate :validate_title_and_content_length

  belongs_to :user #userモデル（user.rb）のことを指す。記事ごとに該当するUserは一人のため単数系で表記

  def display_created_at
    I18n.l(self.created_at, format: :default)
  end

  def author_name
    user.display_name #article.rbはuser.rbと紐づいている（belongs_to :user）ため、user.rb内のメソッド（display_name）が使える
  end

  private
  def validate_title_and_content_length
    char_count = self.title.length + self.content.length
    unless char_count >= 100
      errors.add(:content, "100文字以上で！")
    end
  end
end
