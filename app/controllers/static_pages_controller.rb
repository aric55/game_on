class StaticPagesController < ApplicationController
  def home
  end

  def events
  end

  def staff
  end

  def servers
  end

  def sponsors
  end

  def admin
    redirect_to(root_url) unless current_user.try(:admin?)
  end
end
