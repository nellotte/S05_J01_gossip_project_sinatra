require 'gossip'
class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end
  
  get '/gossips/:id' do
     # Récupérer l'ID du gossip depuis les paramètres de route
    gossip = Gossip.find(params['id']) 
    if !gossip[0]   && !gossip[1]  && !gossip[2] #si les éléments de gossip !est different de vide
      redirect '/'
    else 
      erb :show_gossip, locals: {gossip: Gossip.find(params['id'])}
    end
  end

  get '/:id/edit' do #nouvelle route pour l'affichage du formulaire
    id = params['id'].to_i
    gossip = Gossip.find(id)
    erb :edit, locals: { gossip: gossip, id: id }
  end

  #nouvelle route pour la soumission du formulaire
  post '/:id/edit' do
    gossip = Gossip.find(params['id'].to_i)
    gossip.update(params["new_author"], params["new_content"]) 
    redirect "/gossips/#{gossip.id}"
  end

end