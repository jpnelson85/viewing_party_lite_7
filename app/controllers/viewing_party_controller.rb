class ViewingPartyController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @user = current_user
    @movie = MovieFacade.new.find_movie(params[:movie_id])
  end

  def create
    movie = MovieFacade.new.find_movie(params[:movie_id])
    host = current_user
    party = Party.new(party_params)
    if party.save
      UserParty.create(user_id: host.id, party_id: party.id)
      params[:user].each do |user_id|
        UserParty.create(user_id: user_id, party_id: party.id)
      end
      redirect_to dashboard_path
      flash[:notice] = 'Your party has been created!'
    else
      flash[:alert] = 'Please fill in all fields.'
      redirect_to new_movie_viewing_party_path(movie.id)
    end
  end

  private
  def party_params
    params.permit(:movie_id, :host, :duration, :date, :start_time)
  end
end