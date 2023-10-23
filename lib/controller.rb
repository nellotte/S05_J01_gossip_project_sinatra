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

  
  

end