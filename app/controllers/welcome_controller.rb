class WelcomeController < ApplicationController
  def index
    render layout: 'welcome_layout'
  end
end
