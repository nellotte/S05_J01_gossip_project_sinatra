require 'csv'

class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    # Retournez le gossip trouvé
    data =  all() #on créé la variable data qu contient tous les gossips
    if id.to_i < 0 || id.to_i + 1 > data.length #si on met un chiffre inf à 0 ou supérieur au nombre de gossip disponible
      #on renvoit un tableau vide. Le tableau est composé de 3 éléments (id, author et content)
      return [nil, nil, nil]
    else #si l'id correspond à un gossip existant, on retourne un tableau avec les 3 élément du gossip en question
      return [id, data[id.to_i].author, data[id.to_i].content] #dans data, on remonte l'auteur du gossip[x] et le content du gossip [X]
    end
  end

  def update(id, new_author, new_content)
    # Lisez d'abord tous les gossips à partir du fichier CSV
    all_gossips = CSV.read("./db/gossip.csv")

    # Vérifiez si l'ID est dans la plage valide
    if id.to_i >= 0 && id.to_i < all_gossips.length
      # Mise à jour les champs du gossip avec les nouvelles valeurs
      all_gossips[id][0] = new_author
      all_gossips[id][1] = new_content

    #mises à jour dans le fichier CSV
      CSV.open("./db/gossip.csv", "w") do |csv|
        all_gossips.each do |gossip|
          csv << gossip
        end
      end
    end
  end
end 

