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
     if @role=="cb"
       @code=""
       4.times{@code+=@@code_generator[rand(1..5)]}
     elsif @role=="cm"
       puts "Enter 4 letters for your secret code (g:green, o:orange, b:blue, y:yellow, p:pink)"
       @code=gets.chomp
       while @code.length!=4 do
             puts "Your secret code has to be 4 letters"
             @code=gets.chomp.to_s
           end
     end
     game
   end
 
   def guess
     if @role=="cm"  #Computer guess
       if @close==nil
      4.times{@guess+=@@code_generator[rand(1..5)]}
       else
         @guess=@close
         3.times{@guess+=@@code_generator[rand(1..5)]}
       end
     else
       @guess=gets.chomp.to_s  # User guess
         while @guess.length!=4 do
             puts "Your guess has to be 4 letters"
             @guess=gets.chomp.to_s
           end
   end
   return @guess
 end
 
 
   def game
 
     rounds=1
     c=@code.split("")
     while rounds<=12 do
         puts "Round: #{rounds}"
         @guess=guess
         puts "Your guess is: #{@guess}"
           g=@guess.split("")
             if @guess==@code
               puts "Congratulations you broke the code...#{@code}"
               rounds=13
             else
               for i in 0..3 do
                 if @code.include?(g[i].to_s)
                   if g[i]==c[i]
                     puts "red"
                   else
                     puts "white"
                     @close=g[i]
                   end
                 end
               end
               end
       
       rounds+=1
       puts "I'm sorry you lost...The secret code was: #{@code}" if rounds==13
       @guess=""
       end
 
   end
 
 end
 
 
 play_again=true
 answer=""
 while play_again
   puts "Press 'cb' for CodeBreaker ot 'cm' for CodeMaker"
   role=gets.chomp
   game=Mastermind.new(role)
   puts "You want to play again ? y/n"
   answer=gets.chomp.downcase
   answer=="y" ? play_again=true : play_again=false
 end
 