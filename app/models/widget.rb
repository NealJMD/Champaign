class Widget < ActiveRecord::Base

  belongs_to :campaign_page, inverse_of: :campaign_pages_widgets

  validates :page_display_order, presence: true, numericality: { only_integer: true, greater_than: 0 }
  # validates_uniqueness_of  :page_display_order, :scope => :campaign_page_id

  types = %w(TextWidget PetitionWidget)
  validates :type, presence: true, inclusion: types

end
