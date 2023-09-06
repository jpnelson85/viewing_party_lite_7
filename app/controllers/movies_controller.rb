class MoviesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @movies = if params[:search].present?
                  MovieFacade.new.search(params[:search])
              else
                  MovieFacade.new.top_rated
              end
  end

  def show
    @user = User.find(params[:user_id])
    @movie = MovieFacade.new.find_movie(params[:id])
    @reviews = MovieFacade.new.reviews(params[:id])
    @cast = MovieFacade.new.cast(params[:id])
  end
end