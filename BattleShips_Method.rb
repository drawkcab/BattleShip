module BattleShips_method

	#General screen display based on what information is in table shot and shots
	def screen
		sleep(1)
	  	puts `clear`
	  	x = 1
	  	headl = ["  ", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
		basel = ["  ", "_", "_", "_", "_", "_", "_", "_", "_", "_"]

	  	puts "  ███████╗██╗  ██╗██╗██████╗ ███████╗"
	  	puts "  ██╔════╝██║  ██║██║██╔══██╗██╔════╝"
	  	puts "  ███████╗███████║██║██████╔╝███████╗"
	  	puts "  ╚════██║██╔══██║██║██╔═══╝ ╚════██║"
	  	puts "  ███████║██║  ██║██║██║     ███████║"
	  	puts "  ╚══════╝╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝"                                         
	  	puts""
	  	puts "0 = Open spot, 1 = Ship location, X = Miss, * = HIT!"
	  	puts headl.join(" ")
	  	puts basel.join("_")
	  	$shot_at.each do |r|
	  		print x.to_s.concat(" |")
	  		puts r.each { |p| p }.join(" ")
	  		x += 1
	  	end
	  	puts " "

	  	x = 1
	  	puts "  ███████╗██╗  ██╗ ██████╗ ████████╗███████╗"
	  	puts "  ██╔════╝██║  ██║██╔═══██╗╚══██╔══╝██╔════╝"
	  	puts "  ███████╗███████║██║   ██║   ██║   ███████╗"
	  	puts "  ╚════██║██╔══██║██║   ██║   ██║   ╚════██║"
	  	puts "  ███████║██║  ██║╚██████╔╝   ██║   ███████║"
	  	puts "  ╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝"  
	  	puts""                                          
	  	puts headl.join(" ")
	  	puts basel.join("_")
	  	$shots.each do |r|
	  		print x.to_s.concat(" |")
	  		puts r.each { |p| p }.join(" ")
	  		x += 1
	  	end
	  	puts "" 

	end

	def wrong
		puts "Invalid entry. Please try again."
	end

	##implicit returns    ##return jumps to total end
	def placehuman(boat, row, col, grid)  
		if grid == 1
			grid = $shot_at
		else
			grid = $comp
		end

		count = 0
		hold = 0
		done = 0
		row = row -1
		col = col -1
		$error = 0
		until  done == 1
			hold = 0
			if $vert == true
				if row + boat > 9
					$error = 1
				else
					boat.times do |x|
						hold = hold + grid[row + x][col]
					end
				end
			else 
				if col + boat > 9
					$error = 1
				else	
					boat.times do |x|
						hold = hold + grid[row][col + x]
					end
				end
			end

			if hold == 0 && $error == 0
				if $vert == true
					boat.times do |x|
						grid[row + x][col] = 1
					end
				else 
					boat.times do |x|
						grid[row][col + x] = 1
					end
				end
				done = 1
			else
				done = 1
				$error =1
			end
		end
	end

	#logic for attacking. see if spot is already used, has ship, or empty and reacts correctly
	def attack (row, col, grid)
		$error = 0
		$hit = 0
		if grid == 1
			grid = $comp
			gridshow = $shots
		else
			grid = $shot_at
			gridshow = $shot_at

		end

		gridshow

		row -=1
		col -=1

		case grid[row][col]
		when 0
			grid[row][col] = "X"
			gridshow[row][col] = "X"

			if grid == $comp
				puts "You missed."
			else
				puts "They missed!"
			end

		when 1
			if grid == $comp
				puts "YOU HIT THEIR SHIP!"
			else
				puts " YOU HAVE BEEN HIT!"
			end
			grid[row][col] = "*"
			gridshow[row][col] = "*"
			$hit = 1
		else
			wrong
			$error = 1
		end
	end

	#say something to display
	def say (one, two, three)
		puts one
		puts two
		puts three
	end

	#win animation
	def win_animation
		3.times do
			puts `clear`
			puts " ██╗   ██╗ ██████╗ ██╗   ██╗"
			puts " ╚██╗ ██╔╝██╔═══██╗██║   ██║"
			puts "  ╚████╔╝ ██║   ██║██║   ██║"
			puts "   ╚██╔╝  ██║   ██║██║   ██║"
			puts "    ██║   ╚██████╔╝╚██████╔╝"
			puts "    ╚═╝    ╚═════╝  ╚═════╝ "
			sleep(2)

			puts `clear`

			puts "  ██╗    ██╗██╗███╗   ██╗"
			puts "  ██║    ██║██║████╗  ██║"
			puts "  ██║ █╗ ██║██║██╔██╗ ██║"
			puts "  ██║███╗██║██║██║╚██╗██║"
			puts "  ╚███╔███╔╝██║██║ ╚████║"
			puts "   ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝"    
			sleep(2)
		end

		puts `clear`
		puts "			             "
		puts "                  "
		puts "               "
		puts "                 "
		puts "               |  "
		puts "               =   "
		puts "              ===                       ._____"
		puts "               |                        |.   |' .--- | "
		puts "               |     _           .--'|  ||   | _|    |"
		puts "               |  .-'|       __  |   |  |    ||      |"
		puts "     .-----.   |  |' |  ||  |  | |   |  |    ||      |"
		puts " ___'       ' / | |  '-.||.    '-'   '-.'    '`      |____"
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		puts "  ~                     ~-~-~-~-~-~-~-~-~-~  /| "
		puts " ~~~~~    )       ~-~-~-~-~-~-~-~ /|~       /_|  "
		puts "        _-H-__   -~-~-~-~-~-~    /_|     -~======-~"
		puts "~-|XXXXXXXXXX/~      ~-~-~-~    /__|_  ~-~-~-~"
		puts "~-~-~-~-~-      ~-~~-~-~-~-~   ========  ~-~-~-~"
		sleep(1)

		puts `clear`
		puts "			                                "
		puts "                   "
		puts "            "
		puts "  "
		puts "      *        |  *                  *"
		puts "            *  =                    *"
		puts "              ===                       ._|___"
		puts "      *        |   *..*         :       |.   |' .--- | "
		puts "        *      |     _           .--'|  ||   | _|    |"
		puts "        *      |  .-'|       __  |   |  |    ||      |"
		puts "     .-----.   |  |' |  ||  |  | |   |  |    ||      |"
		puts " ___'       ' / | |  '-.||.    '-'   '-.'    '`      |____"
		puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		puts " ~                     ~-~-~-~-~-~-~-~-~-~   /| "
		puts "~~~~~     )      ~-~-~-~-~-~-~-~  /|~       /_|  "
		puts "        _-H-__  -~-~-~-~-~-~     /_|     -~======-~"
		puts "~-|XXXXXXXXXX/~     ~-~-~-~     /__|_  ~-~-~-~"
		puts "~-~-~-~-~-~    ~-~~-~-~-~-~    ========  ~-~-~-~"
		sleep(1)

		3.times do

			puts `clear`
			puts "			                         .''.          "
			puts "       .*'.      .        *'**    *_  _*     .             "
			puts "      :_  _:   _ |/_  .:.*_  _*   :    :  .*.:.*.          "
			puts "  .''.:    :    /)    ':'*    *  : '..'.  -=:o:=-"
			puts " :_  _:'.:*:.  | ' *''*    * '.   .'_  /*'.':'.*"
			puts " :    : :::::  =  *_  _*     -= o *- /)     '  *"
			puts "  '.*'  '*::' === *    *     .'/.  .  ' ._____"
			puts "      *        |   *..*         :       |.   |' .--- | "
			puts "        *      |     _           .--'|  ||   | _|    |"
			puts "        *      |  .-'|       __  |   |  |    ||      |"
			puts "     .-----.   |  |' |  ||  |  | |   |  |    ||      |"
			puts " ___'       ' / | |  '-.||.    '-'   '-.'    '`      |____"
			puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			puts "   ~                   ~-~-~-~-~-~-~-~-~-~   /| "
			puts "  ~~~~~   )      ~-~-~-~-~-~-~-~  /|~       /_|  "
			puts "        _-H-__  -~-~-~-~-~-~     /_|     -~======-~"
			puts "~-|XXXXXXXXXX/~     ~-~-~-~     /__|_  ~-~-~-~"
			puts "~-~-~-~-~-~    ~-~~-~-~-~-~    ========  ~-~-~-~"
			sleep(1)
			puts `clear`
			puts "			                         .''.          "
			puts "       .''.      .        *''*    :_  _:     .             "
			puts "      :_  _:   _ |/_  .:.*_  _*   :    :  .'.:.'.          "
			puts "  .''.:    :    /)    ':'*    *  : '..'.  -=:o:=-"
			puts " :_  _:'.:::.  | ' *''*    * '.   .'_  /_'.':'.'"
			puts " :    : :::::  =  *_  _*     -= o =- /)     '  *"
			puts "  '..'  ':::' === *    *     .'/.  .  ' ._____"
			puts "      *        |   *..*         :       |.   |' .--- | "
			puts "        *      |     _           .--'|  ||   | _|    |"
			puts "        *      |  .-'|       __  |   |  |    ||      |"
			puts "     .-----.   |  |' |  ||  |  | |   |  |    ||      |"
			puts " ___'       ' / | |  '-.||.    '-'   '-.'    '`      |____"
			puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
			puts "  ~                    ~-~-~-~-~-~-~-~-~-~   /| "
			puts " ~~~~~    )      ~-~-~-~-~-~-~-~  /|~       /_|  "
			puts "        _-H-__  -~-~-~-~-~-~     /_|     -~======-~"
			puts "~-|XXXXXXXXXX/      ~-~-~-~     /__|_  ~-~-~-~"
			puts "~-~-~-~-~-~    ~-~~-~-~-~-~    ========  ~-~-~-~"
			sleep(1)
		end 
	end

	#lose animation
	def lose_animation
		puts `clear`
		puts "  ██╗   ██╗ ██████╗ ██╗   ██╗      "
		puts "  ╚██╗ ██╔╝██╔═══██╗██║   ██║      "
		puts "   ╚████╔╝ ██║   ██║██║   ██║      "
		puts "    ╚██╔╝  ██║   ██║██║   ██║      "
		puts "     ██║   ╚██████╔╝╚██████╔╝      "
		puts "     ╚═╝    ╚═════╝  ╚═════╝       "
		puts "                                   "
		puts "  ██╗      ██████╗ ███████╗███████╗"
		puts "  ██║     ██╔═══██╗██╔════╝██╔════╝"
		puts "  ██║     ██║   ██║███████╗█████╗  "
		puts "  ██║     ██║   ██║╚════██║██╔══╝  "
		puts "  ███████╗╚██████╔╝███████║███████╗"
		puts "  ╚══════╝ ╚═════╝ ╚══════╝╚══════╝"
		sleep(5)
	end

	#title animation
	def title_animation
		puts `clear`
		puts "      ██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗          " 
		puts "      ██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝          " 
		puts "      ██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗            " 
		puts "      ██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝            " 
		puts "      ╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗          " 
		puts "       ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝          " 
		puts "                                                                              " 
		puts "                          ████████╗ ██████╗                                   " 
		puts "                          ╚══██╔══╝██╔═══██╗                                  " 
		puts "                             ██║   ██║   ██║                                  " 
		puts "                             ██║   ██║   ██║                                  " 
		puts "                             ██║   ╚██████╔╝                                  " 
		puts "                             ╚═╝    ╚═════╝                                   " 
		puts "                                                                              " 
		puts "  ██████╗  █████╗ ████████╗████████╗██╗     ███████╗███████╗██╗  ██╗██╗██████╗ "
		puts "  ██╔══██╗██╔══██╗╚══██╔══╝╚══██╔══╝██║     ██╔════╝██╔════╝██║  ██║██║██╔══██╗"
		puts "  ██████╔╝███████║   ██║      ██║   ██║     █████╗  ███████╗███████║██║██████╔╝"
		puts "  ██╔══██╗██╔══██║   ██║      ██║   ██║     ██╔══╝  ╚════██║██╔══██║██║██╔═══╝ "
		puts "  ██████╔╝██║  ██║   ██║      ██║   ███████╗███████╗███████║██║  ██║██║██║     "
		puts "  ╚═════╝ ╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝   "
		
		sleep(4)
	end

	#prep animation
	def prep_animation

		puts `clear`
		puts " ██████╗ ██████╗ ███████╗██████╗  █████╗ ██████╗ ███████╗"
		puts " ██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝"
		puts " ██████╔╝██████╔╝█████╗  ██████╔╝███████║██████╔╝█████╗  "
		puts " ██╔═══╝ ██╔══██╗██╔══╝  ██╔═══╝ ██╔══██║██╔══██╗██╔══╝  "
		puts " ██║     ██║  ██║███████╗██║     ██║  ██║██║  ██║███████╗"
		puts " ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝"
		sleep(1)
		puts `clear`                                                         
		puts " ███████╗ ██████╗ ██████╗     ██╗    ██╗ █████╗ ██████╗  "
		puts " ██╔════╝██╔═══██╗██╔══██╗    ██║    ██║██╔══██╗██╔══██╗ "
		puts " █████╗  ██║   ██║██████╔╝    ██║ █╗ ██║███████║██████╔╝ "
		puts " ██╔══╝  ██║   ██║██╔══██╗    ██║███╗██║██╔══██║██╔══██╗ "
		puts " ██║     ╚██████╔╝██║  ██║    ╚███╔███╔╝██║  ██║██║  ██║ "
		puts " ╚═╝      ╚═════╝ ╚═╝  ╚═╝     ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝ "
		sleep(1)
	end

	#again animation
	def again_animation
		puts `clear`
		puts "      ██████╗ ██╗      █████╗ ██╗   ██╗         "
		puts "      ██╔══██╗██║     ██╔══██╗╚██╗ ██╔╝         "
		puts "      ██████╔╝██║     ███████║ ╚████╔╝          "
		puts "      ██╔═══╝ ██║     ██╔══██║  ╚██╔╝           "
		puts "      ██║     ███████╗██║  ██║   ██║            "
		puts "      ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝            "
		puts "                                                "
		puts "   █████╗  ██████╗  █████╗ ██╗███╗   ██╗██████╗ "
		puts "  ██╔══██╗██╔════╝ ██╔══██╗██║████╗  ██║╚════██╗"
		puts "  ███████║██║  ███╗███████║██║██╔██╗ ██║  ▄███╔╝"
		puts "  ██╔══██║██║   ██║██╔══██║██║██║╚██╗██║  ▀▀══╝ "
		puts "  ██║  ██║╚██████╔╝██║  ██║██║██║ ╚████║  ██╗   "
		puts "  ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝  ╚═╝  "
		puts "      Press 0 to Quit or 1 to Play Again!"
	end
end