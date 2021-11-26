module Secured
  extend ActiveSupport::Concern

  included do
    before_action :logged_in?
  end
end