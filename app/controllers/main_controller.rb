class MainController < ApplicationController
  def index
    gon.current_user = current_user
    logger.info current_user
  end
end
