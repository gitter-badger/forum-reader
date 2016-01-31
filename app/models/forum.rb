# coding: utf-8
# Форум.
#
# == Schema Information
#
# Table name: forums
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string           not null
#  url          :string           not null
#  target       :integer          not null
#  last_post_at :datetime
#  position     :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_forums_on_last_post_at  (last_post_at)
#  index_forums_on_name          (name)
#  index_forums_on_target        (target)
#  index_forums_on_url           (url)
#  index_forums_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_99e32c35a4  (user_id => users.id)
#

class Forum < ActiveRecord::Base
  belongs_to :user
end
