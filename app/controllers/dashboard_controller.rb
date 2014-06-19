class DashboardController < ApplicationController
  def index
     gon.signed_in = signed_in?
  end
end
