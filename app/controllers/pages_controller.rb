class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  skip_after_action :verify_authorized, only: [ :home ]

  def home
    authorize :page, :home?
    @all_recipes = Recipe.all
                         .order(name: :asc)
    # redirect_to :profile unless current_user.nil?
  end

  def profile
    authorize :page, :profile?
    @user_recipes = Recipe.where(user: current_user)
                          .order(name: :asc)
  end

  def about_us
    authorize :page, :about_us?
  end
end
