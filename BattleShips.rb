require "./BattleShips_Method.rb"
include BattleShips_method

#initalize variables and globals..........
c = 9
$shot_at = Array.new(c) {Array.new(c,0)}
$shots = Array.new(c) {Array.new(c,0)}
$comp = Array.new(c) {Array.new(c,0)}
$hit = 0


c = 9
until c == 0 #main quit loop needs c == 0
	#runs title animation
	title_animation

	#runs prep animation
	2.times do
	prep_animation
	end

	screen

	vert = true
	done = false # turns true when ship gets placed

	####### Boat plaement by human

	rowh = 0 #row hold
	colh = 0 #col hold
	done = 0 #flags when loops are complete
	boat = 4 #largest boat size decreases with the smallest being 2


	$error = 0 #error flag 1 = none

	until boat == 1 || c == 0 #Main loop for decrementing boat
			rowh = 0
			colh = 0
			done = 0
			
		until done == 1 || c == 0  #loop checks if a placement was valid and will loop is not (done == 0)
			$error = 0
			screen
			puts "0 = Open spot, 1 = Ship location, X = Miss, * = HIT!"
			say("Place your #{boat} space boat" , "Place vertically or horizontal? Only numbers!" , "(1 = Vertical, 2 = Horizontal, 0 = Quit)")
			#vertical or horizontal placement of ship
			c = gets.chomp.to_i
			if c == 1
				$vert = true
			elsif c == 2
				$vert = false
			elsif c == 0
				break
			else
				wrong
			end

			say("Place your #{boat} space boat" , "Choose which row: Only numbers!" , "(Row 1-9, 0 = Quit)")
			#row placement logic
			c = gets.chomp.to_i
			if c > 0 && c < 10
				rowh = c
			elsif c == 0
				break
			else
				wrong
			end

			say("Place your #{boat} space boat" , "Choose which Column: Only numbers!" , "(Column 1-9, 0 = Quit)")
			#col lacement logic
			c = gets.chomp.to_i
			if c > 0 && c < 10
				colh = c
			elsif c == 0
				break
			else
				wrong
			end

			#places part and can return error of not placeable
			placehuman(boat,rowh,colh, 1)

			if $error == 0
				done = 1
				boat = boat -1
			else 
				wrong
			end
		end
	end
	###### end boat placement by human

	screen #screen update

	#re initializes boat for pc placements
	boat = 4
	x = 0
	#logic for boat plaement by pc
	until boat == 1
		$error = 0
		done = 0
		x = rand(2) #rand t/f for horizontal or vert placement
		if x == 1
			$vert = true
		else
			$vert = false
		end

		#limit placement by pc
		x = rand(7)
		y = rand(7)

		placehuman(boat, x, y, 2)

		if $error == 0
			done = 1
			boat -= 1
		end  ##PC PLACES THEIR BOAT
	end

	screen

	###generate pc ships before this

	## calculates the number of hits needed by human
	moves=0
	compf = $comp.flatten(1)
	moves = compf.count(1)
	

	valid_move = 0

	## calc hits pc needs
	movespc=0
	shot_atf = $shot_at.flatten(1)
	movespc = shot_atf.count(1)
	
	########## Start of battle!!!!
	until moves == 0 || movespc == 0 || c == 0
		$error = 1
		until $error == 0 || c == 0

			rowf = 0
		  	colf = 0

		  	#row col placement for human

		  	puts "X = Miss, * = HIT!"

		  	say("Prepare Your Cannons! Only numbers!" , "Choose the row to attack! (1-9, Q to Quit)" , nil)
		  	
		  	until rowf>0 || c == 0 #logic for valid placments
				c = gets.chomp.to_i
			  	if c >= 1 && c <= 9
				  	rowf = c
				elsif c == 0
					break
				else
					wrong
				end
			end

		  	say("Choose the column to attack! (1-9, Q to Quit) Only numbers!" , nil , nil)

		  	until colf > 0 || c == 0 #llogic for valid placements
			c = gets.chomp.to_i
			  	if c >= 1 && c <= 9
				  	colf = c
				elsif c == 0
					break
				else
					wrong
				end
			end

			attack(rowf, colf, 1) #checks what will happens with move
			if $hit == 1 #validates what will happen
				moves -=1
			end
			screen
			puts moves, movespc
		end
	
	  ## PC move
	  $error = 1
	  until $error == 0 || moves == 0 || movespc == 0
	  	rowrand = 0
	  	colrand = 0
	  	rowrand = rand(1..9) #random row
	  	colrand = rand(1..9) #random col
	  	attack(rowrand,colrand,2) #checks attack
	  	if $hit == 1 #validates what will happen
	  		movespc -=1
	  	end
	  end
	  screen
	end

	if movespc == 0
		lose_animation #runs animation if you lose
	elsif moves == 0
		win_animation#runs animation if you win
	elsif c == 0
		break
	end

	again = false
	until again == true || c == 0
		again_animation # want to play again

		c = gets.chomp.to_i#checks if you want to play again
		if c == 1
			again = true
		elsif c == 0
			break
		else
			wrong
		end
	end


end

puts`clear`

