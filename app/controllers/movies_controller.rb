class MoviesController < ApplicationController

  def index
    @user = current_user
    @movies = if params[:search].present?
                  MovieFacade.new.search(params[:search])
              else
                  MovieFacade.new.top_rated
              end
  end

  def show
    @user = current_user
    @movie = MovieFacade.new.find_movie(params[:id])
    @reviews = MovieFacade.new.reviews(params[:id])
    @cast = MovieFacade.new.cast(params[:id])
  end
end