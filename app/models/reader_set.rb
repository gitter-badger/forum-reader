# coding: utf-8
# Настройки Reader -а.
#
# == Schema Information
#
# Table name: reader_sets
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  status     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_reader_sets_on_status   (status)
#  index_reader_sets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_503d442a23  (user_id => users.id)
#
class ReaderSet < BaseSet
end
