class ViewingPartyController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @movie = MovieFacade.new.find_movie(params[:movie_id])
  end

  def create
    movie = MovieFacade.new.find_movie(params[:movie_id])
    host = User.find(params[:user_id])
    party = Party.new(party_params)
    if party.save
      UserParty.create(user_id: host.id, party_id: party.id)
      params[:user].each do |user_id|
        UserParty.create(user_id: user_id, party_id: party.id)
      end
      redirect_to user_path(host.id)
      flash[:notice] = 'Your party has been created!'
    else
      flash[:alert] = 'Please fill in all fields.'
      redirect_to new_user_movie_viewing_party_path(host, movie.id)
    end
  end

  private
  def party_params
    params.permit(:movie_id, :host, :duration, :date, :start_time)
  end
end