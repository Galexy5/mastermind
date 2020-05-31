class Mastermind
  @@code_generator={1 => "g", #green
         2 =>"b", #blue 
         3 =>"p", #pink
         4 =>"y", #yellow
         5 =>"o" #orange
       }
 
   def initialize (role)
     @guess=""
     @close=nil
     @role=role
     if @role=="1" # CodeBreaker
       @code=""
       4.times{@code+=@@code_generator[rand(1..5)]}
       puts "Colors to choose:\ng=green, o=orange, b=blue, y=yellow, p=pink (format: gopy)"
     elsif @role=="2" # CodeMaker
       print "g=green, o=orange, b=blue, y=yellow, p=pink\nEnter 4 letters for your secret code (format: gopy) : "
       @code=gets.chomp
       @valid=0
       @code.each_char {|x|        # Code must include only the given colors
        @@code_generator.each {|k,v| 
        @valid+=1 if x==v 
        } 
       } 
       while @code.length!=4 || @valid!=4 do  # Code must include only the given colors and 4 letters
            @valid=0
             print "\nInvalid entry !! \nYour secret code has to be 4 letters and include only the given colors\n Try again: "
             @code=gets.chomp.to_s
             @code.each_char {|x|        
              @@code_generator.each {|k,v| 
              @valid+=1 if x==v 
              } 
             } 
           end
     end
     game
   end
 
   def guess
    @valid=0
     if @role=="2"  #Computer guess
       if @close==nil
      4.times{@guess+=@@code_generator[rand(1..5)]}
       else
         @guess=@close
         3.times{@guess+=@@code_generator[rand(1..5)]}
       end
     else
       @guess=gets.chomp.to_s  # User guess
       @guess.each_char {|x|        # Calculate valid so I can check if the guess has only the given colors (valid must be 4)
        @@code_generator.each {|k,v| 
        @valid+=1 if x==v 
        } 
       } 
       while @guess.length!=4 || @valid!=4 do  # Guess must include only the given colors and 4 letters
        @valid=0
         print "\nInvalid entry !! \nYour guess has to be 4 letters and include only the given colors\n Try again: "
         @guess=gets.chomp.to_s
         @guess.each_char {|x|        
          @@code_generator.each {|k,v| 
          @valid+=1 if x==v 
          } 
         } 
       end
   end
   return @guess
 end
 
 
   def game
 
     rounds=1
     c=@code.split("")
     while rounds<=12 do
         print "\nRound #{rounds}: "
         @guess=guess
         puts "\nYour guess is: #{@guess}"
           g=@guess.split("")
             if @guess==@code
               puts "\nCongratulations you broke the code...#{@code}"
               rounds=13
             else
               for i in 0..3 do
                 if @code.include?(g[i].to_s)
                   if g[i]==c[i]
                     puts "Red"
                   else
                     puts "White"
                     @close=g[i]
                   end
                 end
               end
               end
       
       rounds+=1
       puts "\nI'm sorry you lost...The secret code was: #{@code}" if rounds==13
       @guess=""
       end
 
   end
 
 end
 
 
 play_again=true
 answer=""
 while play_again
   puts "\nChoose the role you want:\n 1) CodeBreaker \n 2) CodeMaker"
   role=gets.chomp.to_s
   game=Mastermind.new(role.downcase)
   print "\nYou want to play again ? y/n: "
   answer=gets.chomp.downcase
   answer=="y" ? play_again=true : play_again=false
 end
 