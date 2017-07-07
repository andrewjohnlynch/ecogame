require 'gosu'
require './food'
require './herbivore'
require './carnivore'
require './game_window'

module ZOrder
  BACKGROUND, FOOD, HERBIVORE, CARNIVORE, MENU, TEXT = *0..5
end

window = GameWindow.new
window.show
