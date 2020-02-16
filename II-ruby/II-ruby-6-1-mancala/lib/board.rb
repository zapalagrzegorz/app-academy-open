class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { Array.new }
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each { |cup| cup.push(:stone, :stone, :stone, :stone) }
    @cups[6].clear
    @cups[13].clear
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" unless start_pos.between?(0, 12)

    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    turn_cups = begin_move(start_pos)

    until turn_cups.zero?
      start_pos = ((start_pos + 1) % 14)
      if [6, 13].include?(start_pos)
        turn_cups -= 1 if update_score(start_pos, current_player_name)
      else
        cups[start_pos] << :stone
        turn_cups -= 1
      end
    end

    render

    next_turn(start_pos, current_player_name)
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all?(&:empty?) || @cups[7..12].all?(&:empty?)
  end

  def winner
    return :draw if @cups[6] == @cups[13]

    @cups[6].count > @cups[13].count ? @name1 : @name2
  end

  private

  def begin_move(start_pos)
    turn_cups = @cups[start_pos].count
    @cups[start_pos].clear

    turn_cups
  end

  def update_score(start_pos, current_player_name)
    if current_player_name == @name1 && start_pos == 6
      @cups[6] << :stone

      return true
    end

    if current_player_name == @name2 && start_pos == 13
      @cups[13] << :stone

      return true
    end

    nil
  end

  def next_turn(ending_cup_idx, current_player_name)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 && current_player_name == @name1
      return :prompt
    end

    if ending_cup_idx == 13 && current_player_name == @name2
      return :prompt
    end

    if @cups[ending_cup_idx].count == 1
      return :switch
    end

    ending_cup_idx
  end
end
