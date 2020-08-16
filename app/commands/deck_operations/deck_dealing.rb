module DeckOperations
	class DeckDealing
		prepend SimpleCommand

		def initialize(params)
			@params = params
		end

		def call			
			deck = ['ka', 'k2', 'k3', 'k4', 'k5', 'k6', 'k7', 'k8', 'k9', 'k10', 'kj', 'kq', 'kk',
					 'ca', 'c2', 'c3', 'c4', 'c5', 'c6', 'c7', 'c8', 'c9', 'c10', 'cj', 'cq', 'ck',
					 'fa', 'f2', 'f3', 'f4', 'f5', 'f6', 'f7', 'f8', 'f9', 'f10', 'fj', 'fq', 'fk',
					 'la', 'l2', 'l3', 'l4', 'l5', 'l6', 'l7', 'l8', 'l9', 'l10', 'lj', 'lq', 'lk']

			if @params[:player].to_i.eql?(5)
		        deck.delete('c2')
		        deck.delete('f2')
		    elsif @params[:player].to_i.eql?(6)		    	
		        deck.delete('c2')
		        deck.delete('l2')
		        deck.delete('f2')
		        deck.delete('k2')
		    end
		    
		    i = 1
		    data = []
		    cards_per_player = (deck.count/@params[:player].to_i)
		    while @params[:player].to_i >= i do
		        player = "player"+i.to_s
		        player = deck.sample(cards_per_player)
		        deck = deck - player
		        pl = "player"+i.to_s
	        	data << { pl => player }
		        i = i + 1		        
		    end
		    return { status: 200, success: true, message: I18n.t('result'), data: data }
		end
	end
end