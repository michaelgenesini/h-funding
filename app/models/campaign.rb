class Campaign < ActiveRecord::Base
  
	# Setup accessible (or protected) attributes for your model
	attr_accessible :title, :description, :goal, :date_start, :date_end, :collected, :user_id


	validates :title, presence: true#,
			 #length: { in: 0..20 }
	validates :description, presence: true,
				length: { minimum: 0,
					  maximum: 4000
					}
	validates :goal, presence: true,
			 numericality: { only_integer: true,
					 greater_than: 100,
					 less_than: 1000000
				       }
	validates :user_id, presence: true
	validates :date_end, presence: true
	


  	belongs_to :user
	has_many :donations
	has_many :costs

	#seleziona le campagne create da un determinato utente
	def self.mine(*args)
	  where('user_id = ?', args.first)
	end

	#seleziona le campagne create da un determinato utente
	def self.open
	  where('date_start < ? AND date_end > ?', Time.now, Time.now)
	end

	#numero di donazioni effettuate
	#TORTONESI
	def number_of_donations(campaign)
	  campaign.donations.count
	end

	#totale di donazioni effettuate
	def self.amount_of_donations(campaign)
	  campaign.donations.sum('amount')
	end
	#numero di spese
	def self.number_of_costs(campaign)
	  campaign.costs.count
	end
	#totale di spese effettuate
	def self.amount_of_costs(campaign)
	  campaign.costs.sum('amount')
	end
	#
	def self.name_of_campaign_for_donation(donation)
		donation.campaign.presence ? donation.campaign.title : 'Campaign removed'
	end
	#number of days
	def self.days_left(campaign)
		(campaign.date_end - campaign.date_start).to_i / (24 * 60 * 60)
	end
	#campaign status
	def self.campaign_status(campaign)
		if campaign.date_start < Time.now and campaign.date_end > Time.now
			true
		else
			false
		end
	end
	#obbiettivo raggiunto
	def self.campaign_complete?(campaign)
		if campaign.donations.sum('amount') >= campaign.goal
			true
		else
			false
		end
	end
	#campagna iniziata?
	def self.started?(campaign)
		if campaign.date_start < Time.now
			true
		else
			false
		end
	end
	#campagna iniziata?
	def self.terminated?(campaign)
		if campaign.date_end > Time.now
			true
		else
			false
		end
	end

	def self.get_data_for_areachart(campaign)

		data 	= Array.new
		don 	= Array.new
	   	cos 	= Array.new
	   	infDon 	= Array.new
	   	infCos 	= Array.new
	   	inf = Array.new

	   	number_of_column = campaign.donations.count + campaign.costs.count

	   	for k in 0..campaign.donations.order('created_at').count-1
	   		infDon[k] = ["don",campaign.donations[k].created_at,campaign.donations[k].amount,User.find(campaign.donations[k].user_id).firstname]
	   	end

	   	for j in 0..campaign.costs.order('created_at').count-1
	   		infCos[j] = ["cos",campaign.costs[j].created_at,campaign.costs[j].amount,campaign.costs[j].name]
	   	end

	   	inf = infDon + infCos

	   	inf = inf.sort {| a, b | a[1] <=> b[1] }
	   	
	   	tempD = 0
	   	tempC = 0
	   	
	   	for i in 0..inf.count-1

	   		if inf[i][0] == "don"
	   			# è una donazione
	   			tempD = tempD + inf[i][2]
	   			data[i] = [inf[i][1],tempD,inf[i][3],tempC,""]

	   		else
	   			# è un costi
	   			tempC = tempC + inf[i][2]
	   			data[i] = inf[i][1],tempD,"",tempC,inf[i][3]
	   		end
	   	end

	   

	   	for i in 0..data.count-1

	   		data[i][0] = data[i][0].to_s

	   	end

	   	data[data.count] = ["",data[data.count-1][1],"",data[data.count-1][3],""]

	   	p "DATA"

	   	p data

	   	return data

	end


	validate :date_end_cannot_be_less_than_date_start

	def date_end_cannot_be_less_than_date_start
		errors.add(:date_end, ": The campaign must last at least one day.") if 
		date_end == nil  or date_start > date_end or date_end > (12.months.from_now)
	end
	
end
