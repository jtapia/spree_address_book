module UserDecorator
  extend ActiveSupport::Concern

  included do
    has_many :addresses, -> { where(deleted_at: nil).order('updated_at DESC') }, class_name: 'Spree::Address'
  end
end

Spree.user_class.include(UserDecorator)
