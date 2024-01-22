# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :integer          not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#
class Comment < ApplicationRecord
  belongs_to :article #articleモデル（article.rb）のことを指す。コメントごとに該当するarticleは一つのため単数系で表記
  validates :content, presence: true
end
