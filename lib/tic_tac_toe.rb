class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [ 
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 4, 8],
        [2, 4, 6],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8]
    ]

    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
        puts "-----------"
    end
    
    def input_to_index(input)
        index = input.to_i - 1
    end

    def move(index, play_token = "X")
        @board[index] = play_token
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index)
    end

    def turn_count
        @board.count {|space| space == "X" || space == "O"}
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn 
        index = input_to_index(gets.chomp) 
        if valid_move?(index)
            move(index, current_player);
            display_board
        else
         turn
        end
    end

    def won?
        #check if any win combinations are equal to the 3 indexes of the board with the same 
        WIN_COMBINATIONS.any? do |combo|
            if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
                return combo
            else 
                false
            end
          end
    end

    def full?
        #iterate over array @board to check if 'all' the spaces are filled
        @board.all? do |space|
        space != " "
        end
    end

    def draw?
        #if all spaces are full and a player has not(!) won
        full? && !won?
    end

    def over? #returns true if won or draw
        won? || draw?
    end

    def winner #if a combination won, display first value of index in combo
        if combo = won?
            @board[combo[0]]
        end
    end


    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end
end