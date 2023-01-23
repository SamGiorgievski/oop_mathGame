require_relative "question_master"
require_relative "player_info"

class Game
  def initialize()
    @p1 = Player.new('Player 1')
    @p2 = Player.new('Player 2')
    @current_player = @p1
    puts "New game: #{@p1} vs #{@p2}"
  end

  def switch_player
    if @current_player == @p1
      @current_player = @p2
    else
      @current_player = @p1
    end
  end

  def check_answer(answer1, answer2)
    if answer1.to_i == answer2
      puts "Correct :)"
    else 
      @current_player.lives -= 1
      puts "Incorrect :("
    end
  end

  def print_score
    puts "P1: #{@p1.lives}, P2: #{@p2.lives}"
  end

  def check_score(final:false)
    if @p1.lives >= 1 && @p2.lives == 0
      puts "Game over, #{@p1.name} wins!" 
    elsif @p1.lives == 0 && @p2.lives >= 2
      puts "Game over, #{@p2.name} wins!"
    elsif @p1.lives == 0 && @p2.lives == 1 && !final
      puts "Possible draw, one more round!"
      round(final: true)
    elsif @p1.lives == 0 && @p2.lives == 1 && final
      puts "Game over, #{@p2.name} wins!" 
    elsif @p1.lives == 0 && @p2.lives == 0
      puts "It's a draw!"
    else
      round(final: false)
    end
  end

  def round(final: false)
    puts "-----NEW TURN-----"
    question = Question.new

    puts "#{@current_player.name}: #{question.ask_question}"
    answer = gets.chomp
    
    check_answer(answer, question.answer)
    print_score()
    switch_player()
    if !final
      check_score(final:false)
    else
      puts check_score(final:true)
    end
  end

end
