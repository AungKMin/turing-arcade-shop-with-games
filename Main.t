/*
 File: Main.t
 Name: Aung
 Class: ICS2O3
 Date: Dec 20, 2018
 Description: This is the main program. Extras: More complex tax caluclation, credict card validation with check sum algorithm, different options for each product,
 graphics (graphics are all over the program, therefore I did not specify where in the code), animations, user input through mouse-click (user-clicks are present whenever
 Mouse.Where() or button.wait is present). 
 */
 

 /* 
BIG NOTES
Add quantity enter 
Space game is acting weird - the first bullet some times fails to kill a box
*/

% Imports GUI
import GUI

% Declares the constant for the void value
const VOID := "void"

% Declares the variable for whether the program is running or not
var program_running : boolean := true

% Declares the variable for the code currently running
var now_running : string

% Declares the variables to be used for delivery date
var day: int 
var month: int
var year: int
% The number of days in the particular month
var num_days: int 
% Constants for how many days in the months
const JAN := 31
const FEB := 28
const MAR := 31 
const APR := 30 
const MAY := 31
const JUN := 30
const JUL := 31
const AUG := 31
const SEP := 30
const OCT := 31
const NOV := 30 
const DEC := 31
% The day of the delivery
var day_delivery : int
% The month of the delivery
var month_delivery : int
% The month of the delivery date in words
var month_in_words : string
% The year of delivery
var year_delivery : int
% The string for the input of day (so that whether the user entered an appropriate value can be tested)
var day_string : string := VOID
% month 
var month_string : string := VOID
% year 
var year_string : string := VOID

% The delivery dates for each shpping option
var date_premium: string
var date_business: string
var date_eco: string

% Declares the variable for the province the user is in
var province : string

% The tax rates for the provinces
const ALBERTA := 0.05
const BC := 0.12
const MANITOBA := 0.13
const NEW_BRUNSWICK := 0.15
const NEWFOOUNDLAND_AND_LABRADOR := 0.15
const NORTHWEST_TERRITORIES := 0.05
const NOVA_SCOTIA := 0.15
const NUNAVUT := 0.05
const ONTARIO := 0.13
const PEI := 0.15
const QUEBEC := 0.14975
const SASKATCHEWAN := 0.11
const YUKON := 0.05

% Declares the variable for the return values used in individual sub-programs
var return_value : string

% Declares the tax rate that will be used in the program
var tax_rate : real

% Declares a variable for loops to use to determine exit condition, will be changed as fit
var exit_sign : boolean := true

% Declares fonts I will use
var title, semi_title, semi_title_2, semi_title_3, semi_title_4, normal_text, normal_text_description, normal_text_description_italics, selection_box_selected, selection_box_unselected, check_out_font : int
% Initializes those fonts
title := Font.New ("Impact:25:Bold,Italic")
semi_title := Font.New ("Arial:20:Bold")
semi_title_2 := Font.New ("Impact:25:Bold")
semi_title_3 := Font.New ("Arial:15:Bold")
semi_title_4 := Font.New ("Arial:19:Bold")
normal_text := Font.New ("Arial:13")
normal_text_description := Font.New ("Arial:10")
normal_text_description_italics := Font.New("Arial:10:Italic")
selection_box_selected := Font.New ("Arial:10:Italic,Bold")
selection_box_unselected := Font.New ("Arial:10")
check_out_font := Font.New("Arial:17")

% Declares the colors that are used for similar outputs
const COLOR_SELECTION_BOX_SELECTED := 120
const COLOR_SELECTION_BOX_UNSELECTED := 255

% Declares and initializes the import pictures
% Welcome Page
var logo := Pic.FileNew ("Images/logo.jpg")
logo := Pic.Scale (logo, maxx div 1.5, 50)
% White Arcade Machine
var white_machine := Pic.FileNew ("Images/whitemachine.jpg")
white_machine := Pic.Scale (white_machine, 101, 160)
var white_machine_smaller := Pic.Scale (white_machine, 51, 80)
% Brown Arcade Machine
var brown_machine := Pic.FileNew ("Images/brownmachine.jpg")
brown_machine := Pic.Scale (brown_machine, 101, 160)
var brown_machine_smaller := Pic.Scale (brown_machine, 51, 80)

% Declares the variables for mouse input
var mouse_x, mouse_y, mouse_num : int

% Standard time delay for user to read. Also serves as  the time delay amount necessary between transitions between subprograms this is to ensure the mouse input functions of the new subprogram do not pick up input during the transition
const time_delay := 500

% The arrays for the triangle in the arrow of the back button
var polygon_x : array 1..3 of int
polygon_x(1) := 15
polygon_x(2) := 30
polygon_x(3) := 30
var polygon_y : array 1..3 of int
polygon_y(1) := maxy - 40
polygon_y(2) := maxy - 30
polygon_y(3) := maxy - 50

% The arrays for the triangles in the myCart page
var cart_polygon_x : array 1..3 of int
cart_polygon_x(1) := 2
cart_polygon_x(2) := 23
cart_polygon_x(3) := 23
var cart_polygon_y : array 1..3 of int
cart_polygon_y(1) := maxy - 220
cart_polygon_y(2) := maxy - 190
cart_polygon_y(3) := maxy - 250
var cart_polygon_2_x : array 1..3 of int
cart_polygon_2_x(1) := maxx - 2
cart_polygon_2_x(2) := maxx - 23
cart_polygon_2_x(3) := maxx - 23
var cart_polygon_2_y : array 1..3 of int := cart_polygon_y

% The arrays for the triangles in the arrows in the checkout page
% The first arrow
var checkout_polygon_x : array 1..3 of int
checkout_polygon_x(1) := 166
checkout_polygon_x(2) := 160 
checkout_polygon_x(3) := 173
var checkout_polygon_y : array 1..3 of int
checkout_polygon_y(1) := maxy div 2 + 80
checkout_polygon_y(2) := maxy div 2 + 85
checkout_polygon_y(3) := maxy div 2 + 85
% The second arrow
var checkout_polygon_2_x : array 1..3 of int
checkout_polygon_2_x(1) := 303
checkout_polygon_2_x(2) := 297 
checkout_polygon_2_x(3) := 309
var checkout_polygon_2_y : array 1..3 of int
checkout_polygon_2_y(1) := maxy div 2 - 96
checkout_polygon_2_y(2) := maxy div 2 - 92
checkout_polygon_2_y(3) := maxy div 2 - 92

% Declares (and initialize) the variables and constants for the Snake game
% The position of the snake
var x_pos : int := 250
var y_pos : int := 250
% The direction of the snake
var d_x : int := 0
var d_y : int := 0
% The key pressed the user
var key_pressed : string (1)
% The speed of the snake (the less the more since it is the delay time)
const SNAKE_SPEED : int := 8
% The size of the snake
const SNAKE_SIZE : int := 20
% The length of the snake
var snake_length : int
% Whether it is time to spawn food
var spawn_food : boolean
% Whether the game is lost
var game_lost : boolean
% The space between the snake's head and something else to count as a hit
const HIT_SPACE : int := 1
% The position of the food
var food_pos_x : int
var food_pos_y : int
% The radius of the food
const FOOD_RADIUS := 10
% The color of the boundary used to detect collision
const BOUNDARY_COLOR := 235
% Whether the food has been drawn or not
var food_drawn: boolean
% The score
var snake_score: int
% The arrays consisting of the snake's body compartments
var snake_body_x : array 0 .. 10000000 of int 
var snake_body_y : array 0 .. 10000000 of int
% The number of times the subprogram loop has iterated 
var iteration_count: int
% Dictates the amount the snake will grow by everytime it eats
const SNAKE_MULTIPLIER: int := 20

% Declares (and initialize) the variables and constants to be used for the Shapes game
% The width and length of the player square
const SHAPES_PLAYER_SIZE : int := 40 
% Whether the player block should jump or not
var jump : boolean
% For keeping track of whether the player block should keep rising or should it fall wen it reaches the JUMP_LIMIT value
var jump_counter : int
% The extent to which the player can jump to, it is the jump counter's maximum (will no longer jump when it reaches this value)
const JUMP_LIMIT : int := 150
% For keeping track of whether the player block is touching the ground or not in this iteration
var touching_ground : boolean
% The constant version of x position, only used in this game since the x position of the palyer block does not change
const X_POS : int := 100
% The speed of the game
const SHAPES_SPEED : int := 2
% Keeps track of when new shapes should be spawned (counts up)
var spawn_counter : int 
% The value to which the spawn counter will go up to before spawning a shape
var SPAWN_COUNT := 1666
% The height of the rectangle spawned
var rect_height : int
% The width of the rectangle spawned
var rect_width : int
% The maximum height of a rectangle
const MAX_HEIGHT := 100
% The minimum height of a rectangle 
const MIN_HEIGHT := 30
% The maxium width of a rectangle
const MAX_WIDTH := 90
% The minimum width of a rectangle
const MIN_WIDTH := 50
% The x and ypositions of the obstacle
var obstacle_x_pos : int
const OBSTACLE_Y_POS := 76
% The change in x position of the obstacle
var obstacle_d_x : int
% Boolean to track if an obstacle is on the playing board
var obstacle_exists : boolean
% For the second obstacle --
% Keeps track of when new shapes should be spawned (counts up)
var spawn_counter_2 : int
% THe value to which the spawn counter will go up to before spawning a shape
const SPAWN_COUNT_2 :=  1333
% The height of the rectangle spawned
var rect_height_2 : int
% The width of the rectangle spawned
var rect_width_2 : int
% The x position of the obstacle
var obstacle_x_pos_2 : int
% The change in x position of the obstacle
var obstacle_d_x_2 : int
% Boolean to track if an obstacle is on the playing board
var obstacle_exists_2 : boolean
% Obstacle 3 --
% Keeps track of when new shapes should be spawned (counts up)
var spawn_counter_3 : int
% THe value to which the spawn counter will go up to before spawning a shape
const SPAWN_COUNT_3 :=  2000
% The height of the rectangle spawned
var tri_height_3 : int
% The width of the rectangle spawned
var tri_width_3 : int
% The x position of the obstacle
var obstacle_x_pos_3 : int
% The change in x position of the obstacle
var obstacle_d_x_3 : int
% Boolean to track if an obstacle is on the playing board
var obstacle_exists_3 : boolean
% Arrays to draw the triangle
var obstacle_3_x_points : array 1 .. 3 of int
var obstacle_3_y_points : array 1 .. 3 of int
% Gives values to all points in the triangle array so that there wouldn't be a no value exception
obstacle_3_x_points (1) := -1
obstacle_3_x_points (2) := -1
obstacle_3_x_points (3) := -1
obstacle_3_y_points (1) := -1
obstacle_3_y_points (2) := -1
obstacle_3_y_points (3) := -1  
% The score
var shapes_score : int

% Declares (and initializes) the variables and constants to be used in gameSpace
% The score
var space_score : int
% The arrays to draw the player (triangle)
var space_player_x_points : array 1 .. 3 of int
var space_player_y_points : array 1 .. 3 of int
% The constant for the y position (it does not move in the y direction)
const Y_POS := 51
% The constant for the player's size
% horizontal length
const SPACE_PLAYER_SIZE_X := 25
% vertical length
const SPACE_PLAYER_SIZE_Y := 25
% Sets the speed of the game by delaying time 
const SPACE_SPEED := 8
% To shoot
var space_shoot : boolean
% The bullet's length
const BULLET_LENGTH := 30
% Tracks if bullet 1 is on the screen
var bullet_1_exists : boolean
% The x position of bullet 1
var bullet_1_x_pos : int
% The y position of bullet 1
var bullet_1_y_pos : int
% The velocity of bullet 1
var bullet_1_d_y : int
% Tracks if bullet 2 is on the screen
var bullet_2_exists : boolean
% The x position of bullet 2
var bullet_2_x_pos : int
% The y position of bullet 2
var bullet_2_y_pos : int
% The velocity of bullet 2
var bullet_2_d_y : int
% The size of the enemies 
var SPACE_ENEMY_SIZE := 50
% Tracks if enemy 1 is on the screen
var enemy_1_exists : boolean
% The x position of enemy 1
var enemy_1_x_pos : int 
% The y position of enemy 1
var enemy_1_y_pos : int
% The velocity of the enemy
var enemy_1_d_y : int
% Determines on which iterations the enemy would drop
const SPACE_SPAWN_COUNT := 1000
% Enemy 2 --
% Tracks if enemy 2 is on the screen
var enemy_2_exists : boolean
% The x position of enemy 2
var enemy_2_x_pos : int 
% The y position of enemy 2
var enemy_2_y_pos : int
% The velocity of the enemy
var enemy_2_d_y : int
% Determines on which iterations the enemy would drop
const SPACE_SPAWN_COUNT_2 := 1333

% Declares (and initializes) the variables and constants that will be used in game Thief 
% Speed of the game
const THIEF_SPEED := 5
% The size of the thief player
const THIEF_SIZE := 25
% The position of the variables
var thief_x_pos : int
var thief_y_pos : int
% The number of levels the game has
const THIEF_NUM_LEVELS := 3
% The level the player is on
var thief_level : int
% The position of the cop, note that the cop does not move
const COP_X_POS := 73
const COP_Y_POS := 256
% The size of the cop
const COP_SIZE := 25
% The arrays of points for the triangles that will be used to represent the cop's view
const VIEW_1_X : array 1 .. 3 of int := init(COP_X_POS, 152, 302)
const VIEW_1_Y : array 1 .. 3 of int := init(COP_Y_POS, 151, 151)
const VIEW_2_X : array 1 .. 3 of int := init(COP_X_POS, 638, 638)
const VIEW_2_Y : array 1 .. 3 of int := init(COP_Y_POS, 30, 141)
const VIEW_3_X : array 1 .. 3 of int := init(COP_X_POS, 638, 638)
const VIEW_3_Y : array 1 .. 3 of int := init(COP_Y_POS, 255, 310)
const VIEW_4_X : array 1 .. 3 of int := init(COP_X_POS, 320, 550)
const VIEW_4_Y : array 1 .. 3 of int := init(COP_Y_POS, 328, 328)
const VIEW_5_X : array 1 .. 3 of int := init(COP_X_POS, 2, 142)
const VIEW_5_Y : array 1 .. 3 of int := init(COP_Y_POS, 328, 328)
const VIEW_6_X : array 1 .. 3 of int := init(COP_X_POS, 2, 142)
const VIEW_6_Y : array 1 .. 3 of int := init(COP_Y_POS, 151, 151)
% The counter of the rotating view for each level, determines how fast the view will be rotating each level
const LV_1_COUNT := 350
const LV_2_COUNT := 300
const LV_3_COUNT := 290
% The color of the light view
const LIGHT_COLOR := 55
% Keeps track of when to draw new view cones
var view_counter : int

% Declares the variables for the product pages
% Whether the color chosen for the machine is brown or white
var color_chosen: string
% How many items the user has chosen on that page
var num_items_chosen : int
% What item is being confirmed right now
var item_confirm: string

% Declares the variables to be used within myCart
% The number of differnt items that will be displayed in the cart
var num_different_items : int
% The current page number to be used when assigning values to arrays and in keeping track of which page the user is viewing in cart
var current_page_number : int
% The current page position (1 or 2) to be used when assigning values to the color_items_pages array and the game_title_items_pages array
var current_page_position : int
% The number of different items in each page (1 or 2)
var num_different_items_pages : array 1 .. 4 of int
% the color of the items that will be displayed in the cart (2 for each page and there are 4 pages)
var color_items_pages : array 1 .. 4 of array 1 .. 2 of string
% the game title that will be displayed in the cart (2 for each page and there are 4 pages)
var game_title_items_pages : array 1 .. 4 of array 1 .. 2 of string

% Declares the variables and constants to be used within checkout
% A counter to keep track of which spot on the summary is taken
var summary_spot: int
% The total cost before tax 
var total_cost: real
% The cost of shipping
var shipping_cost: int
% The cost with tax
var total_cost_with_tax: real
% The total number of items
var total_num_items: int
% The new window to display the summary box
var summary_box : int := 0
% The shipping method
var shipping_method : string := VOID
% The customer's address
var address : string := VOID
% The constants for the shipping method costs
const PREMIUM : int := 25
const BUSINESS : int := 15
const ECO : int := 5
% The credit card method 
var card_method : string := VOID
% Whether the customer has entered valid credit card or not
var card_checked : boolean := false

% Declares the variables to be used in cardConfirmation
% The name on the card
var name : string := VOID
% The card number (divided into two because turing can't handle big integers)
var card_number_1, card_number_2 : int := 0
% The string value of the card number 1 and 2 so that whether the user enters an appropriate value can be tested
var card_number_1_string, card_number_2_string : string := VOID
% The pin number
var pin_number : int := -1
% String value of pin
var pin_number_string : string := VOID
% The expirary date
var expirary_date : string := VOID
% The number of digits in the first half of the credit card number
var number_of_digits : int
% The number of digits in the second half of the credit card number note that this is necessary instead of continuing to use the previous variable due to integer overflow
var number_of_digits_2 : int
% The current digit 
var the_digit : int
% The array of individual digits of the credit card number represented as integers
var card_numbers_array : array 1 .. 16 of int
% The sum of the digits of the credit card, this is necessary in the luhn algorithm
var digit_sum : int
% A variable for the weight multiplier to be used in the luhn algorithm
var luhn_weight : int
  
% Declares the variables to be used within cartConfirmation
% Whether to add or not to add the item to cart
var do_add: boolean

% Declares the variables for payPage
% Amount payed by user
var amount_payed : real := 0
% Amount payed as a string 
var amount_payed_string : string := VOID
% Amount that is left
var amount_left : real
% Counter for where the new line should be on payPage
var payPage_counter : int

% The number of items for the products
var item_snake_white : int := 0
var item_snake_brown : int := 0
var item_shapes_white : int := 0
var item_shapes_brown : int := 0
var item_space_white : int := 0
var item_space_brown : int := 0
var item_thief_white : int := 0
var item_thief_brown : int := 0

% Declares header of the functions 
% The game samples
forward function gameSnake : string
forward function gameShapes : string
forward function gameSpace : string
forward function gameThief : string
% The pages for each game machine 
forward function pageSnake : string
forward function pageShapes : string
forward function pageSpace : string
forward function pageThief : string
% Goes to cart, where all the items added is listed and user can add more or remove
forward function myCart : string 
% Goes to checkout, where the user chooses shipping and paying options
forward function checkout : string
% Goes to cart confirmation where the user is asked to confirm if they meant to add an item to the cart
forward function cartConfirmation : string
% Goes to order confirmation where the user is asked to confirm if they meant to order their order
forward function orderConfirmation : string
% Goes to card information page where the user is asked for the card number and such 
forward function cardInformation : string
% Goes to the page where the user pays
forward function payPage : string
% Exits the program, while displaying a goodbye message
forward procedure exitPage


% The function for the welcome page
function welcome : string

    cls
    % Resets the return values and the mouse values to void
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1

    % The background
    Draw.FillBox (0, 0, maxx, maxy, 15)
    % The logo
    Draw.Text ("Welcome To", maxx div 2 - 85, maxy - 50, title, 255)
    Pic.Draw (logo, maxx div 6, maxy - 110, 0)
    Draw.FillBox (maxx div 4.1, 0, maxx - maxx div 4.1, maxy div 1.5, 16)
    % Snake
    Draw.FillBox (maxx div 2 - 50, maxy div 1.5 - 50, maxx div 2 - 50 + 100, maxy div 1.5 - 50 + 30, 2)
    Draw.Text ("Snake", maxx div 2 - 40, maxy div 1.5 - 45, semi_title, 94)
    % Shapes
    Draw.FillBox (maxx div 2 - 60, maxy div 1.5 - 95, maxx div 2 - 60 + 115, maxy div 1.5 - 95 + 30, 42)
    Draw.Text ("Shapes", maxx div 2 - 50, maxy div 1.5 - 90, semi_title, 94)
    % Space
    Draw.FillBox (maxx div 2 - 110, maxy div 1.5 - 140, maxx div 2 - 110 + 215, maxy div 1.5 - 140 + 30, 57)
    Draw.Text ("Space Defense", maxx div 2 - 100, maxy div 1.5 - 135, semi_title, 94)
    % Thief
    Draw.FillBox (maxx div 2 - 45, maxy div 1.5 - 185, maxx div 2 - 45 + 90, maxy div 1.5 - 185 + 30, 15)
    Draw.Text ("Thief", maxx div 2 - 35, maxy div 1.5 - 180, semi_title, 94)
    % Exit 
    Draw.FillBox (maxx div 2 - 30, maxy div 1.5 - 230, maxx div 2 - 30 + 60, maxy div 1.5 - 230 + 30, 40)
    Draw.Text ("Exit", maxx div 2 - 25, maxy div 1.5 - 225, semi_title, 94)
    % My Cart
    Draw.FillBox (maxx - 85, maxy - 55, maxx - 15, maxy - 15, yellow)
    Draw.Text ("My Cart", maxx - 80, maxy - 40, normal_text, 255)

    % Assigns the return value to void so that the loop does not exit prematurely
    return_value := VOID
    loop
	Mouse.Where(mouse_x, mouse_y, mouse_num)
	% Determine if the user clicks a button and if he/she did, which button
	if (((mouse_x >= maxx div 2 - 50 and mouse_x <= maxx div 2 - 50 + 100) and (mouse_y >= maxy div 1.5 - 50 and mouse_y <= maxy div 1.5 - 50 + 30)) and mouse_num = 1) then
	    % Sets the return value to the subprogram that the button the user clicked on corresponds to
	    return_value := "gameSnake"
	% Shapes
	elsif (((mouse_x >= maxx div 2 - 60 and mouse_x <= maxx div 2 - 60 + 115) and (mouse_y >= maxy div 1.5 - 95 and mouse_y <= maxy div 1.5 - 95 + 30)) and mouse_num = 1) then
	    return_value := "gameShapes"
	% Space Defense
	elsif (((mouse_x >= maxx div 2 - 110 and mouse_x <= maxx div 2 - 110 + 215) and (mouse_y >= maxy div 1.5 - 140 and mouse_y <= maxy div 1.5 - 140 + 30)) and mouse_num = 1) then
	    return_value := "gameSpace"
	% Thief
	elsif (((mouse_x >= maxx div 2 - 45 and mouse_x <= maxx div 2 - 45 + 90) and (mouse_y >= maxy div 1.5 - 185 and mouse_y <= maxy div 1.5 - 185 + 30)) and mouse_num = 1) then
	    return_value := "gameThief"
	% Exit page
	elsif (((mouse_x >= maxx div 2 - 30 and mouse_x <= maxx div 2 - 30 + 60) and (mouse_y >= maxy div 1.5 - 230 and mouse_y <= maxy div 1.5 - 230 + 30)) and mouse_num = 1) then
	    return_value := "exitPage"
	% My Cart
	elsif (((mouse_x >= maxx - 85 and mouse_x <= maxx - 15) and (mouse_y >= maxy - 55 and mouse_y <= maxy - 15)) and mouse_num = 1) then
	     return_value := "myCart"
	end if
	exit when return_value not= "void"
    end loop

    result return_value
end welcome

% Includes animations 
% The game page for the game Snake
body function gameSnake

    cls
    % Resets the return values and the mouse values to void
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1

    % Resets the game's variables to default
    x_pos := 250
    y_pos := 250
    d_x := 0
    d_y := 0
    key_pressed := ""
    snake_length := 3
    spawn_food := false
    game_lost := false
    food_drawn := false
    snake_score := 0 
    iteration_count := 0
    
    Draw.Text("This is a sample of the arcade game.", maxx div 2 - 100, maxy div 2 + 25, normal_text, 255)
    Draw.Text("Use the arrow keys to collect food and don't crash into a wall or your own body.", maxx div 2 - 280, maxy div 2, normal_text, 255) 
    Time.Delay (time_delay + 3000)

    % Background
    Draw.FillBox (0, 0, maxx, maxy, 15)
    % Draws the boundary
    Draw.Box (0, 37, maxx, maxy - 70, BOUNDARY_COLOR)
    % Draws the buy this game button
    Draw.FillBox (maxx - 115, maxy - 55, maxx - 5, maxy - 15, 11)
    Draw.Text ("Buy this game", maxx - 110, maxy - 40, normal_text, 255)
    % Draws the back button
    Draw.FillOval (40, maxy - 40, 25, 25, white)
    Draw.FillBox (30, maxy - 45, 60, maxy - 35, 49)
    Draw.FillPolygon (polygon_x, polygon_y, 3, 49)
    Draw.Line(55, maxy - 45, 55, maxy - 35, 247)
    Draw.FillBox(57, maxy - 45, 60, maxy - 35, 247)
    % Write Snake
    Draw.Text("Snake", maxx div 2 - 50, maxy - 45, semi_title, 255)
    % Draw the exit button
    Draw.FillBox(maxx - 85, 15, maxx - 5, 35, 40)
    Draw.Text("Exit page", maxx - 80, 20, normal_text, 255)
    
    % Spawns a food
    randint (food_pos_x, 10, maxx - 10)
    randint (food_pos_y, 50, maxy - 80)
    Draw.FillOval (food_pos_x, food_pos_y, FOOD_RADIUS, FOOD_RADIUS, red)

    % Main subprogram loop
    loop
    
	% Checks if it is time to spawn food and if it is spawns it at a random location
	if (spawn_food = true) then
	    % Gets rid of the previous food
	    Draw.FillOval (food_pos_x, food_pos_y, FOOD_RADIUS, FOOD_RADIUS, 15)
	    loop
		% Generate two random coordinates
		randint (food_pos_x, 10, maxx - 10)
		randint (food_pos_y, 50, maxy - 80)
		% If the food is not too close to the snakes body, drawa it, if it is, try again
		if (whatdotcolor(food_pos_x, food_pos_y) not= green and whatdotcolor(food_pos_x + 10, food_pos_y) not= green and whatdotcolor(food_pos_x - 10, food_pos_y) not= green and whatdotcolor(food_pos_x, food_pos_y + 10) not= green and whatdotcolor(food_pos_y, food_pos_y - 10) not= green) then
		    % Draw the food
		    Draw.FillOval (food_pos_x, food_pos_y, FOOD_RADIUS, FOOD_RADIUS, red)
		    food_drawn := true
		end if
		exit when food_drawn
	    end loop
	    % Set food to not spawned yet, not drawn yet, and increases score by 1
	    spawn_food := false 
	    food_drawn := false
	    snake_score += 1 
	end if

	% Checks if the user has hit anything
	% It hit itself while going left
	if (d_x = -1 and (whatdotcolor (x_pos - HIT_SPACE, y_pos) = green or whatdotcolor (x_pos - HIT_SPACE, y_pos + SNAKE_SIZE div 2) = green or whatdotcolor (x_pos - HIT_SPACE, y_pos + SNAKE_SIZE) = green)) then
	    game_lost := true
	% while going down
	elsif (d_y = -1 and (whatdotcolor (x_pos, y_pos - HIT_SPACE) = green or whatdotcolor (x_pos + SNAKE_SIZE div 2, y_pos - HIT_SPACE) = green or whatdotcolor (x_pos + SNAKE_SIZE, y_pos - HIT_SPACE) = green)) then
	    game_lost := true
	% while going up 
	elsif (d_y = 1 and (whatdotcolor (x_pos, y_pos + SNAKE_SIZE + HIT_SPACE) = green or whatdotcolor (x_pos + SNAKE_SIZE div 2, y_pos + SNAKE_SIZE + HIT_SPACE) = green or whatdotcolor (x_pos + SNAKE_SIZE, y_pos + SNAKE_SIZE + HIT_SPACE) = green)) then
	    game_lost := true
	% while going right
	elsif (d_x = 1 and (whatdotcolor (x_pos + SNAKE_SIZE + HIT_SPACE, y_pos) = green or whatdotcolor (x_pos + SNAKE_SIZE + HIT_SPACE, y_pos + SNAKE_SIZE div 2) = green or whatdotcolor (x_pos + SNAKE_SIZE + HIT_SPACE, y_pos + SNAKE_SIZE) = green)) then
	    game_lost := true
	% It hit a wall while going left
	elsif (d_x = -1 and whatdotcolor (x_pos - HIT_SPACE, y_pos) = BOUNDARY_COLOR) then
	    game_lost := true
	% while going down
	elsif (d_y = -1 and whatdotcolor (x_pos, y_pos - HIT_SPACE) = BOUNDARY_COLOR) then
	    game_lost := true
	% while going up 
	elsif (d_y = 1 and whatdotcolor (x_pos, y_pos + SNAKE_SIZE + HIT_SPACE) = BOUNDARY_COLOR) then
	    game_lost := true
	% while going right
	elsif (d_x = 1 and whatdotcolor (x_pos + SNAKE_SIZE + HIT_SPACE, y_pos) = BOUNDARY_COLOR) then
	    game_lost := true
	% It got an apple while going left 
	elsif (d_x = -1 and (whatdotcolor (x_pos - HIT_SPACE, y_pos) = red or whatdotcolor (x_pos - HIT_SPACE, y_pos + SNAKE_SIZE div 2) = red or whatdotcolor (x_pos - HIT_SPACE, y_pos + SNAKE_SIZE) = red)) then
	    spawn_food := true
	% while going down 
	elsif (d_y = -1 and (whatdotcolor (x_pos, y_pos - HIT_SPACE) = red or whatdotcolor (x_pos + SNAKE_SIZE div 2, y_pos - HIT_SPACE) = red or whatdotcolor (x_pos + SNAKE_SIZE, y_pos - HIT_SPACE) = red)) then
	    spawn_food := true
	% while going up 
	elsif (d_y = 1 and (whatdotcolor (x_pos, y_pos + SNAKE_SIZE + HIT_SPACE) = red or whatdotcolor (x_pos + SNAKE_SIZE div 2, y_pos + SNAKE_SIZE + HIT_SPACE) = red or whatdotcolor (x_pos + SNAKE_SIZE, y_pos + SNAKE_SIZE + HIT_SPACE) = red)) then
	    spawn_food := true
	% while going right
	elsif (d_x = 1 and (whatdotcolor (x_pos + SNAKE_SIZE + HIT_SPACE, y_pos) = red or whatdotcolor (x_pos + SNAKE_SIZE + HIT_SPACE, y_pos + SNAKE_SIZE div 2) = red or whatdotcolor (x_pos + SNAKE_SIZE + HIT_SPACE, y_pos + SNAKE_SIZE) = red)) then
	    spawn_food := true
	end if

	% If the game is lost, restart the game
	if (game_lost or iteration_count = 10000000) then
	    % Make the snake's eyes white; draw two white eyes depending on which way the snake is facing
	    if (d_x = -1) then
		Draw.FillBox (x_pos + 2, y_pos + 2, x_pos + 4, y_pos + 4, 100)
		Draw.FillBox (x_pos + 2, y_pos + SNAKE_SIZE - 2, x_pos + 4, y_pos + SNAKE_SIZE - 4, 100)
	    elsif (d_y = -1) then
		Draw.FillBox (x_pos + 2, y_pos + 2, x_pos + 4, y_pos + 4, white)
		Draw.FillBox (x_pos + SNAKE_SIZE - 2, y_pos + 2, x_pos + SNAKE_SIZE - 4, y_pos + 4, 100)
	    elsif (d_y = 1) then
		Draw.FillBox (x_pos + 2, y_pos + SNAKE_SIZE - 4, x_pos + 4, y_pos + SNAKE_SIZE - 2, 100)
		Draw.FillBox (x_pos + SNAKE_SIZE - 4, y_pos + SNAKE_SIZE - 4, x_pos + SNAKE_SIZE - 2, y_pos + SNAKE_SIZE - 2, 100)
	    elsif (d_x = 1) then
		Draw.FillBox (x_pos + SNAKE_SIZE - 4, y_pos + 2, x_pos + SNAKE_SIZE - 2, y_pos + 4, 100)
		Draw.FillBox (x_pos + SNAKE_SIZE - 4, y_pos + SNAKE_SIZE - 4, x_pos + SNAKE_SIZE - 2, y_pos + SNAKE_SIZE - 2, 100)
	    end if
	    % If the user lost because they took too long and the snake body array cannot hold any more values, tell them that 
	    if (iteration_count = 10000000) then
		Draw.Text("You took too long!", maxx div 2 - 200, maxy div 2, normal_text, 255) 
	    end if
	    % Gives the user a second to realize they lost
	    Time.Delay(1000)
	    % Make the return value into this snake game so that it will restart
	    return_value := "gameSnake"
	end if

	% Checks if the user has pressed a key
	if hasch then
	    getch (key_pressed)

	    % Checks what the key is and changes the direction of the snake correspondingly
	    % left
	    if (key_pressed = chr (203) or key_pressed = 'a') then
		d_x := -1
		d_y := 0
	    % down
	    elsif (key_pressed = chr (208) or key_pressed = 's') then
		d_x := 0
		d_y := -1
	    % up
	    elsif (key_pressed = chr (200) or key_pressed = 'w') then
		d_x := 0
		d_y := 1
	    % right
	    elsif (key_pressed = chr (205) or key_pressed = 'd') then
		d_x := 1
		d_y := 0
	    end if

	    % Sets the key pressed back to nothing
	    key_pressed := ""

	end if

	% Applies the direction change to the position of the snake
	x_pos := x_pos + d_x 
	y_pos := y_pos + d_y 
	
	% Draws the new position of the snake
	% Draws the snake's eyes the selection is for which way the snake is facing
	% Facing left
	if (d_x = -1) then
	    Draw.FillBox (x_pos + 2, y_pos + 2, x_pos + 4, y_pos + 4, red)
	    Draw.FillBox (x_pos + 2, y_pos + SNAKE_SIZE - 2, x_pos + 4, y_pos + SNAKE_SIZE - 4, red)
	% Facing down
	elsif (d_y = -1) then
	    Draw.FillBox (x_pos + 2, y_pos + 2, x_pos + 4, y_pos + 4, red)
	    Draw.FillBox (x_pos + SNAKE_SIZE - 2, y_pos + 2, x_pos + SNAKE_SIZE - 4, y_pos + 4, red)
	% Facing up 
	elsif (d_y = 1) then
	    Draw.FillBox (x_pos + 2, y_pos + SNAKE_SIZE - 4, x_pos + 4, y_pos + SNAKE_SIZE - 2, red)
	    Draw.FillBox (x_pos + SNAKE_SIZE - 4, y_pos + SNAKE_SIZE - 4, x_pos + SNAKE_SIZE - 2, y_pos + SNAKE_SIZE - 2, red)
	% Facing right
	elsif (d_x = 1) then
	    Draw.FillBox (x_pos + SNAKE_SIZE - 4, y_pos + 2, x_pos + SNAKE_SIZE - 2, y_pos + 4, red)
	    Draw.FillBox (x_pos + SNAKE_SIZE - 4, y_pos + SNAKE_SIZE - 4, x_pos + SNAKE_SIZE - 2, y_pos + SNAKE_SIZE - 2, red)
	end if 
   
	% Sets the snake's speed of the game by delaying the time between every time the rectangles are drawn
	Time.Delay (SNAKE_SPEED)
	Draw.FillBox (x_pos, y_pos, x_pos + SNAKE_SIZE, y_pos + SNAKE_SIZE, green)

	% Adds the current position of the snake to the array
	snake_body_x(iteration_count) := x_pos
	snake_body_y(iteration_count) := y_pos 
	% Erases the tail of the snake
	Draw.FillBox(snake_body_x(iteration_count - snake_score * SNAKE_MULTIPLIER), snake_body_y(iteration_count - snake_score * SNAKE_MULTIPLIER), snake_body_x(iteration_count - snake_score * SNAKE_MULTIPLIER) + SNAKE_SIZE, snake_body_y(iteration_count - snake_score * SNAKE_MULTIPLIER) + SNAKE_SIZE, 15)
	% Increases the iteration count by 1
	iteration_count += 1

	% Listen for mouse clicks, if it is one of the buttons, redirect to that page
	Mouse.Where (mouse_x, mouse_y, mouse_num)
	% buy game 
	if (((mouse_x >= maxx - 115 and mouse_x <= maxx - 5) and (mouse_y >= maxy - 55 and mouse_y <= maxy - 15)) and mouse_num = 1) then
	    return_value := "pageSnake"
	% exit page
	elsif (((mouse_x >= maxx - 85 and mouse_x <= maxx - 5) and (mouse_y >= 15 and mouse_y <= 35)) and mouse_num = 1) then
	    return_value := "exitPage"
	% back button
	elsif ((whatdotcolor(mouse_x, mouse_y) = 49 or whatdotcolor(mouse_x, mouse_y) = white or whatdotcolor(mouse_x, mouse_y) = 247) and mouse_num = 1) then 
	    return_value := "welcome"
	end if
	
	% Checks if the user has clicked on a button and if she has, exit the subprogram
	exit when return_value not= VOID
	
    end loop

    % Displays the player's score
    cls 
    Draw.Text("Your score is", maxx div 2 - 50, maxy div 2 + 50, normal_text, 255)
    Draw.Text(intstr(snake_score), maxx div 2 - 5, maxy div 2, semi_title_2, 255)
    Time.Delay (time_delay + 2000)

    % Returns the next subprogram that should be run
    result return_value

end gameSnake

% Includes animations 
% The game page for the game Shapes
body function gameShapes

    cls
    % Resets the return value to void and the mouse integer values to -1
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1
    
    % Resets the values of variables used in this subprogram 
    % Note that some are reused in multiple games
    y_pos := 76
    key_pressed := ""
    jump := false
    jump_counter := 0
    spawn_counter := 0
    obstacle_x_pos := maxx - 50
    obstacle_d_x := 0
    obstacle_exists := false
    spawn_counter_2 := 0
    obstacle_x_pos_2 := maxx - 50
    obstacle_d_x_2 := 0
    obstacle_exists_2 := false
    spawn_counter_3 := 0
    obstacle_x_pos_3 := maxx - 50
    obstacle_d_x_3 := 0
    obstacle_exists_3 := false
    shapes_score := 0
    
    % Tell the user what the game is about
    Draw.Text("This is a sample of the arcade game.", maxx div 2 - 100, maxy div 2 + 25, normal_text, 255)
    Draw.Text("Use the up arrow key or spacebar to jump and don't crash into the red shapes.", maxx div 2 - 270, maxy div 2, normal_text, 255) 
    % Gives the user time to read it
    Time.Delay (time_delay + 3000)

    % Draws the graphics before the main loop begins
    % Background
    Draw.FillBox (0, 0, maxx, maxy, 15)
    % Draws the boundary
    Draw.Box (0, 0, maxx, maxy, BOUNDARY_COLOR)
    % Draws the buy this game button
    Draw.FillBox (maxx - 115, maxy - 55, maxx - 5, maxy - 15, 11)
    Draw.Text ("Buy this game", maxx - 110, maxy - 40, normal_text, 255)
    % Draws the back button
    Draw.FillOval (40, maxy - 40, 25, 25, white)
    Draw.FillBox (30, maxy - 45, 60, maxy - 35, 49)
    Draw.FillPolygon (polygon_x, polygon_y, 3, 49)
    Draw.Line(55, maxy - 45, 55, maxy - 35, 247)
    Draw.FillBox(57, maxy - 45, 60, maxy - 35, 247)
    % Write Shapes
    Draw.Text("Shapes", maxx div 2 - 50, maxy - 45, semi_title, 255)
    % Draw the ground
    Draw.FillBox(0, 0, maxx, 75, 7)
    % Draw the exit button
    Draw.FillBox(maxx - 85, 15, maxx - 5, 35, 40)
    Draw.Text("Exit page", maxx - 80, 20, normal_text, 255)
    % Draw the player block
    Draw.FillBox(X_POS, y_pos, X_POS + SHAPES_PLAYER_SIZE, y_pos + SHAPES_PLAYER_SIZE, 11)

    
    % Main subprogram loop
    loop
    
	% Sets the speed of the game by delaying the time between each iteration of the loop
	Time.Delay(SHAPES_SPEED)
	% Resets the player velocity
	d_y := 0
	
	% The first obstacle -- 
	
	% Checks if the obstacle has dissapeared
	if (whatdotcolor(obstacle_x_pos - 1, OBSTACLE_Y_POS) = BOUNDARY_COLOR) then 
	    % Erase the obstacle
	    Draw.FillBox(obstacle_x_pos, OBSTACLE_Y_POS, obstacle_x_pos + rect_width, OBSTACLE_Y_POS + rect_height, 15)
	    % Obstacle no longer exists
	    obstacle_exists := false
	    % reset the x position of the obstacle
	    obstacle_x_pos := maxx - 50
	end if  
	
	% Spawns enemy shapes
	if (spawn_counter = SPAWN_COUNT) then 
	    % Increase the score by 1 
	    shapes_score += 1
	    % Generate a random number for the rectangle's height and width within the range
	    randint(rect_height, MIN_HEIGHT, MAX_HEIGHT)
	    randint(rect_width, MIN_WIDTH, MAX_WIDTH)
	    % Draw the rectangle
	    Draw.FillBox(obstacle_x_pos, OBSTACLE_Y_POS, maxx - 50 + rect_width, OBSTACLE_Y_POS + rect_height, red)
	    Draw.Box(obstacle_x_pos, OBSTACLE_Y_POS, maxx - 50 + rect_width, OBSTACLE_Y_POS + rect_height, 7)
	    spawn_counter := 0
	    obstacle_exists := true
	else
	    spawn_counter += 1
	end if
	
	% If the obstacle exists then move it
	if (obstacle_exists = true) then
	    % Update the position of the obstacle
	    obstacle_d_x := -1
	
	    % Update the shape position
	    obstacle_x_pos := obstacle_x_pos + obstacle_d_x
	
	    % Move the shape forward
	    % Erase the previous position
	    Draw.FillBox(obstacle_x_pos - obstacle_d_x, OBSTACLE_Y_POS, obstacle_x_pos - obstacle_d_x + rect_width, OBSTACLE_Y_POS + rect_height, 15)
	    % Draw the new position
	    Draw.FillBox(obstacle_x_pos, OBSTACLE_Y_POS, obstacle_x_pos + rect_width, OBSTACLE_Y_POS + rect_height, red)
	    Draw.Box(obstacle_x_pos, OBSTACLE_Y_POS, obstacle_x_pos + rect_width, OBSTACLE_Y_POS + rect_height, 7)
	end if
	
  
	% The second obstacle--
	
	if (whatdotcolor(obstacle_x_pos_2 - 1, OBSTACLE_Y_POS) = BOUNDARY_COLOR) then 
	    % Erase the obstacle
	    Draw.FillBox(obstacle_x_pos_2, OBSTACLE_Y_POS, obstacle_x_pos_2 + rect_width_2, OBSTACLE_Y_POS + rect_height_2, 15)
	    % Obstacle no longer exists
	    obstacle_exists_2 := false
	    % reset the x position of the obstacle
	    obstacle_x_pos_2 := maxx - 50
	end if  

	% Spawns enemy shapes
	if (spawn_counter_2 = SPAWN_COUNT_2) then 
	    % Increase the score by 1 
	    shapes_score += 1
	    % Generate a random number for the rectangle's height and width within the range
	    randint(rect_height_2, MIN_HEIGHT, MAX_HEIGHT)
	    randint(rect_width_2, MIN_WIDTH, MAX_WIDTH)
	    % Draw the rectangle
	    Draw.FillBox(obstacle_x_pos_2, OBSTACLE_Y_POS, maxx - 50 + rect_width_2, OBSTACLE_Y_POS + rect_height_2, red)
	    Draw.Box(obstacle_x_pos_2, OBSTACLE_Y_POS, maxx - 50 + rect_width_2, OBSTACLE_Y_POS + rect_height_2, 7)
	    spawn_counter_2 := 0
	    obstacle_exists_2 := true
	else
	    spawn_counter_2 += 1
	end if
	
	if (obstacle_exists_2 = true) then
	    % Update the position of the obstacle
	    obstacle_d_x_2 := -1
	
	    % Update the shape position
	    obstacle_x_pos_2 := obstacle_x_pos_2 + obstacle_d_x_2
	
	    % Move the shape forward
	    % Erase the previous position
	    Draw.FillBox(obstacle_x_pos_2 - obstacle_d_x_2, OBSTACLE_Y_POS, obstacle_x_pos_2 - obstacle_d_x_2 + rect_width_2, OBSTACLE_Y_POS + rect_height_2, 15)
	    % Draw the new position
	    Draw.FillBox(obstacle_x_pos_2, OBSTACLE_Y_POS, obstacle_x_pos_2 + rect_width_2, OBSTACLE_Y_POS + rect_height_2, red)
	    Draw.Box(obstacle_x_pos_2, OBSTACLE_Y_POS, obstacle_x_pos_2 + rect_width_2, OBSTACLE_Y_POS + rect_height_2, 7)
	end if
	
	% The third obstacle --
	if (whatdotcolor(obstacle_x_pos_3 - 1, OBSTACLE_Y_POS) = BOUNDARY_COLOR) then 
	    % Erase the obstacle
	    Draw.FillPolygon(obstacle_3_x_points, obstacle_3_y_points, 3, 15)
	    % Obstacle no longer exists
	    obstacle_exists_3 := false
	    % reset the x position of the obstacle
	    obstacle_x_pos_3 := maxx - 50
	end if  

	% Spawns enemy shapes
	if (spawn_counter_3 = SPAWN_COUNT_3) then 
	    % Increase the score by 1 
	    shapes_score += 1
	    % Generate a random number for the rectangle's height and width within the range
	    randint(tri_height_3, MIN_HEIGHT, MAX_HEIGHT)
	    randint(tri_width_3, MIN_WIDTH, MAX_WIDTH)
	    % Reassign values to array
	    obstacle_3_x_points (1) := obstacle_x_pos_3
	    % The mid point of the triangle
	    obstacle_3_x_points (2) := (obstacle_x_pos_3 + obstacle_x_pos_3 + tri_width_3) div 2
	    obstacle_3_x_points (3) := obstacle_x_pos_3 + tri_width_3
	    obstacle_3_y_points (1) := OBSTACLE_Y_POS
	    obstacle_3_y_points (2) := OBSTACLE_Y_POS + tri_height_3
	    obstacle_3_y_points (3) := OBSTACLE_Y_POS
	    % Draw the triangle
	    Draw.FillPolygon(obstacle_3_x_points, obstacle_3_y_points, 3, red)
	    Draw.Polygon(obstacle_3_x_points, obstacle_3_y_points, 3, 7)
	    spawn_counter_3 := 0
	    obstacle_exists_3 := true
	else
	    spawn_counter_3 += 1
	end if
	
	if (obstacle_exists_3 = true) then
	    % Update the position of the obstacle
	    obstacle_d_x_3 := -1
	    % Erase the previous position
	    Draw.FillPolygon(obstacle_3_x_points, obstacle_3_y_points, 3, 15)            
	    % Update the shape position
	    obstacle_x_pos_3 := obstacle_x_pos_3 + obstacle_d_x_3
	
	    % Move the shape forward
	    % Draw the new position
	    % Update values again
	    obstacle_3_x_points (1) := obstacle_x_pos_3
	    % The mid point of the triangle
	    obstacle_3_x_points (2) := (obstacle_x_pos_3 + obstacle_x_pos_3 + tri_width_3) div 2
	    obstacle_3_x_points (3) := obstacle_x_pos_3 + tri_width_3
	    obstacle_3_y_points (1) := OBSTACLE_Y_POS
	    obstacle_3_y_points (2) := OBSTACLE_Y_POS + tri_height_3
	    obstacle_3_y_points (3) := OBSTACLE_Y_POS
	    Draw.FillPolygon(obstacle_3_x_points, obstacle_3_y_points, 3, red)
	    Draw.Polygon(obstacle_3_x_points, obstacle_3_y_points, 3, 7)
	end if
	
	% Checks if the player hits the spike 
	if (whatdotcolor(obstacle_3_x_points(2), obstacle_3_y_points(2) + 1) = 11) then 
	    % Make the player red
	    Draw.FillBox(X_POS, y_pos, X_POS + SHAPES_PLAYER_SIZE, y_pos + SHAPES_PLAYER_SIZE, 40)
	    % Give the player a moment to realize they lost
	    Time.Delay(500)
	    % Restart the game
	    return_value := "gameShapes"            
	end if 
	
	% The player --
	
	% Find out whether the player is touching the ground or is on a another block in this iteration
	touching_ground := ((whatdotcolor(X_POS, y_pos - 1) = 7) or (whatdotcolor(X_POS + SHAPES_PLAYER_SIZE, y_pos - 1) = 7))
	
	% The player block is always falling if it is not touching the ground
	if (not (touching_ground)) then 
	    d_y := -1
	end if
	
	% Checks if the user has pressed a key
	if hasch then
	    getch (key_pressed)

	    % If the user presses up or space,
	    if (key_pressed = chr (200) or key_pressed = chr(32)) then
		% If the player is touching the ground or is on top of another shape
		if (touching_ground) then 
		    jump := true
		end if
	    end if

	    % Sets the key pressed back to nothing
	    key_pressed := ""
	end if
	
	% Jumps
	if (jump) then 
	    if (jump_counter <= JUMP_LIMIT) then 
		d_y := 1
		jump_counter += 1
	    else
		jump := false
		jump_counter := 0
	    end if
	end if

	% Draws the player block
	% Checks if the player even moved (if it did not, there is no need to update the position)
	if (d_y not= 0) then 
	    % Erases the previous block
	    Draw.FillBox(X_POS, y_pos, X_POS + SHAPES_PLAYER_SIZE, y_pos + SHAPES_PLAYER_SIZE, 15)
	    % Update the y position of the player block note that the x position is fixed
	    y_pos := y_pos + d_y 
	    % Draws the new block 
	    Draw.FillBox(X_POS, y_pos, X_POS + SHAPES_PLAYER_SIZE, y_pos + SHAPES_PLAYER_SIZE, 11)
	end if
	
	% Check if the player has collided with an obstacle
	if (whatdotcolor(X_POS + SHAPES_PLAYER_SIZE + 1, y_pos) = 7 or whatdotcolor(X_POS + SHAPES_PLAYER_SIZE + 1, y_pos + SHAPES_PLAYER_SIZE) = 7 or whatdotcolor(X_POS + SHAPES_PLAYER_SIZE + 1, y_pos + SHAPES_PLAYER_SIZE div 2) = 7) then
	    % Make the player red
	    Draw.FillBox(X_POS, y_pos, X_POS + SHAPES_PLAYER_SIZE, y_pos + SHAPES_PLAYER_SIZE, 40)
	    % Give the player a moment to realize they lost
	    Time.Delay(500)
	    % Restart the game
	    return_value := "gameShapes"
	end if 
	
	% Listen for mouse clicks, if it is one of the buttons, redirect to that page
	Mouse.Where (mouse_x, mouse_y, mouse_num)
	
	% buy game 
	if (((mouse_x >= maxx - 115 and mouse_x <= maxx - 5) and (mouse_y >= maxy - 55 and mouse_y <= maxy - 15)) and mouse_num = 1) then
	    return_value := "pageShapes"
	% exit button
	elsif (((mouse_x >= maxx - 85 and mouse_x <= maxx - 5) and (mouse_y >= 15 and mouse_y <= 35)) and mouse_num = 1) then
	    return_value := "exitPage"
	% back button
	elsif ((whatdotcolor(mouse_x, mouse_y) = 49 or whatdotcolor(mouse_x, mouse_y) = white or whatdotcolor(mouse_x, mouse_y) = 247) and mouse_num = 1) then 
	    return_value := "welcome"
	end if

	exit when return_value not= VOID
	
    end loop

    % Displays the player's score
    cls 
    Draw.Text("Your score is", maxx div 2 - 50, maxy div 2 + 50, normal_text, 255)
    Draw.Text(intstr(shapes_score), maxx div 2 - 10, maxy div 2, semi_title_2, 255)
    Time.Delay (time_delay + 2000)

    % Returns the next subprogram that should be run
    result return_value

end gameShapes

% Includes animation 
% The game page for the game Space
body function gameSpace

    cls
    % Resets the return value to void and the mouse integer values to -1
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1
    
    % Resets the values of variables used in this subprogram 
    % Note that some are reused in multiple games
    space_score := 0
    x_pos := maxx div 2
    d_x := 0
    key_pressed := ""
    space_shoot := false
    bullet_1_exists := false 
    bullet_2_exists := false 
    % Gives bullet 1 and 2 x positions arbitary values so that no value exception comes up at the beginning of the loop
    bullet_1_x_pos := -1
    bullet_2_x_pos := -1
    bullet_1_y_pos := Y_POS + SPACE_PLAYER_SIZE_Y + 1
    bullet_2_y_pos := Y_POS + SPACE_PLAYER_SIZE_Y + 1
    space_player_x_points (1) := x_pos
    % The mid point of the triangle
    space_player_x_points (2) := (x_pos + x_pos + SPACE_PLAYER_SIZE_X) div 2 
    space_player_x_points (3) := x_pos + SPACE_PLAYER_SIZE_X
    space_player_y_points (1) := Y_POS
    space_player_y_points (2) := Y_POS + SPACE_PLAYER_SIZE_Y
    space_player_y_points (3) := Y_POS
    spawn_counter := 0
    enemy_1_exists := false
    % Gives the enemy coordinates arbitary values so that no value exception comes up at the beginning of the loop
    enemy_1_x_pos := -1
    enemy_1_y_pos := -1
    spawn_counter_2 := 0
    enemy_2_exists := false
    % Gives the enemy coordinates arbitary values so that no value exception comes up at the beginning of the loop
    enemy_2_x_pos := -1
    enemy_2_y_pos := -1
    

    % Tell the user what the game is about
    Draw.Text("This is a sample of the arcade game.", maxx div 2 - 120, maxy div 2 + 25, normal_text, 255)
    Draw.Text("Use the arrow keys to move and spacebar to shoot", maxx div 2 - 175, maxy div 2, normal_text, 255) 
    Draw.Text("don't let the enemy space ships reach the ground.", maxx div 2 - 170, maxy div 2 - 25, normal_text, 255)
    % Gives the user time to read it
    Time.Delay (time_delay + 3000)

    % Draws the graphics before the main loop begins
    % Background
    Draw.FillBox (0, 0, maxx, maxy, 7)
    % Draws the boundary
    Draw.Box (0, 37, maxx, maxy - 70, BOUNDARY_COLOR)
    % Draws the buy this game button
    Draw.FillBox (maxx - 115, maxy - 55, maxx - 5, maxy - 15, 11)
    Draw.Text ("Buy this game", maxx - 110, maxy - 40, normal_text, 255)
    % Draws the back button
    Draw.FillOval (40, maxy - 40, 25, 25, white)
    Draw.FillBox (30, maxy - 45, 60, maxy - 35, 49)
    Draw.FillPolygon (polygon_x, polygon_y, 3, 49)
    Draw.Line(55, maxy - 45, 55, maxy - 35, 247)
    Draw.FillBox(57, maxy - 45, 60, maxy - 35, 247)
    % Write Space
    Draw.Text("Space Defense", maxx div 2 - 100, maxy - 45, semi_title, white)
    % Draw the ground
    Draw.FillBox(0, 30, maxx, 50, 10)
    % Draw the exit button
    Draw.FillBox(maxx - 85, 15, maxx - 5, 35, 40)
    Draw.Text("Exit page", maxx - 80, 20, normal_text, 255)
    % Draw the player
    Draw.FillPolygon(space_player_x_points, space_player_y_points, 3, 9)
    
    % Main subprogram loop
    loop
	
	% Sets the speed of the game by delaying the time
	Time.Delay(SPACE_SPEED)
	% Reset the player velocity to zero
	d_x := 0
	
	% Enemy 1 --
	
	% Checks if enemy 1 hit the ground or the player note that the whatdotcolor is checked for 3 points at the bottom of the square, leftmost point, middle point, and the rightmost point
	if ((whatdotcolor(enemy_1_x_pos, enemy_1_y_pos - 1) = 10 or whatdotcolor(enemy_1_x_pos, enemy_1_y_pos - 1) = 9) or (whatdotcolor(enemy_1_x_pos + SPACE_ENEMY_SIZE, enemy_1_y_pos - 1) = 10 or whatdotcolor(enemy_1_x_pos + SPACE_ENEMY_SIZE, enemy_1_y_pos - 1) = 9) or (whatdotcolor(enemy_1_x_pos + SPACE_ENEMY_SIZE div 2, enemy_1_y_pos - 1) = 10 or whatdotcolor(enemy_1_x_pos + SPACE_ENEMY_SIZE div 2, enemy_1_y_pos - 1) = 9)) then 
	    % Make the enemy white
	    Draw.FillBox(enemy_1_x_pos, enemy_1_y_pos, enemy_1_x_pos + SPACE_ENEMY_SIZE, enemy_1_y_pos + SPACE_ENEMY_SIZE, white)
	    % Let the player realize they lost
	    Time.Delay(500)
	    % Restart the game
	    return_value := "gameSpace"
	end if    
	
	% Spawns enemy
	if (spawn_counter = SPACE_SPAWN_COUNT) then 
	    % Increase the score by 1 
	    space_score += 1
	    % Generate a random number for the rectangle's height and width within the range
	    randint(enemy_1_x_pos, 10, maxx - SPACE_ENEMY_SIZE)
	    % Set the y position to the top
	    enemy_1_y_pos := maxy - 121
	    % Draw the rectangle
	    Draw.FillBox(enemy_1_x_pos, enemy_1_y_pos, enemy_1_x_pos + SPACE_ENEMY_SIZE, enemy_1_y_pos + SPACE_ENEMY_SIZE, 12)
	    spawn_counter := 0
	    enemy_1_exists := true
	else
	    spawn_counter += 1
	end if
	
	% If the enemy exists move it
	if (enemy_1_exists = true) then
	    % Erase the previous position
	    Draw.FillBox(enemy_1_x_pos, enemy_1_y_pos, enemy_1_x_pos + SPACE_ENEMY_SIZE, enemy_1_y_pos + SPACE_ENEMY_SIZE, 7)
	    % Update the position of the enemy
	    enemy_1_d_y := -1
	    % Update the position
	    enemy_1_y_pos := enemy_1_y_pos + enemy_1_d_y
	    % Move the shape down
	    % Draw the new position
	    Draw.FillBox(enemy_1_x_pos, enemy_1_y_pos, enemy_1_x_pos + SPACE_ENEMY_SIZE, enemy_1_y_pos + SPACE_ENEMY_SIZE, 12)
	end if
	
	% Enemy 2 --
	
	% Checks if enemy 2 hit the ground or the player note that the whatdotcolor is checked for 3 points at the bottom of the square, leftmost point, middle point, and the rightmost point
	if ((whatdotcolor(enemy_2_x_pos, enemy_2_y_pos - 1) = 10 or whatdotcolor(enemy_2_x_pos, enemy_2_y_pos - 1) = 9) or (whatdotcolor(enemy_2_x_pos + SPACE_ENEMY_SIZE, enemy_2_y_pos - 1) = 10 or whatdotcolor(enemy_2_x_pos + SPACE_ENEMY_SIZE, enemy_2_y_pos - 1) = 9) or (whatdotcolor(enemy_2_x_pos + SPACE_ENEMY_SIZE div 2, enemy_2_y_pos - 1) = 10 or whatdotcolor(enemy_2_x_pos + SPACE_ENEMY_SIZE div 2, enemy_2_y_pos - 1) = 9)) then 
	    % Make the enemy white
	    Draw.FillBox(enemy_2_x_pos, enemy_2_y_pos, enemy_2_x_pos + SPACE_ENEMY_SIZE, enemy_2_y_pos + SPACE_ENEMY_SIZE, white)
	    % Let the player realize they lost
	    Time.Delay(500)
	    % Restart the game
	    return_value := "gameSpace"
	end if    
	
	% Spawns enemy
	if (spawn_counter_2 = SPACE_SPAWN_COUNT_2) then 
	    % Increase the score by 1 
	    space_score += 1
	    % Generate a random number for the rectangle's height and width within the range
	    randint(enemy_2_x_pos, 10, maxx - SPACE_ENEMY_SIZE)
	    % Set the y position to the top
	    enemy_2_y_pos := maxy - 121
	    % Draw the rectangle
	    Draw.FillBox(enemy_2_x_pos, enemy_2_y_pos, enemy_2_x_pos + SPACE_ENEMY_SIZE, enemy_2_y_pos + SPACE_ENEMY_SIZE, 12)
	    spawn_counter_2 := 0
	    enemy_2_exists := true
	else
	    spawn_counter_2 += 1
	end if
	
	% If the enemy exists move it
	if (enemy_2_exists = true) then
	    % Erase the previous position
	    Draw.FillBox(enemy_2_x_pos, enemy_2_y_pos, enemy_2_x_pos + SPACE_ENEMY_SIZE, enemy_2_y_pos + SPACE_ENEMY_SIZE, 7)
	    % Update the position of the enemy
	    enemy_2_d_y := -1
	    % Update the position
	    enemy_2_y_pos := enemy_2_y_pos + enemy_2_d_y
	    % Move the shape down
	    % Draw the new position
	    Draw.FillBox(enemy_2_x_pos, enemy_2_y_pos, enemy_2_x_pos + SPACE_ENEMY_SIZE, enemy_2_y_pos + SPACE_ENEMY_SIZE, 12)
	end if
	
	% Player --    

	% Checks if the user has pressed a key
	if hasch then
	    getch (key_pressed)

	    % Checks what the key is and changes the direction of the snake correspondingly
	    % left
	    if (key_pressed = chr (203) or key_pressed = 'a') then
		d_x := -30
	    % right
	    elsif (key_pressed = chr (205) or key_pressed = 'd') then
		d_x := 30
	    % space
	    elsif (key_pressed = chr (32)) then 
		space_shoot := true
	    end if

	    % Sets the key pressed back to nothing
	    key_pressed := ""
	end if

	% Shoots
	if (space_shoot) then 
	    if ( not (bullet_1_exists)) then 
		bullet_1_exists := true
		bullet_1_x_pos := space_player_x_points (2)
		bullet_1_d_y := 1
		space_shoot := false
	    elsif (not (bullet_2_exists)) then 
		bullet_2_exists := true
		bullet_2_x_pos := space_player_x_points (2)
		bullet_2_d_y := 1
		space_shoot := false
	    end if
	end if
    
	% Bullet 1's movement
	if (bullet_1_exists) then 
	    % Checks if the bullet hit anything before its position is updated
	    if (whatdotcolor(bullet_1_x_pos, bullet_1_y_pos + 1) = 12 or whatdotcolor(bullet_1_x_pos, bullet_1_y_pos + BULLET_LENGTH + 1) = BOUNDARY_COLOR) then 
		% Bullet 1 is no longer on the screen
		bullet_1_exists := false
		% It stops
		bullet_1_d_y := 0
		% Checks which of the enemies the bullet hit
		if (bullet_1_y_pos + BULLET_LENGTH + 1 >= enemy_1_y_pos and bullet_1_y_pos + BULLET_LENGTH + 1 <= enemy_1_y_pos + SPACE_ENEMY_SIZE) then 
		    % And then makes that enemy dissapear
		    enemy_1_exists := false
		    % Erases it
		    Draw.FillBox(enemy_1_x_pos, enemy_1_y_pos, enemy_1_x_pos + SPACE_ENEMY_SIZE, enemy_1_y_pos + SPACE_ENEMY_SIZE, 7)
		elsif (bullet_1_y_pos + BULLET_LENGTH + 1 >= enemy_2_y_pos and bullet_1_y_pos + BULLET_LENGTH + 1 <= enemy_2_y_pos + SPACE_ENEMY_SIZE) then 
		    % And then makes that enemy dissapear
		    enemy_2_exists := false
		    % Erases it
		    Draw.FillBox(enemy_2_x_pos, enemy_2_y_pos, enemy_2_x_pos + SPACE_ENEMY_SIZE, enemy_2_y_pos + SPACE_ENEMY_SIZE, 7)
		end if
		% Resets the bullet's y position to the starting postion
		bullet_1_y_pos := Y_POS + SPACE_PLAYER_SIZE_Y + 1
	    end if
	    % Erase the previous bullet line
	    Draw.Line(bullet_1_x_pos, bullet_1_y_pos, bullet_1_x_pos, bullet_1_y_pos + BULLET_LENGTH, 7)
	    % If bullet 1 still exists
	    if (bullet_1_exists) then 
		bullet_1_y_pos := bullet_1_y_pos + bullet_1_d_y
		% Draw the new bullet
		Draw.Line(bullet_1_x_pos, bullet_1_y_pos, bullet_1_x_pos, bullet_1_y_pos + BULLET_LENGTH, 2)
		% Check again for if the bullet hit anything
		if (whatdotcolor(bullet_1_x_pos, bullet_1_y_pos + BULLET_LENGTH + 1) = 12 or whatdotcolor(bullet_1_x_pos, bullet_1_y_pos + BULLET_LENGTH + 1) = BOUNDARY_COLOR) then 
		    bullet_1_exists := false
		    bullet_1_d_y := 0
		    if (bullet_1_y_pos + BULLET_LENGTH + 1 >= enemy_1_y_pos and bullet_1_y_pos + BULLET_LENGTH + 1 <= enemy_1_y_pos + SPACE_ENEMY_SIZE) then 
			enemy_1_exists := false 
			Draw.FillBox(enemy_1_x_pos, enemy_1_y_pos, enemy_1_x_pos + SPACE_ENEMY_SIZE, enemy_1_y_pos + SPACE_ENEMY_SIZE, 7)
		    elsif (bullet_1_y_pos + BULLET_LENGTH + 1 >= enemy_2_y_pos and bullet_1_y_pos + BULLET_LENGTH + 1 <= enemy_2_y_pos + SPACE_ENEMY_SIZE) then 
			enemy_2_exists := false
			Draw.FillBox(enemy_2_x_pos, enemy_2_y_pos, enemy_2_x_pos + SPACE_ENEMY_SIZE, enemy_2_y_pos + SPACE_ENEMY_SIZE, 7)
		    end if
		    % Erases the bullet
		    Draw.Line(bullet_1_x_pos, bullet_1_y_pos, bullet_1_x_pos, bullet_1_y_pos + BULLET_LENGTH, 7)
		    bullet_1_y_pos := Y_POS + SPACE_PLAYER_SIZE_Y + 1
		end if                    
	    end if
	end if
	
	% Bullet number 2
	% Bullet 2's movement
	if (bullet_2_exists) then 
	    % Checks if the bullet hit anything before its position is updated
	    if (whatdotcolor(bullet_2_x_pos, bullet_2_y_pos + 1) = 12 or whatdotcolor(bullet_2_x_pos, bullet_2_y_pos + BULLET_LENGTH + 1) = BOUNDARY_COLOR) then 
		% Bullet 2 is no longer on the screen
		bullet_2_exists := false
		% It stops
		bullet_2_d_y := 0
		% Checks which of the enemies the bullet hit
		if (bullet_2_y_pos + BULLET_LENGTH + 1 >= enemy_1_y_pos and bullet_2_y_pos + BULLET_LENGTH + 1 <= enemy_1_y_pos + SPACE_ENEMY_SIZE) then 
		    % And then makes that enemy dissapear
		    enemy_1_exists := false
		    % Erases it
		    Draw.FillBox(enemy_1_x_pos, enemy_1_y_pos, enemy_1_x_pos + SPACE_ENEMY_SIZE, enemy_1_y_pos + SPACE_ENEMY_SIZE, 7)
		elsif (bullet_2_y_pos + BULLET_LENGTH + 1 >= enemy_2_y_pos and bullet_2_y_pos + BULLET_LENGTH + 1 <= enemy_2_y_pos + SPACE_ENEMY_SIZE) then 
		    % And then makes that enemy dissapear
		    enemy_2_exists := false
		    % Erases it
		    Draw.FillBox(enemy_2_x_pos, enemy_2_y_pos, enemy_2_x_pos + SPACE_ENEMY_SIZE, enemy_2_y_pos + SPACE_ENEMY_SIZE, 7)
		end if
		% Resets the bullet's y position to the starting postion
		bullet_2_y_pos := Y_POS + SPACE_PLAYER_SIZE_Y + 1
	    end if
	    % Erase the previous bullet line
	    Draw.Line(bullet_2_x_pos, bullet_2_y_pos, bullet_2_x_pos, bullet_2_y_pos + BULLET_LENGTH, 7)
	    % If bullet 2 still exists
	    if (bullet_2_exists) then 
		bullet_2_y_pos := bullet_2_y_pos + bullet_2_d_y
		% Draw the new bullet
		Draw.Line(bullet_2_x_pos, bullet_2_y_pos, bullet_2_x_pos, bullet_2_y_pos + BULLET_LENGTH, 2)
		% Check again for if the bullet hit anything
		if (whatdotcolor(bullet_2_x_pos, bullet_2_y_pos + BULLET_LENGTH + 1) = 12 or whatdotcolor(bullet_2_x_pos, bullet_2_y_pos + BULLET_LENGTH + 1) = BOUNDARY_COLOR) then 
		    bullet_2_exists := false
		    bullet_2_d_y := 0
		    if (bullet_2_y_pos + BULLET_LENGTH + 1 >= enemy_1_y_pos and bullet_2_y_pos + BULLET_LENGTH + 1 <= enemy_1_y_pos + SPACE_ENEMY_SIZE) then 
			enemy_1_exists := false 
			Draw.FillBox(enemy_1_x_pos, enemy_1_y_pos, enemy_1_x_pos + SPACE_ENEMY_SIZE, enemy_1_y_pos + SPACE_ENEMY_SIZE, 7)
		    elsif (bullet_2_y_pos + BULLET_LENGTH + 1 >= enemy_2_y_pos and bullet_2_y_pos + BULLET_LENGTH + 1 <= enemy_2_y_pos + SPACE_ENEMY_SIZE) then 
			enemy_2_exists := false
			Draw.FillBox(enemy_2_x_pos, enemy_2_y_pos, enemy_2_x_pos + SPACE_ENEMY_SIZE, enemy_2_y_pos + SPACE_ENEMY_SIZE, 7)
		    end if
		    % Erases the bullet
		    Draw.Line(bullet_2_x_pos, bullet_2_y_pos, bullet_2_x_pos, bullet_2_y_pos + BULLET_LENGTH, 7)
		    bullet_2_y_pos := Y_POS + SPACE_PLAYER_SIZE_Y + 1
		end if                    
	    end if
	end if

	% Draws the player
	% Checks if the player even moved (if it did not, there is no need to update the position)
	if (d_x not= 0) then 
	    % Erases the previous position
	    Draw.FillPolygon(space_player_x_points, space_player_y_points, 3, 7)
	    % Update the player position
	    % Update the y position of the player note that the x position is fixed
	    x_pos := x_pos + d_x 
	    space_player_x_points (1) := x_pos
	    space_player_x_points (2) := (x_pos + x_pos + SPACE_PLAYER_SIZE_X) div 2 
	    space_player_x_points (3) := x_pos + SPACE_PLAYER_SIZE_X
	    space_player_y_points (1) := Y_POS
	    space_player_y_points (2) := Y_POS + SPACE_PLAYER_SIZE_Y
	    space_player_y_points (3) := Y_POS         
	    % Draws the new position
	    Draw.FillPolygon(space_player_x_points, space_player_y_points, 3, 9)
	end if 
	
	% Listen for mouse clicks, if it is one of the buttons, redirect to that page
	Mouse.Where (mouse_x, mouse_y, mouse_num)
	
	% buy game button
	if (((mouse_x >= maxx - 115 and mouse_x <= maxx - 5) and (mouse_y >= maxy - 55 and mouse_y <= maxy - 15)) and mouse_num = 1) then
	    return_value := "pageSpace"
	% exit page
	elsif (((mouse_x >= maxx - 85 and mouse_x <= maxx - 5) and (mouse_y >= 15 and mouse_y <= 35)) and mouse_num = 1) then
	    return_value := "exitPage"
	% back button
	elsif ((whatdotcolor(mouse_x, mouse_y) = 49 or whatdotcolor(mouse_x, mouse_y) = white or whatdotcolor(mouse_x, mouse_y) = 247) and mouse_num = 1) then 
	    return_value := "welcome"
	end if

	exit when return_value not= VOID
	
    end loop
    
    % Displays the player's score
    cls 
    Draw.Text("Your score is", maxx div 2 - 50, maxy div 2 + 50, normal_text, 255)
    Draw.Text(intstr(space_score), maxx div 2 - 10, maxy div 2, semi_title_2, 255)
    Time.Delay (time_delay + 2000)
    
    % Returns the next subprogram that should be run
    result return_value
    
end gameSpace

% Includes animation
% The game page for the game Thief
body function gameThief

    cls
    % Resets the return value to void and the mouse integer values to -1
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1
    
    % Reset the variables that are used in this subprogram to default
    thief_x_pos := 73
    thief_y_pos := 73
    d_x := 0
    d_y := 0
    thief_level := 1
    view_counter := 0
    
    % Tell the user what the game is about
    Draw.Text("This is a sample of the arcade game.", maxx div 2 - 120, maxy div 2 + 25, normal_text, 255)
    Draw.Text("Use the arrow keys to move around and get the key without being seen by the guards.", 10, maxy div 2, normal_text, 255) 
    % Gives the user time to read it
    Time.Delay (time_delay + 4000)

    % Draws the graphics before the main loop begins
    % Background
    Draw.FillBox (0, 0, maxx, maxy, 15)
    % Draws the boundary
    Draw.Box (0, 37, maxx, maxy - 70, BOUNDARY_COLOR)
    % Draws the buy this game button
    Draw.FillBox (maxx - 115, maxy - 55, maxx - 5, maxy - 15, 11)
    Draw.Text ("Buy this game", maxx - 110, maxy - 40, normal_text, 255)
    % Draws the back button
    Draw.FillOval (40, maxy - 40, 25, 25, white)
    Draw.FillBox (30, maxy - 45, 60, maxy - 35, 49)
    Draw.FillPolygon (polygon_x, polygon_y, 3, 49)
    Draw.Line(55, maxy - 45, 55, maxy - 35, 247)
    Draw.FillBox(57, maxy - 45, 60, maxy - 35, 247)
    % Write Thief
    Draw.Text("Thief", maxx div 2 - 10, maxy - 45, semi_title, 255)
    % Draw the exit button
    Draw.FillBox(maxx - 85, 15, maxx - 5, 35, 40)
    Draw.Text("Exit page", maxx - 80, 20, normal_text, 255)
    % Draw the player
    Draw.FillOval(thief_x_pos, thief_y_pos, THIEF_SIZE, THIEF_SIZE, 255)
    % Draw the cop
    Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
    % Draw the initial view of the cop
    Draw.FillPolygon(VIEW_6_X, VIEW_6_Y, 3, LIGHT_COLOR)
    % Draw the key
    Draw.FillBox(maxx - 75, maxy - 145, maxx - 30, maxy - 75, 14)
    Draw.FillBox(maxx - 50, maxy - 140, maxx - 40, maxy - 90, 42)
    Draw.FillBox(maxx - 70, maxy - 140, maxx - 50, maxy - 130, 42)
    Draw.FillBox(maxx - 70, maxy - 120, maxx - 50, maxy - 110, 42)
    Draw.FillOval(maxx - 45, maxy - 90, 13, 13, 42)
    Draw.FillOval(maxx - 45, maxy - 90, 5, 5, 255)
    % Draw the walls
    Draw.FillBox(1, 100, 301, 150, BOUNDARY_COLOR)
    Draw.FillBox(maxx - 201, 200, maxx - 1, 250, BOUNDARY_COLOR)
    
    % Main subprogram loop
    loop
    
	Time.Delay(THIEF_SPEED)
	% Reset the velocities of the player 
	d_x := 0
	d_y := 0
	
	% The rotating view of the cop
	% Increase the view counter by 1
	view_counter += 1
	% Depending on the level, rotate the view of the cop around  the cop
	if (thief_level = 1) then 
	    if (view_counter = LV_1_COUNT) then 
		% Erases the view before
		Draw.FillPolygon(VIEW_6_X, VIEW_6_Y, 3, 15)
		% Draws the new view
		Draw.FillPolygon(VIEW_1_X, VIEW_1_Y, 3, LIGHT_COLOR)
		% Redraws the cop
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
	    elsif (view_counter = LV_1_COUNT * 2) then
		Draw.FillPolygon(VIEW_1_X, VIEW_1_Y, 3, 15)
		Draw.FillPolygon(VIEW_2_X, VIEW_2_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
	    elsif (view_counter = LV_1_COUNT * 3) then 
		Draw.FillPolygon(VIEW_2_X, VIEW_2_Y, 3, 15)
		Draw.FillPolygon(VIEW_3_X, VIEW_3_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
	    elsif (view_counter = LV_1_COUNT * 4) then 
		Draw.FillPolygon(VIEW_3_X, VIEW_3_Y, 3, 15)
		Draw.FillPolygon(VIEW_4_X, VIEW_4_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
		% Redraw the key 
		Draw.FillBox(maxx - 75, maxy - 145, maxx - 30, maxy - 75, 14)
		Draw.FillBox(maxx - 50, maxy - 140, maxx - 40, maxy - 90, 42)
		Draw.FillBox(maxx - 70, maxy - 140, maxx - 50, maxy - 130, 42)
		Draw.FillBox(maxx - 70, maxy - 120, maxx - 50, maxy - 110, 42)
		Draw.FillOval(maxx - 45, maxy - 90, 13, 13, 42)
		Draw.FillOval(maxx - 45, maxy - 90, 5, 5, 255)              
	    elsif (view_counter = LV_1_COUNT * 5) then 
		Draw.FillPolygon(VIEW_4_X, VIEW_4_Y, 3, 15)
		Draw.FillPolygon(VIEW_5_X, VIEW_5_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
	    elsif (view_counter = LV_1_COUNT * 6) then 
		Draw.FillPolygon(VIEW_5_X, VIEW_5_Y, 3, 15)
		Draw.FillPolygon(VIEW_6_X, VIEW_6_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
		% Restarts the cycle
		view_counter := 0
	    end if         
	elsif (thief_level = 2) then 
	     if (view_counter = LV_2_COUNT) then 
		% Erases the view before
		Draw.FillPolygon(VIEW_6_X, VIEW_6_Y, 3, 15)
		% Draws the new view
		Draw.FillPolygon(VIEW_1_X, VIEW_1_Y, 3, LIGHT_COLOR)
		% Redraws the cop
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
	    elsif (view_counter = LV_2_COUNT * 2) then
		Draw.FillPolygon(VIEW_1_X, VIEW_1_Y, 3, 15)
		Draw.FillPolygon(VIEW_2_X, VIEW_2_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
	    elsif (view_counter = LV_2_COUNT * 3) then 
		Draw.FillPolygon(VIEW_2_X, VIEW_2_Y, 3, 15)
		Draw.FillPolygon(VIEW_3_X, VIEW_3_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
	    elsif (view_counter = LV_2_COUNT * 4) then 
		Draw.FillPolygon(VIEW_3_X, VIEW_3_Y, 3, 15)
		Draw.FillPolygon(VIEW_4_X, VIEW_4_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
		% Redraw the key too
		Draw.FillBox(maxx - 75, maxy - 145, maxx - 30, maxy - 75, 14)
		Draw.FillBox(maxx - 50, maxy - 140, maxx - 40, maxy - 90, 42)
		Draw.FillBox(maxx - 70, maxy - 140, maxx - 50, maxy - 130, 42)
		Draw.FillBox(maxx - 70, maxy - 120, maxx - 50, maxy - 110, 42)
		Draw.FillOval(maxx - 45, maxy - 90, 13, 13, 42)
		Draw.FillOval(maxx - 45, maxy - 90, 5, 5, 255)   
	    elsif (view_counter = LV_2_COUNT * 5) then 
		Draw.FillPolygon(VIEW_4_X, VIEW_4_Y, 3, 15)
		Draw.FillPolygon(VIEW_5_X, VIEW_5_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
	    elsif (view_counter = LV_2_COUNT * 6) then 
		Draw.FillPolygon(VIEW_5_X, VIEW_5_Y, 3, 15)
		Draw.FillPolygon(VIEW_6_X, VIEW_6_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
		% Restarts the cycle
		view_counter := 0
	    end if 
	elsif (thief_level = 3) then
	    if (view_counter = LV_3_COUNT) then 
		% Erases the view before
		Draw.FillPolygon(VIEW_6_X, VIEW_6_Y, 3, 15)
		% Draws the new view
		Draw.FillPolygon(VIEW_1_X, VIEW_1_Y, 3, LIGHT_COLOR)
		% Redraws the cop
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
	    elsif (view_counter = LV_3_COUNT * 2) then
		Draw.FillPolygon(VIEW_1_X, VIEW_1_Y, 3, 15)
		Draw.FillPolygon(VIEW_2_X, VIEW_2_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
	    elsif (view_counter = LV_3_COUNT * 3) then 
		Draw.FillPolygon(VIEW_2_X, VIEW_2_Y, 3, 15)
		Draw.FillPolygon(VIEW_3_X, VIEW_3_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
	    elsif (view_counter = LV_3_COUNT * 4) then 
		Draw.FillPolygon(VIEW_3_X, VIEW_3_Y, 3, 15)
		Draw.FillPolygon(VIEW_4_X, VIEW_4_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
		% Redraw the key too
		Draw.FillBox(maxx - 75, maxy - 145, maxx - 30, maxy - 75, 14)
		Draw.FillBox(maxx - 50, maxy - 140, maxx - 40, maxy - 90, 42)
		Draw.FillBox(maxx - 70, maxy - 140, maxx - 50, maxy - 130, 42)
		Draw.FillBox(maxx - 70, maxy - 120, maxx - 50, maxy - 110, 42)
		Draw.FillOval(maxx - 45, maxy - 90, 13, 13, 42)
		Draw.FillOval(maxx - 45, maxy - 90, 5, 5, 255)   
	    elsif (view_counter = LV_3_COUNT * 5) then 
		Draw.FillPolygon(VIEW_4_X, VIEW_4_Y, 3, 15)
		Draw.FillPolygon(VIEW_5_X, VIEW_5_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
	    elsif (view_counter = LV_3_COUNT * 6) then 
		Draw.FillPolygon(VIEW_5_X, VIEW_5_Y, 3, 15)
		Draw.FillPolygon(VIEW_6_X, VIEW_6_Y, 3, LIGHT_COLOR)
		Draw.FillOval(COP_X_POS, COP_Y_POS, COP_SIZE, COP_SIZE, red)
		% Restarts the cycle
		view_counter := 0
	    end if 
	end if
	
	% Checks if the user has pressed a key
	if hasch then
	    getch (key_pressed)

	    % Checks what the key is and changes the direction of the snake correspondingly
	    % left
	    if (key_pressed = chr (203)) then
		d_x := -1
		d_y := 0
	    % down
	    elsif (key_pressed = chr (208)) then
		d_x := 0
		d_y := -1
	    % up
	    elsif (key_pressed = chr (200)) then
		d_x := 0
		d_y := 1
	    % right
	    elsif (key_pressed = chr (205)) then
		d_x := 1
		d_y := 0
	    end if

	    % Sets the key pressed back to nothing
	    key_pressed := ""
	end if 
	
	% If the player moved
	if (d_x not= 0 or d_y not= 0) then 
	    % Erase the previous player position
	    Draw.FillOval(thief_x_pos, thief_y_pos, THIEF_SIZE, THIEF_SIZE, 15)
	    % If the player is against an obstacle, don't let the player move pass it Note * There is an image in the references folder of these points
	    % Left of the circle (most left point, left top point, left bottom point, four other points between these points)
	    if (whatdotcolor(thief_x_pos - THIEF_SIZE - 1, thief_y_pos) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos - THIEF_SIZE div 1.4 - 1, thief_y_pos + THIEF_SIZE div 1.4 + 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos - THIEF_SIZE div 1.4 - 1, thief_y_pos - THIEF_SIZE div 1.4 - 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos - THIEF_SIZE div 2 - 1, thief_y_pos + THIEF_SIZE div (2/1.73) + 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos - THIEF_SIZE div (2/1.73) - 1, thief_y_pos + THIEF_SIZE div 2 + 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos - THIEF_SIZE div (2/1.73) - 1, thief_y_pos - THIEF_SIZE div 2 - 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos - THIEF_SIZE div 2 - 1, thief_y_pos - THIEF_SIZE div (2/1.73) - 1) = BOUNDARY_COLOR) then 
		% Checks if the player is going left, then stop it
		if (d_x = -1) then 
		    d_x := 0
		end if
	    end if
	    % Right of the cirlce (most right point, right top point, right bottom point, four other points between these points)
	    if (whatdotcolor(thief_x_pos + THIEF_SIZE + 1, thief_y_pos) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE div 1.4 + 1, thief_y_pos + THIEF_SIZE div 1.4 + 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE div 1.4 + 1, thief_y_pos - THIEF_SIZE div 1.4 - 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE div 2 + 1, thief_y_pos + THIEF_SIZE div (2/1.73) + 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE div (2/1.73) + 1, thief_y_pos + THIEF_SIZE div 2 + 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE div (2/1.73) + 1, thief_y_pos - THIEF_SIZE div 2 - 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE div 2 + 1, thief_y_pos - THIEF_SIZE div (2/1.73) - 1) = BOUNDARY_COLOR) then
		% Checks if the player is going right, then stop it
		if (d_x = 1) then 
		    d_x := 0
		end if
	    end if
	    % Top of the circle (top most point, left top point, right top point, four other points between these points)
	    if (whatdotcolor(thief_x_pos, thief_y_pos + THIEF_SIZE + 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos - THIEF_SIZE div 1.4 + 1, thief_y_pos + THIEF_SIZE div 1.4 + 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE div 1.4 + 1, thief_y_pos + THIEF_SIZE div 1.4 + 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos - THIEF_SIZE div 2 - 1, thief_y_pos + THIEF_SIZE div (2/1.73) + 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos - THIEF_SIZE div (2/1.73) - 1, thief_y_pos + THIEF_SIZE div 2 + 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE div 2 + 1, thief_y_pos + THIEF_SIZE div (2/1.73) + 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE div (2/1.73) + 1, thief_y_pos + THIEF_SIZE div 2 + 1) = BOUNDARY_COLOR) then 
		% Checks if the player is going up, then stop it
		if (d_y = 1) then 
		    d_y := 0
		end if
	    end if
	    % Bottom of the circle (most bottom point, bottom left point, bottom right point, four other points between these points)
	    if (whatdotcolor(thief_x_pos, thief_y_pos - THIEF_SIZE - 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos - THIEF_SIZE div 1.4 - 1, thief_y_pos - THIEF_SIZE div 1.4 - 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE div 1.4 + 1, thief_y_pos - THIEF_SIZE div 1.4 - 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE div (2/1.73) + 1, thief_y_pos - THIEF_SIZE div 2 - 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE div 2 + 1, thief_y_pos - THIEF_SIZE div (2/1.73) - 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos - THIEF_SIZE div (2/1.73) - 1, thief_y_pos - THIEF_SIZE div 2 - 1) = BOUNDARY_COLOR or whatdotcolor(thief_x_pos - THIEF_SIZE div 2 - 1, thief_y_pos - THIEF_SIZE div (2/1.73) - 1) = BOUNDARY_COLOR) then 
		% Checks if the player is going down, then stop it
		if (d_y = -1) then 
		    d_y := 0
		end if
	    end if
	    % Update the player's position
	    thief_x_pos := thief_x_pos + d_x
	    thief_y_pos := thief_y_pos + d_y
	    % Draw the new player position
	    Draw.FillOval(thief_x_pos, thief_y_pos, THIEF_SIZE, THIEF_SIZE, 255)
	end if
	
	% Check if the player has gotten the key
	if (whatdotcolor(thief_x_pos + THIEF_SIZE + 1, thief_y_pos) = 14) then 
	    % Increase the level by 1 if the level is not already 3 note that the level will go up to 4, since if the player completes level 3, the level increases
	    thief_level += 1
	    if (thief_level < THIEF_NUM_LEVELS + 1) then
		% Reset the position of the player
		% Fill in the current position
		Draw.FillOval(thief_x_pos, thief_y_pos, THIEF_SIZE, THIEF_SIZE, 15)
		% Reset the position of the player back to the starting position
		thief_x_pos := 73
		thief_y_pos := 73
		if (thief_level = 2) then 
		    % Write lvel 2
		    Draw.Text("Level 2", 300, 200, semi_title, white)
		    Time.Delay(time_delay)
		    % Erase it
		    Draw.FillBox(300, 200, 400, 250, 15)
		elsif (thief_level = 3) then 
		    % Write lvel 3
		    Draw.Text("Level 3", 300, 200, semi_title, white)
		    Time.Delay(time_delay)
		    % Erase it
		    Draw.FillBox(300, 200, 400, 250, 15)
		end if
	    % If the player completes level 3
	    else 
		% Restart the game
		return_value := "gameThief"
	    end if
	end if
	
	% Check if the player got caught
	if (whatdotcolor(thief_x_pos - THIEF_SIZE - 1, thief_y_pos) = LIGHT_COLOR or whatdotcolor(thief_x_pos - THIEF_SIZE div 1.4 - 1, thief_y_pos + THIEF_SIZE div 1.4 + 1) = LIGHT_COLOR or whatdotcolor(thief_x_pos - THIEF_SIZE div 1.4 - 1, thief_y_pos - THIEF_SIZE div 1.4 - 1) = LIGHT_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE + 1, thief_y_pos) = LIGHT_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE div 1.4 + 1, thief_y_pos + THIEF_SIZE div 1.4 + 1) = LIGHT_COLOR or whatdotcolor(thief_x_pos + THIEF_SIZE div 1.4 + 1, thief_y_pos - THIEF_SIZE div 1.4 - 1) = LIGHT_COLOR or whatdotcolor(thief_x_pos, thief_y_pos + THIEF_SIZE + 1) = LIGHT_COLOR or whatdotcolor(thief_x_pos, thief_y_pos - THIEF_SIZE - 1) = LIGHT_COLOR or whatdotcolor(thief_x_pos, thief_y_pos + THIEF_SIZE + 1) = LIGHT_COLOR) then 
	    % turn the player red
	    Draw.FillOval(thief_x_pos, thief_y_pos, THIEF_SIZE, THIEF_SIZE, red)
	    Time.Delay(500)
	    % Restart the game
	    return_value := "gameThief"
	end if
	
	% Listen for mouse clicks, if it is one of the buttons, redirect to that page
	Mouse.Where (mouse_x, mouse_y, mouse_num)
	
	% buy game button
	if (((mouse_x >= maxx - 115 and mouse_x <= maxx - 5) and (mouse_y >= maxy - 55 and mouse_y <= maxy - 15)) and mouse_num = 1) then
	    return_value := "pageThief"
	% exit page
	elsif (((mouse_x >= maxx - 85 and mouse_x <= maxx - 5) and (mouse_y >= 15 and mouse_y <= 35)) and mouse_num = 1) then
	    return_value := "exitPage"
	% back button
	elsif ((whatdotcolor(mouse_x, mouse_y) = 49 or whatdotcolor(mouse_x, mouse_y) = white or whatdotcolor(mouse_x, mouse_y) = 247) and mouse_num = 1) then 
	    return_value := "welcome"
	end if

	exit when return_value not= VOID
	
    end loop
    
    % Displays the player's score
    cls 
    Draw.Text("Your score is", maxx div 2 - 50, maxy div 2 + 50, normal_text, 255)
    % -1 because there is only 3 levels but the the value goes up to 4 if they complete level 3
    Draw.Text(intstr(thief_level - 1), maxx div 2 - 10, maxy div 2, semi_title_2, 255)
    % If the player beat level 3, inform her that there are more levels if she buys the real game
    if (thief_level = 4) then
	Draw.Text("You completed the sample levels, but there are 70 more levels in the real arcade game!", 5, maxy div 2 - 30, normal_text, 255)
    end if 
    Time.Delay (time_delay + 3000) 

    % Returns the next subprogram that should be run
    result return_value

end gameThief


body function pageSnake

    cls
    % Resets the return value to void and the mouse integer values to -1
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1

    % Resets the page's values to default
    color_chosen := "white"
    num_items_chosen := 0
    Time.Delay (time_delay)

    % - Draws the graphics before the loop--
    % Background
    Draw.FillBox (0, 0, maxx, maxy, 15)
    % Draws the my cart button
    Draw.FillBox (maxx - 85, maxy - 55, maxx - 15, maxy - 15, yellow)
    Draw.Text ("My Cart", maxx - 80, maxy - 40, normal_text, 255)
    % Draws the back button
    Draw.FillOval (40, maxy - 40, 25, 25, white)
    Draw.FillBox (30, maxy - 45, 60, maxy - 35, 49)
    Draw.FillPolygon (polygon_x, polygon_y, 3, 49)
    Draw.Line (55, maxy - 45, 55, maxy - 35, 247)
    Draw.FillBox (57, maxy - 45, 60, maxy - 35, 247)
    % Write Snake
    Draw.Text("Snake", maxx div 2 - 50, maxy - 45, semi_title, 255)
    % Draw the exit button
    Draw.FillBox (maxx - 85, 15, maxx - 5, 35, 40)
    Draw.Text("Exit page", maxx - 80, 20, normal_text, 255)
    % Draw the product box
    Draw.FillBox (25, 40, maxx - 25, maxy - 75, 255)
    % Draw the white square
    Draw.FillBox (40, 130, maxx div 2 - 50, maxy - 90, white)
    % Output the arcade machine picture
    Pic.Draw (white_machine, 100, maxx div 2 - 180, 0)
    % Output the information about the game
    Draw.Text("Snake: the arcade game.", maxx div 2 - 30, maxy - 120, semi_title, white)
    Draw.Text("Dimensions: 1.25m x 0.5m x 0.5m", maxx div 2 - 30, maxy - 140, normal_text, white)
    Draw.Text("$200.00", maxx div 2 - 30, maxy - 165, normal_text_description, white)
    Draw.Text("Play as a young snake who aspires", 50, 110, normal_text_description, white)
    Draw.Text("to be a giant anaconda. Collect", 50, 90, normal_text_description, white)
    Draw.Text("food to grow bigger but don't bump", 50, 70, normal_text_description, white)
    Draw.Text("into the walls or yourself!", 50, 50, normal_text_description, white)
    % Draws the buttons to choose colors
    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 20, maxx div 2 + 60, maxy div 2, white)
    Draw.Text("Classic White", maxx div 2 - 25, maxy div 2 - 15, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)
    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 20, maxx div 2 + 175, maxy div 2, 41)
    Draw.Text("Original Brown", maxx div 2 + 85, maxy div 2 - 15, selection_box_unselected, COLOR_SELECTION_BOX_UNSELECTED)
    % Draws the add to cart button
    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 80, maxx div 2 + 60, maxy div 2 - 50, 42)
    Draw.Text("Add to cart", maxx div 2 - 25, maxy div 2 - 70, normal_text, white)
    % Draws the quantity button
    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 130, maxx div 2 + 95, maxy div 2 - 100, white)
    Draw.Text("Quantity:", maxx div 2 - 28, maxy div 2 - 120, normal_text, 255)
    % Draw the plus sign
    Draw.FillBox(maxx div 2 + 60, maxy div 2 - 115, maxx div 2 + 70, maxy div 2 - 114, red)
    Draw.FillBox(maxx div 2 + 65, maxy div 2 - 110, maxx div 2 + 66, maxy div 2 - 120, red)
    % Draw the minus sign
    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 115, maxx div 2 + 90, maxy div 2 - 114, 13)
    % Draw the number
    Draw.Text("0", maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)
    
    % Main subprogram loop
    loop
	Mouse.Where (mouse_x, mouse_y, mouse_num)

	% See if the user has clicked on anything, if they have, make the appropriate changes
	% Different options for each product 
	% Switches to white
	if ((mouse_x >= maxx div 2 - 30 and mouse_x <= maxx div 2 + 60) and (mouse_y >= maxy div 2 - 20 and mouse_y <= maxy div 2) and mouse_num = 1) then
	    color_chosen := "white"
	    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 20, maxx div 2 + 60, maxy div 2, white)
	    Draw.Text("Classic White", maxx div 2 - 25, maxy div 2 - 15, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)
	    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 20, maxx div 2 + 175, maxy div 2, 41)
	    Draw.Text("Original Brown", maxx div 2 + 85, maxy div 2 - 15, selection_box_unselected, COLOR_SELECTION_BOX_UNSELECTED)
	    % Draw the white square
	    Draw.FillBox (40, 130, maxx div 2 - 50, maxy - 90, white)
	    % Output the arcade machine picture
	    Pic.Draw (white_machine, 100, maxx div 2 - 180, 0)
	% Switches to brown
	elsif ((mouse_x >= maxx div 2 + 80 and mouse_x <= maxx div 2 + 170) and (mouse_y >= maxy div 2 - 20 and mouse_y <= maxy div 2) and mouse_num = 1) then 
	    color_chosen := "brown"
	    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 20, maxx div 2 + 60, maxy div 2, white)
	    Draw.Text("Classic White", maxx div 2 - 25, maxy div 2 - 15, selection_box_unselected, COLOR_SELECTION_BOX_UNSELECTED)
	    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 20, maxx div 2 + 175, maxy div 2, 41)
	    Draw.Text("Original Brown", maxx div 2 + 80, maxy div 2 - 15, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)
	    % Draw the white square
	    Draw.FillBox (40, 130, maxx div 2 - 50, maxy - 90, white)
	    % Output the arcade machine picture
	    Pic.Draw (brown_machine, 100, maxx div 2 - 180, 0)
	% Exits page
	elsif (((mouse_x >= maxx - 85 and mouse_x <= maxx - 5) and (mouse_y >= 15 and mouse_y <= 35)) and mouse_num = 1) then
	    return_value := "exitPage"
	% Back button
	elsif (((whatdotcolor(mouse_x, mouse_y) = 49 or whatdotcolor(mouse_x, mouse_y) = white or whatdotcolor(mouse_x, mouse_y) = 247) and mouse_num = 1) and ((mouse_x >= 15 and mouse_x <= 65) and (mouse_y >= maxy - 65 and mouse_y <= maxy - 15))) then 
	    return_value := "gameSnake"
	% My cart button
	elsif (((mouse_x >= maxx - 85 and mouse_x <= maxx - 15) and (mouse_y >= maxy - 55 and mouse_y <= maxy - 15)) and mouse_num = 1) then
	    return_value := "myCart"
	% Add to cart button if white
	elsif (((mouse_x >= maxx div 2 - 30 and mouse_x <= maxx div 2 + 60) and (mouse_y >= maxy div 2 - 80 and mouse_y <= maxy div 2 - 50)) and mouse_num = 1 and color_chosen = "white") then 
	    item_confirm := "item_snake_white"
	    return_value := "cartConfirmation"
	% Add to cart button if brown
	elsif (((mouse_x >= maxx div 2 - 30 and mouse_x <= maxx div 2 + 60) and (mouse_y >= maxy div 2 - 80 and mouse_y <= maxy div 2 - 50)) and mouse_num = 1 and color_chosen = "brown") then 
	    item_confirm := "item_snake_brown"
	    return_value := "cartConfirmation"
	% Adds an item
	elsif (((mouse_x >= maxx div 2 + 60 and mouse_x <= maxx div 2 + 70) and (mouse_y >= maxy div 2 - 120 and mouse_y <= maxy div 2 - 110)) and mouse_num = 1) then
	    % Waits a bit so that the mouse clicks do not activate twice
	    Time.Delay(time_delay)
	    num_items_chosen += 1
	    Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
	    Draw.Text(intstr(num_items_chosen), maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)
	% Subracts an item
	elsif (((mouse_x >= maxx div 2 + 80 and mouse_x <= maxx div 2 + 90) and (mouse_y >= maxy div 2 - 120 and mouse_y <= maxy div 2 - 109)) and mouse_num = 1) then
	    % Checks if the number of items the user has chosen is less than 0, if so, do not do anything
	    if (num_items_chosen > 0) then 
		% Waits a bit so that the mouse clicks do not activate twice
		Time.Delay(time_delay)
		num_items_chosen -= 1
		Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
		Draw.Text(intstr(num_items_chosen), maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)
	    end if 
	% User clicks on the number 
	elsif (((mouse_x >= maxx div 2 + 37 and mouse_x <= maxx div 2 + 54) and (mouse_y >= maxy div 2 - 120 and mouse_y <= maxy div 2 - 109)) and (mouse_num = 1)) then 
	    % Erase the number
	    Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
	    % Locate the xy to the number 
	    locatexy(maxx div 2 + 42, maxy div 2 - 110)
	    % Get the number of items
	    get num_items_chosen
	    % Erase the number
	    Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
	    % Write the new number
	    Draw.Text(intstr(num_items_chosen), maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)           
	end if

	exit when return_value not= VOID
	
    end loop

    % Returns the next subprogram that should be run
    result return_value

end pageSnake


body function pageShapes

    cls
    % Resets the return value to void and the mouse integer values to -1
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1

    % Resets the page's values to default
    color_chosen := "white"
    num_items_chosen := 0
    Time.Delay (time_delay)

    % - Draws the graphics before the loop--
    % Background
    Draw.FillBox (0, 0, maxx, maxy, 15)
    % Draws the my cart button
    Draw.FillBox (maxx - 85, maxy - 55, maxx - 15, maxy - 15, yellow)
    Draw.Text ("My Cart", maxx - 80, maxy - 40, normal_text, 255)
    % Draws the back button
    Draw.FillOval (40, maxy - 40, 25, 25, white)
    Draw.FillBox (30, maxy - 45, 60, maxy - 35, 49)
    Draw.FillPolygon (polygon_x, polygon_y, 3, 49)
    Draw.Line (55, maxy - 45, 55, maxy - 35, 247)
    Draw.FillBox (57, maxy - 45, 60, maxy - 35, 247)
    % Write Shapes
    Draw.Text("Shapes", maxx div 2 - 50, maxy - 45, semi_title, 255)
    % Draw the exit button
    Draw.FillBox (maxx - 85, 15, maxx - 5, 35, 40)
    Draw.Text("Exit page", maxx - 80, 20, normal_text, 255)
    % Draw the product box
    Draw.FillBox (25, 40, maxx - 25, maxy - 75, 255)
    % Draw the white square
    Draw.FillBox (40, 130, maxx div 2 - 50, maxy - 90, white)
    % Output the arcade machine picture
    Pic.Draw (white_machine, 100, maxx div 2 - 180, 0)
    % Output the information about the game
    Draw.Text("Shapes: the arcade game.", maxx div 2 - 30, maxy - 120, semi_title_4, white)
    Draw.Text("Dimensions: 1.25m x 0.5m x 0.5m", maxx div 2 - 30, maxy - 140, normal_text, white)
    Draw.Text("$200.00", maxx div 2 - 30, maxy - 165, normal_text_description, white)
    Draw.Text("Play as a square in flatland and", 50, 110, normal_text_description, white)
    Draw.Text("reach the finish line while evading", 50, 90, normal_text_description, white)
    Draw.Text("the red shapes.", 50, 70, normal_text_description, white)
    % Draws the buttons to choose colors
    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 20, maxx div 2 + 60, maxy div 2, white)
    Draw.Text("Classic White", maxx div 2 - 25, maxy div 2 - 15, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)
    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 20, maxx div 2 + 175, maxy div 2, 41)
    Draw.Text("Original Brown", maxx div 2 + 85, maxy div 2 - 15, selection_box_unselected, COLOR_SELECTION_BOX_UNSELECTED)
    % Draws the add to cart button
    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 80, maxx div 2 + 60, maxy div 2 - 50, 42)
    Draw.Text("Add to cart", maxx div 2 - 25, maxy div 2 - 70, normal_text, white)
    % Draws the quantity button
    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 130, maxx div 2 + 95, maxy div 2 - 100, white)
    Draw.Text("Quantity:", maxx div 2 - 28, maxy div 2 - 120, normal_text, 255)
    % Draw the plus sign
    Draw.FillBox(maxx div 2 + 60, maxy div 2 - 115, maxx div 2 + 70, maxy div 2 - 114, red)
    Draw.FillBox(maxx div 2 + 65, maxy div 2 - 110, maxx div 2 + 66, maxy div 2 - 120, red)
    % Draw the minus sign
    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 115, maxx div 2 + 90, maxy div 2 - 114, 13)
    % Draw the number
    Draw.Text("0", maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)
    
    % Main subprogram loop
    loop
	Mouse.Where (mouse_x, mouse_y, mouse_num)

	% Different options for each product 
	% See if the user has clicked on anything, if they have, make the appropriate changes
	% Switches to white
	if ((mouse_x >= maxx div 2 - 30 and mouse_x <= maxx div 2 + 60) and (mouse_y >= maxy div 2 - 20 and mouse_y <= maxy div 2) and mouse_num = 1) then
	    color_chosen := "white"
	    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 20, maxx div 2 + 60, maxy div 2, white)
	    Draw.Text("Classic White", maxx div 2 - 25, maxy div 2 - 15, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)
	    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 20, maxx div 2 + 175, maxy div 2, 41)
	    Draw.Text("Original Brown", maxx div 2 + 85, maxy div 2 - 15, selection_box_unselected, COLOR_SELECTION_BOX_UNSELECTED)
	    % Draw the white square
	    Draw.FillBox (40, 130, maxx div 2 - 50, maxy - 90, white)
	    % Output the arcade machine picture
	    Pic.Draw (white_machine, 100, maxx div 2 - 180, 0)
	% Switches to brown
	elsif ((mouse_x >= maxx div 2 + 80 and mouse_x <= maxx div 2 + 170) and (mouse_y >= maxy div 2 - 20 and mouse_y <= maxy div 2) and mouse_num = 1) then 
	    color_chosen := "brown"
	    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 20, maxx div 2 + 60, maxy div 2, white)
	    Draw.Text("Classic White", maxx div 2 - 25, maxy div 2 - 15, selection_box_unselected, COLOR_SELECTION_BOX_UNSELECTED)
	    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 20, maxx div 2 + 175, maxy div 2, 41)
	    Draw.Text("Original Brown", maxx div 2 + 80, maxy div 2 - 15, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)
	    % Draw the white square
	    Draw.FillBox (40, 130, maxx div 2 - 50, maxy - 90, white)
	    % Output the arcade machine picture
	    Pic.Draw (brown_machine, 100, maxx div 2 - 180, 0)
	% Exits page
	elsif (((mouse_x >= maxx - 85 and mouse_x <= maxx - 5) and (mouse_y >= 15 and mouse_y <= 35)) and mouse_num = 1) then
	    return_value := "exitPage"
	% Back button
	elsif (((whatdotcolor(mouse_x, mouse_y) = 49 or whatdotcolor(mouse_x, mouse_y) = white or whatdotcolor(mouse_x, mouse_y) = 247) and mouse_num = 1) and ((mouse_x >= 15 and mouse_x <= 65) and (mouse_y >= maxy - 65 and mouse_y <= maxy - 15))) then 
	    return_value := "gameShapes"
	% My cart button
	elsif (((mouse_x >= maxx - 85 and mouse_x <= maxx - 15) and (mouse_y >= maxy - 55 and mouse_y <= maxy - 15)) and mouse_num = 1) then
	    return_value := "myCart"
	% Add to cart button if white
	elsif (((mouse_x >= maxx div 2 - 30 and mouse_x <= maxx div 2 + 60) and (mouse_y >= maxy div 2 - 80 and mouse_y <= maxy div 2 - 50)) and mouse_num = 1 and color_chosen = "white") then 
	    item_confirm := "item_shapes_white"
	    return_value := "cartConfirmation"
	% Add to cart button if brown
	elsif (((mouse_x >= maxx div 2 - 30 and mouse_x <= maxx div 2 + 60) and (mouse_y >= maxy div 2 - 80 and mouse_y <= maxy div 2 - 50)) and mouse_num = 1 and color_chosen = "brown") then 
	    item_confirm := "item_shapes_brown"
	    return_value := "cartConfirmation"
	% Adds an item
	elsif (((mouse_x >= maxx div 2 + 60 and mouse_x <= maxx div 2 + 70) and (mouse_y >= maxy div 2 - 120 and mouse_y <= maxy div 2 - 110)) and mouse_num = 1) then
	    % Waits a bit so that the mouse clicks do not activate twice
	    Time.Delay(time_delay)
	    num_items_chosen += 1
	    Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
	    Draw.Text(intstr(num_items_chosen), maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)
	% Subracts an item
	elsif (((mouse_x >= maxx div 2 + 80 and mouse_x <= maxx div 2 + 90) and (mouse_y >= maxy div 2 - 120 and mouse_y <= maxy div 2 - 109)) and mouse_num = 1) then
	    % Checks if the number of items the user has chosen is less than 0, if so, do not do anything
	    if (num_items_chosen > 0) then 
		% Waits a bit so that the mouse clicks do not activate twice
		Time.Delay(time_delay)
		num_items_chosen -= 1
		Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
		Draw.Text(intstr(num_items_chosen), maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)
	    end if 
	% User clicks on the number 
	elsif (((mouse_x >= maxx div 2 + 37 and mouse_x <= maxx div 2 + 54) and (mouse_y >= maxy div 2 - 120 and mouse_y <= maxy div 2 - 109)) and (mouse_num = 1)) then 
	    % Erase the number
	    Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
	    % Locate the xy to the number 
	    locatexy(maxx div 2 + 42, maxy div 2 - 110)
	    % Get the number of items
	    get num_items_chosen
	    % Erase the number
	    Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
	    % Write the new number
	    Draw.Text(intstr(num_items_chosen), maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)   
	end if

	exit when return_value not= VOID
	
    end loop

    % Returns the next subprogram that should be run
    result return_value
    
end pageShapes


body function pageSpace

    cls
    % Resets the return value to void and the mouse integer values to -1
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1

    % Resets the page's values to default
    color_chosen := "white"
    num_items_chosen := 0
    Time.Delay (time_delay)

    % - Draws the graphics before the loop--
    % Background
    Draw.FillBox (0, 0, maxx, maxy, 15)
    % Draws the my cart button
    Draw.FillBox (maxx - 85, maxy - 55, maxx - 15, maxy - 15, yellow)
    Draw.Text ("My Cart", maxx - 80, maxy - 40, normal_text, 255)
    % Draws the back button
    Draw.FillOval (40, maxy - 40, 25, 25, white)
    Draw.FillBox (30, maxy - 45, 60, maxy - 35, 49)
    Draw.FillPolygon (polygon_x, polygon_y, 3, 49)
    Draw.Line (55, maxy - 45, 55, maxy - 35, 247)
    Draw.FillBox (57, maxy - 45, 60, maxy - 35, 247)
    % Write Snake
    Draw.Text("Space Defense", maxx div 2 - 100, maxy - 45, semi_title, 255)
    % Draw the exit button
    Draw.FillBox (maxx - 85, 15, maxx - 5, 35, 40)
    Draw.Text("Exit page", maxx - 80, 20, normal_text, 255)
    % Draw the product box
    Draw.FillBox (25, 40, maxx - 25, maxy - 75, 255)
    % Draw the white square
    Draw.FillBox (40, 130, maxx div 2 - 50, maxy - 90, white)
    % Output the arcade machine picture
    Pic.Draw (white_machine, 100, maxx div 2 - 180, 0)
    % Output the information about the game
    Draw.Text("Space Defense: the arcade game.", maxx div 2 - 30, maxy - 120, semi_title_3, white)
    Draw.Text("Dimensions: 1.25m x 0.5m x 0.5m", maxx div 2 - 30, maxy - 140, normal_text, white)
    Draw.Text("$200.00", maxx div 2 - 30, maxy - 165, normal_text_description, white)
    Draw.Text("Play as a spaceship defending", 50, 110, normal_text_description, white)
    Draw.Text("Earth against alien invaders.", 50, 90, normal_text_description, white)
    % Draws the buttons to choose colors
    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 20, maxx div 2 + 60, maxy div 2, white)
    Draw.Text("Classic White", maxx div 2 - 25, maxy div 2 - 15, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)
    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 20, maxx div 2 + 175, maxy div 2, 41)
    Draw.Text("Original Brown", maxx div 2 + 85, maxy div 2 - 15, selection_box_unselected, COLOR_SELECTION_BOX_UNSELECTED)
    % Draws the add to cart button
    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 80, maxx div 2 + 60, maxy div 2 - 50, 42)
    Draw.Text("Add to cart", maxx div 2 - 25, maxy div 2 - 70, normal_text, white)
    % Draws the quantity button
    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 130, maxx div 2 + 95, maxy div 2 - 100, white)
    Draw.Text("Quantity:", maxx div 2 - 28, maxy div 2 - 120, normal_text, 255)
    % Draw the plus sign
    Draw.FillBox(maxx div 2 + 60, maxy div 2 - 115, maxx div 2 + 70, maxy div 2 - 114, red)
    Draw.FillBox(maxx div 2 + 65, maxy div 2 - 110, maxx div 2 + 66, maxy div 2 - 120, red)
    % Draw the minus sign
    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 115, maxx div 2 + 90, maxy div 2 - 114, 13)
    % Draw the number
    Draw.Text("0", maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)
    
    % Main subprogram loop
    loop
    
	Mouse.Where (mouse_x, mouse_y, mouse_num)

	% See if the user has clicked on anything, if they have, make the appropriate changes
	% Switches to white
	if ((mouse_x >= maxx div 2 - 30 and mouse_x <= maxx div 2 + 60) and (mouse_y >= maxy div 2 - 20 and mouse_y <= maxy div 2) and mouse_num = 1) then
	    color_chosen := "white"
	    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 20, maxx div 2 + 60, maxy div 2, white)
	    Draw.Text("Classic White", maxx div 2 - 25, maxy div 2 - 15, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)
	    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 20, maxx div 2 + 175, maxy div 2, 41)
	    Draw.Text("Original Brown", maxx div 2 + 85, maxy div 2 - 15, selection_box_unselected, COLOR_SELECTION_BOX_UNSELECTED)
	    % Draw the white square
	    Draw.FillBox (40, 130, maxx div 2 - 50, maxy - 90, white)
	    % Output the arcade machine picture
	    Pic.Draw (white_machine, 100, maxx div 2 - 180, 0)
	% Switches to brown
	elsif ((mouse_x >= maxx div 2 + 80 and mouse_x <= maxx div 2 + 170) and (mouse_y >= maxy div 2 - 20 and mouse_y <= maxy div 2) and mouse_num = 1) then 
	    color_chosen := "brown"
	    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 20, maxx div 2 + 60, maxy div 2, white)
	    Draw.Text("Classic White", maxx div 2 - 25, maxy div 2 - 15, selection_box_unselected, COLOR_SELECTION_BOX_UNSELECTED)
	    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 20, maxx div 2 + 175, maxy div 2, 41)
	    Draw.Text("Original Brown", maxx div 2 + 80, maxy div 2 - 15, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)
	    % Draw the white square
	    Draw.FillBox (40, 130, maxx div 2 - 50, maxy - 90, white)
	    % Output the arcade machine picture
	    Pic.Draw (brown_machine, 100, maxx div 2 - 180, 0)
	% Exits page
	elsif (((mouse_x >= maxx - 85 and mouse_x <= maxx - 5) and (mouse_y >= 15 and mouse_y <= 35)) and mouse_num = 1) then
	    return_value := "exitPage"
	% Back button
	elsif (((whatdotcolor(mouse_x, mouse_y) = 49 or whatdotcolor(mouse_x, mouse_y) = white or whatdotcolor(mouse_x, mouse_y) = 247) and mouse_num = 1) and ((mouse_x >= 15 and mouse_x <= 65) and (mouse_y >= maxy - 65 and mouse_y <= maxy - 15))) then 
	    return_value := "gameSpace"
	% My cart button
	elsif (((mouse_x >= maxx - 85 and mouse_x <= maxx - 15) and (mouse_y >= maxy - 55 and mouse_y <= maxy - 15)) and mouse_num = 1) then
	    return_value := "myCart"
	% Add to cart button if white
	elsif (((mouse_x >= maxx div 2 - 30 and mouse_x <= maxx div 2 + 60) and (mouse_y >= maxy div 2 - 80 and mouse_y <= maxy div 2 - 50)) and mouse_num = 1 and color_chosen = "white") then 
	    item_confirm := "item_space_white"
	    return_value := "cartConfirmation"
	% Add to cart button if brown
	elsif (((mouse_x >= maxx div 2 - 30 and mouse_x <= maxx div 2 + 60) and (mouse_y >= maxy div 2 - 80 and mouse_y <= maxy div 2 - 50)) and mouse_num = 1 and color_chosen = "brown") then 
	    item_confirm := "item_space_brown"
	    return_value := "cartConfirmation"
	% Adds an item
	elsif (((mouse_x >= maxx div 2 + 60 and mouse_x <= maxx div 2 + 70) and (mouse_y >= maxy div 2 - 120 and mouse_y <= maxy div 2 - 110)) and mouse_num = 1) then
	    % Waits a bit so that the mouse clicks do not activate twice
	    Time.Delay(time_delay)
	    num_items_chosen += 1
	    Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
	    Draw.Text(intstr(num_items_chosen), maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)
	% Subracts an item
	elsif (((mouse_x >= maxx div 2 + 80 and mouse_x <= maxx div 2 + 90) and (mouse_y >= maxy div 2 - 120 and mouse_y <= maxy div 2 - 109)) and mouse_num = 1) then
	    % Checks if the number of items the user has chosen is less than 0, if so, do not do anything
	    if (num_items_chosen > 0) then 
		% Waits a bit so that the mouse clicks do not activate twice
		Time.Delay(time_delay)
		num_items_chosen -= 1
		Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
		Draw.Text(intstr(num_items_chosen), maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)
	    end if 
	% User clicks on the number 
	elsif (((mouse_x >= maxx div 2 + 37 and mouse_x <= maxx div 2 + 54) and (mouse_y >= maxy div 2 - 120 and mouse_y <= maxy div 2 - 109)) and (mouse_num = 1)) then 
	    % Erase the number
	    Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
	    % Locate the xy to the number 
	    locatexy(maxx div 2 + 42, maxy div 2 - 110)
	    % Get the number of items
	    get num_items_chosen
	    % Erase the number
	    Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
	    % Write the new number
	    Draw.Text(intstr(num_items_chosen), maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)   
	end if

	exit when return_value not= VOID
	
    end loop

    % Returns the next subprogram that should be run
    result return_value

end pageSpace


body function pageThief

    cls
    % Resets the return value to void and the mouse integer values to -1
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1

    % Resets the page's values to default
    color_chosen := "white"
    num_items_chosen := 0
    Time.Delay (time_delay)

    % - Draws the graphics before the loop--
    % Background
    Draw.FillBox (0, 0, maxx, maxy, 15)
    % Draws the my cart button
    Draw.FillBox (maxx - 85, maxy - 55, maxx - 15, maxy - 15, yellow)
    Draw.Text ("My Cart", maxx - 80, maxy - 40, normal_text, 255)
    % Draws the back button
    Draw.FillOval (40, maxy - 40, 25, 25, white)
    Draw.FillBox (30, maxy - 45, 60, maxy - 35, 49)
    Draw.FillPolygon (polygon_x, polygon_y, 3, 49)
    Draw.Line (55, maxy - 45, 55, maxy - 35, 247)
    Draw.FillBox (57, maxy - 45, 60, maxy - 35, 247)
    % Write Snake
    Draw.Text("Thief", maxx div 2 - 50, maxy - 45, semi_title, 255)
    % Draw the exit button
    Draw.FillBox (maxx - 85, 15, maxx - 5, 35, 40)
    Draw.Text("Exit page", maxx - 80, 20, normal_text, 255)
    % Draw the product box
    Draw.FillBox (25, 40, maxx - 25, maxy - 75, 255)
    % Draw the white square
    Draw.FillBox (40, 130, maxx div 2 - 50, maxy - 90, white)
    % Output the arcade machine picture
    Pic.Draw (white_machine, 100, maxx div 2 - 180, 0)
    % Output the information about the game
    Draw.Text("Thief: the arcade game.", maxx div 2 - 30, maxy - 120, semi_title, white)
    Draw.Text("Dimensions: 1.25m x 0.5m x 0.5m", maxx div 2 - 30, maxy - 140, normal_text, white)
    Draw.Text("$200.00", maxx div 2 - 30, maxy - 165, normal_text_description, white)
    Draw.Text("Play as an ambitious thief and steal", 50, 110, normal_text_description, white)
    Draw.Text("the key while avoiding the guards.", 50, 90, normal_text_description, white)
    % Draws the buttons to choose colors
    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 20, maxx div 2 + 60, maxy div 2, white)
    Draw.Text("Classic White", maxx div 2 - 25, maxy div 2 - 15, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)
    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 20, maxx div 2 + 175, maxy div 2, 41)
    Draw.Text("Original Brown", maxx div 2 + 85, maxy div 2 - 15, selection_box_unselected, COLOR_SELECTION_BOX_UNSELECTED)
    % Draws the add to cart button
    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 80, maxx div 2 + 60, maxy div 2 - 50, 42)
    Draw.Text("Add to cart", maxx div 2 - 25, maxy div 2 - 70, normal_text, white)
    % Draws the quantity button
    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 130, maxx div 2 + 95, maxy div 2 - 100, white)
    Draw.Text("Quantity:", maxx div 2 - 28, maxy div 2 - 120, normal_text, 255)
    % Draw the plus sign
    Draw.FillBox(maxx div 2 + 60, maxy div 2 - 115, maxx div 2 + 70, maxy div 2 - 114, red)
    Draw.FillBox(maxx div 2 + 65, maxy div 2 - 110, maxx div 2 + 66, maxy div 2 - 120, red)
    % Draw the minus sign
    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 115, maxx div 2 + 90, maxy div 2 - 114, 13)
    % Draw the number
    Draw.Text("0", maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)
    
    % Main subprogram loop
    loop
    
	Mouse.Where (mouse_x, mouse_y, mouse_num)
	
	% Different options for each product 
	% See if the user has clicked on anything, if they have, make the appropriate changes
	% Switches to white
	if ((mouse_x >= maxx div 2 - 30 and mouse_x <= maxx div 2 + 60) and (mouse_y >= maxy div 2 - 20 and mouse_y <= maxy div 2) and mouse_num = 1) then
	    color_chosen := "white"
	    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 20, maxx div 2 + 60, maxy div 2, white)
	    Draw.Text("Classic White", maxx div 2 - 25, maxy div 2 - 15, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)
	    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 20, maxx div 2 + 175, maxy div 2, 41)
	    Draw.Text("Original Brown", maxx div 2 + 85, maxy div 2 - 15, selection_box_unselected, COLOR_SELECTION_BOX_UNSELECTED)
	    % Draw the white square
	    Draw.FillBox (40, 130, maxx div 2 - 50, maxy - 90, white)
	    % Output the arcade machine picture
	    Pic.Draw (white_machine, 100, maxx div 2 - 180, 0)
	% Switches to brown
	elsif ((mouse_x >= maxx div 2 + 80 and mouse_x <= maxx div 2 + 170) and (mouse_y >= maxy div 2 - 20 and mouse_y <= maxy div 2) and mouse_num = 1) then 
	    color_chosen := "brown"
	    Draw.FillBox(maxx div 2 - 30, maxy div 2 - 20, maxx div 2 + 60, maxy div 2, white)
	    Draw.Text("Classic White", maxx div 2 - 25, maxy div 2 - 15, selection_box_unselected, COLOR_SELECTION_BOX_UNSELECTED)
	    Draw.FillBox(maxx div 2 + 80, maxy div 2 - 20, maxx div 2 + 175, maxy div 2, 41)
	    Draw.Text("Original Brown", maxx div 2 + 80, maxy div 2 - 15, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)
	    % Draw the white square
	    Draw.FillBox (40, 130, maxx div 2 - 50, maxy - 90, white)
	    % Output the arcade machine picture
	    Pic.Draw (brown_machine, 100, maxx div 2 - 180, 0)
	% Exits page
	elsif (((mouse_x >= maxx - 85 and mouse_x <= maxx - 5) and (mouse_y >= 15 and mouse_y <= 35)) and mouse_num = 1) then
	    return_value := "exitPage"
	% Back button
	elsif (((whatdotcolor(mouse_x, mouse_y) = 49 or whatdotcolor(mouse_x, mouse_y) = white or whatdotcolor(mouse_x, mouse_y) = 247) and mouse_num = 1) and ((mouse_x >= 15 and mouse_x <= 65) and (mouse_y >= maxy - 65 and mouse_y <= maxy - 15))) then 
	    return_value := "gameThief"
	% My cart button
	elsif (((mouse_x >= maxx - 85 and mouse_x <= maxx - 15) and (mouse_y >= maxy - 55 and mouse_y <= maxy - 15)) and mouse_num = 1) then
	    return_value := "myCart"
	% Add to cart button if white
	elsif (((mouse_x >= maxx div 2 - 30 and mouse_x <= maxx div 2 + 60) and (mouse_y >= maxy div 2 - 80 and mouse_y <= maxy div 2 - 50)) and mouse_num = 1 and color_chosen = "white") then 
	    item_confirm := "item_thief_white"
	    return_value := "cartConfirmation"
	% Add to cart button if brown
	elsif (((mouse_x >= maxx div 2 - 30 and mouse_x <= maxx div 2 + 60) and (mouse_y >= maxy div 2 - 80 and mouse_y <= maxy div 2 - 50)) and mouse_num = 1 and color_chosen = "brown") then 
	    item_confirm := "item_thief_brown"
	    return_value := "cartConfirmation"
	% Adds an item
	elsif (((mouse_x >= maxx div 2 + 60 and mouse_x <= maxx div 2 + 70) and (mouse_y >= maxy div 2 - 120 and mouse_y <= maxy div 2 - 110)) and mouse_num = 1) then
	    % Waits a bit so that the mouse clicks do not activate twice
	    Time.Delay(time_delay)
	    num_items_chosen += 1
	    Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
	    Draw.Text(intstr(num_items_chosen), maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)
	% Subracts an item
	elsif (((mouse_x >= maxx div 2 + 80 and mouse_x <= maxx div 2 + 90) and (mouse_y >= maxy div 2 - 120 and mouse_y <= maxy div 2 - 109)) and mouse_num = 1) then
	    % Checks if the number of items the user has chosen is less than 0, if so, do not do anything
	    if (num_items_chosen > 0) then 
		% Waits a bit so that the mouse clicks do not activate twice
		Time.Delay(time_delay)
		num_items_chosen -= 1
		Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
		Draw.Text(intstr(num_items_chosen), maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)
	    end if 
	% User clicks on the number 
	elsif (((mouse_x >= maxx div 2 + 37 and mouse_x <= maxx div 2 + 54) and (mouse_y >= maxy div 2 - 120 and mouse_y <= maxy div 2 - 109)) and (mouse_num = 1)) then 
	    % Erase the number
	    Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
	    % Locate the xy to the number 
	    locatexy(maxx div 2 + 42, maxy div 2 - 110)
	    % Get the number of items
	    get num_items_chosen
	    % Erase the number
	    Draw.FillBox(maxx div 2 + 42, maxy div 2 - 129, maxx div 2 + 59, maxy div 2 - 105, white)
	    % Write the new number
	    Draw.Text(intstr(num_items_chosen), maxx div 2 + 42, maxy div 2 - 120, normal_text, 255)   
	end if

	exit when return_value not= VOID
	
    end loop

    % Returns the next subprogram that should be run
    result return_value

end pageThief


body function myCart

    cls
    % Resets the return value to void and the mouse integer values to -1
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1
     
    Time.Delay (time_delay)

    % Sets the values used in this subprogram to default
    num_different_items := 0
    current_page_number := 1
    current_page_position := 1
    % Resets the values within the number of different items within a page
    num_different_items_pages(1) := 0 
    num_different_items_pages(2) := 0 
    num_different_items_pages(3) := 0 
    num_different_items_pages(4) := 0
    % Resets the values within color_items_pages and the game_title_items_pages
    for i : 1..4
	color_items_pages (i) (1) := VOID
	color_items_pages (i) (2) := VOID
	game_title_items_pages (i) (1) := VOID
	game_title_items_pages (i) (2) := VOID
    end for 
    
    % - Draws the graphics before the loop --
    % Background
    Draw.FillBox (0, 0, maxx, maxy, 15)
    % Draws the back button
    Draw.FillOval (40, maxy - 40, 25, 25, white)
    Draw.FillBox (30, maxy - 45, 60, maxy - 35, 49)
    Draw.FillPolygon (polygon_x, polygon_y, 3, 49)
    Draw.Line (55, maxy - 45, 55, maxy - 35, 247)
    Draw.FillBox (57, maxy - 45, 60, maxy - 35, 247)
    % The title my cart
    Draw.FillBox(maxx div 2 - 45, maxy - 60, maxx div 2 + 65, maxy - 15, yellow)
    Draw.Text("My Cart", maxx div 2 - 40, maxy - 45, semi_title, 255)
    % The button go to check out
    Draw.FillBox(maxx - 200, 10, maxx - 20, 50, 40)
    Draw.Text("Go to check out", maxx - 195, 23, check_out_font, 255)
    % The exit button
    Draw.FillBox(10, 20, 90, 40, 40)
    Draw.Text("Exit page", 15, 25, normal_text, 255)
    % - - - 
    
    % Adding values to variables that will be used to find out what to output for each page of the myCart page
    
    % If the user has added some amount of this item,
    if (item_snake_white > 0) then
    
	% Adds to the number of different items that will be displayed in the cart 
	num_different_items += 1
	% Adds to the color_items_pages array (the color of the items that will be displayed in the cart)
	color_items_pages(current_page_number)(current_page_position) := "white"
	% Adds to the game_title_items_pages array (the title of the items that will be displayed in the cart)
	game_title_items_pages(current_page_number)(current_page_position) := "item_snake_white"
	% Adds to the num_different_items_pages array, this is an array to find out how many boxes to output on each page of the cart
	num_different_items_pages (current_page_number) := current_page_position
	
	% Update the current page position and number
	if (current_page_position = 1) then
	    current_page_position := 2  
	    
	elsif (current_page_position = 2) then
	    
	    current_page_position := 1
	    current_page_number += 1
	end if
    
    end if

    if (item_snake_brown > 0) then
	% Adds to the number of different items that will be displayed in the cart 
	num_different_items += 1
	% Adds to the color_items_pages array (the color of the items that will be displayed in the cart)
	color_items_pages(current_page_number)(current_page_position) := "brown"
	% Adds to the game_title_items_pages array (the title of the items that will be displayed in the cart)
	game_title_items_pages(current_page_number)(current_page_position) := "item_snake_brown"
	% Adds to the num_different_items_pages array, this is an array to find out how many boxes to output on each page of the cart
	num_different_items_pages (current_page_number) := current_page_position
	
	% Update the current page position and number
	if (current_page_position = 1) then
	    current_page_position := 2  
	    
	elsif (current_page_position = 2) then
	    current_page_position := 1
	    current_page_number += 1
	end if
	
    end if
    
    if (item_shapes_white > 0) then
    
	% Adds to the number of different items that will be displayed in the cart 
	num_different_items += 1
	% Adds to the color_items_pages array (the color of the items that will be displayed in the cart)
	color_items_pages(current_page_number)(current_page_position) := "white"
	% Adds to the game_title_items_pages array (the title of the items that will be displayed in the cart)
	game_title_items_pages(current_page_number)(current_page_position) := "item_shapes_white"
	% Adds to the num_different_items_pages array, this is an array to find out how many boxes to output on each page of the cart
	num_different_items_pages (current_page_number) := current_page_position
	
	% Update the current page position and number
	if (current_page_position = 1) then
	    current_page_position := 2  
	    
	elsif (current_page_position = 2) then
	    current_page_position := 1
	    current_page_number += 1
	end if
	
    end if 
    
    if (item_shapes_brown > 0) then
    
	% Adds to the number of different items that will be displayed in the cart 
	num_different_items += 1
	% Adds to the color_items_pages array (the color of the items that will be displayed in the cart)
	color_items_pages(current_page_number)(current_page_position) := "brown"
	% Adds to the game_title_items_pages array (the title of the items that will be displayed in the cart)
	game_title_items_pages(current_page_number)(current_page_position) := "item_shapes_brown"
	% Adds to the num_different_items_pages array, this is an array to find out how many boxes to output on each page of the cart
	num_different_items_pages (current_page_number) := current_page_position
	
	% Update the current page position and number
	if (current_page_position = 1) then
	    current_page_position := 2  
	    
	elsif (current_page_position = 2) then
	    current_page_position := 1
	    current_page_number += 1
	end if
	
    end if
    
    if (item_space_white > 0) then
    
	% Adds to the number of different items that will be displayed in the cart 
	num_different_items += 1
	% Adds to the color_items_pages array (the color of the items that will be displayed in the cart)
	color_items_pages(current_page_number)(current_page_position) := "white"
	% Adds to the game_title_items_pages array (the title of the items that will be displayed in the cart)
	game_title_items_pages(current_page_number)(current_page_position) := "item_space_white"
	% Adds to the num_different_items_pages array, this is an array to find out how many boxes to output on each page of the cart
	num_different_items_pages (current_page_number) := current_page_position
	
	% Update the current page position and number
	if (current_page_position = 1) then
	    current_page_position := 2  
	    
	elsif (current_page_position = 2) then
	    current_page_position := 1
	    current_page_number += 1
	end if
	
    end if 
    
    if (item_space_brown > 0) then
    
	% Adds to the number of different items that will be displayed in the cart 
	num_different_items += 1
	% Adds to the color_items_pages array (the color of the items that will be displayed in the cart)
	color_items_pages(current_page_number)(current_page_position) := "brown"
	% Adds to the game_title_items_pages array (the title of the items that will be displayed in the cart)
	game_title_items_pages(current_page_number)(current_page_position) := "item_space_brown"
	% Adds to the num_different_items_pages array, this is an array to find out how many boxes to output on each page of the cart
	num_different_items_pages (current_page_number) := current_page_position
	
	% Update the current page position and number
	if (current_page_position = 1) then
	    current_page_position := 2  
	    
	elsif (current_page_position = 2) then
	    current_page_position := 1
	    current_page_number += 1
	end if
	
    end if
    
    if (item_thief_white > 0) then
    
	% Adds to the number of different items that will be displayed in the cart 
	num_different_items += 1
	% Adds to the color_items_pages array (the color of the items that will be displayed in the cart)
	color_items_pages(current_page_number)(current_page_position) := "white"
	% Adds to the game_title_items_pages array (the title of the items that will be displayed in the cart)
	game_title_items_pages(current_page_number)(current_page_position) := "item_thief_white"
	% Adds to the num_different_items_pages array, this is an array to find out how many boxes to output on each page of the cart
	num_different_items_pages (current_page_number) := current_page_position
	
	% Update the current page position and number
	if (current_page_position = 1) then
	    current_page_position := 2  
	    
	elsif (current_page_position = 2) then
	    current_page_position := 1
	    current_page_number += 1
	end if
	
    end if 
    
    if (item_thief_brown > 0) then
    
	% Adds to the number of different items that will be displayed in the cart 
	num_different_items += 1
	% Adds to the color_items_pages array (the color of the items that will be displayed in the cart)
	color_items_pages(current_page_number)(current_page_position) := "brown"
	% Adds to the game_title_items_pages array (the title of the items that will be displayed in the cart)
	game_title_items_pages(current_page_number)(current_page_position) := "item_thief_brown"
	% Adds to the num_different_items_pages array, this is an array to find out how many boxes to output on each page of the cart
	num_different_items_pages (current_page_number) := current_page_position
	
	% Update the current page position and number
	if (current_page_position = 1) then
	    current_page_position := 2  
	    
	elsif (current_page_position = 2) then
	    current_page_position := 1
	    current_page_number += 1
	end if
	
    end if

    % Draws the initial items to be displayed
    if (num_different_items > 0) then 
	% If there is an item to be displayed, output the product box (the specific product to be displayed does not matter)
	% The black box
	Draw.FillBox (25, maxy - 210, maxx - 25, maxy - 100, 255)
	% The white box
	Draw.FillBox (30, maxy - 205, 130, maxy - 105, white)
	% The dimensions
	Draw.Text ("Dimensions: 1.25m x 0.5m x 0.5m", maxx div 2 - 180, maxy - 140, normal_text, white)
	% The price
	Draw.Text ("$200.00", maxx - 100, maxy - 200, normal_text_description, white)
	% The x in the number of this product
	Draw.Text ("x", maxx div 2 - 180, maxy - 200, normal_text_description, white)   
	% Draw the quantity box
	Draw.FillBox(maxx div 2 - 30, maxy div 2, maxx div 2 + 95, maxy div 2 + 30, white)
	Draw.Text("Quantity:", maxx div 2 - 28, maxy div 2 + 10, normal_text, 255)
	% Draw the plus sign
	Draw.FillBox(maxx div 2 + 60, maxy div 2 + 15, maxx div 2 + 70, maxy div 2 + 16, red)
	Draw.FillBox(maxx div 2 + 65, maxy div 2 + 20, maxx div 2 + 66, maxy div 2 + 10, red)
	% Draw the minus sign
	Draw.FillBox(maxx div 2 + 80, maxy div 2 + 15, maxx div 2 + 90, maxy div 2 + 16, 13)

	% Depending on the title of the game that will be displayed at the box, output the title and number of that product in cart
	case game_title_items_pages (1) (1) of
	    label "item_snake_white":
		% The product title
		Draw.Text ("Snake: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
		% The number of this item in cart
		Draw.Text (intstr(item_snake_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
	    label "item_snake_brown":
		Draw.Text ("Snake: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
		Draw.Text (intstr(item_snake_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
	    label "item_shapes_white":
		Draw.Text ("Shapes: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
		Draw.Text (intstr(item_shapes_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
	    label "item_shapes_brown":
		Draw.Text ("Shapes: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
		Draw.Text (intstr(item_shapes_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
	    label "item_space_white":
		Draw.Text ("Space Defenders: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
		Draw.Text (intstr(item_space_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
	    label "item_space_brown":
		Draw.Text ("Space Defenders: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
		Draw.Text (intstr(item_space_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
	    label "item_thief_white":
		Draw.Text ("Thief: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
		Draw.Text (intstr(item_thief_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
	    label "item_thief_brown":
		Draw.Text ("Thief: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
		Draw.Text (intstr(item_thief_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
	end case
	
	% Depending on what color the product is (brown or white), output the appropriate components
	case color_items_pages (1) (1) of 
	    label "white":
		% Output the arcade machine picture
		Pic.Draw (white_machine_smaller, 50, maxy - 203, 0)
		% Output the color indicator
		Draw.FillBox(maxx div 2 - 180, maxy div 2 + 20, maxx div 2 - 60, maxy div 2 + 40, white)
		Draw.Text("Classic White", maxx div 2 - 175, maxy div 2 + 25, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)           
	    label "brown":
		Pic.Draw (brown_machine_smaller, 50, maxy - 203, 0)
		Draw.FillBox(maxx div 2 - 180, maxy div 2 + 20, maxx div 2 - 60, maxy div 2 + 40, 41)
		Draw.Text("Original Brown", maxx div 2 - 175, maxy div 2 + 25, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)  
	end case

    end if 

    % For the second product box (if there is a second product to be displayed); everything from the first product box, but it is shifted vertically down
    if (num_different_items >= 2) then

	Draw.FillBox (25, maxy - 210 - 120, maxx - 25, maxy - 100 - 120, 255)
	Draw.FillBox (30, maxy - 205 - 120, 130, maxy - 105 - 120, white)
	Draw.Text ("Dimensions: 1.25m x 0.5m x 0.5m", maxx div 2 - 180, maxy - 140 - 120, normal_text, white)
	Draw.Text ("$200.00", maxx - 100, maxy - 200 - 120, normal_text_description, white)
	Draw.Text ("x", maxx div 2 - 180, maxy - 200 - 120, normal_text_description, white)  
	% Draw the quantity box
	Draw.FillBox(maxx div 2 - 30, maxy div 2 - 120, maxx div 2 + 95, maxy div 2 + 30 - 120, white)
	Draw.Text("Quantity:", maxx div 2 - 28, maxy div 2 + 10 - 120, normal_text, 255)
	% Draw the plus sign
	Draw.FillBox(maxx div 2 + 60, maxy div 2 + 15 -  120, maxx div 2 + 70, maxy div 2 + 16 - 120, red)
	Draw.FillBox(maxx div 2 + 65, maxy div 2 + 20 - 120, maxx div 2 + 66, maxy div 2 + 10 - 120, red)
	% Draw the minus sign
	Draw.FillBox(maxx div 2 + 80, maxy div 2 + 15 - 120, maxx div 2 + 90, maxy div 2 + 16 - 120, 13)  
	
	% The second product from page 1
	case game_title_items_pages (1) (2) of
	    label "item_snake_white":
		Draw.Text ("Snake: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
		Draw.Text (intstr(item_snake_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
	    label "item_snake_brown":
		Draw.Text ("Snake: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
		Draw.Text (intstr(item_snake_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
	    label "item_shapes_white":
		Draw.Text ("Shapes: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
		Draw.Text (intstr(item_shapes_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
	    label "item_shapes_brown":
		Draw.Text ("Shapes: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
		Draw.Text (intstr(item_shapes_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
	    label "item_space_white":
		Draw.Text ("Space Defenders: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
		Draw.Text (intstr(item_space_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
	    label "item_space_brown":
		Draw.Text ("Space Defenders: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
		Draw.Text (intstr(item_space_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
	    label "item_thief_white":
		Draw.Text ("Thief: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
		Draw.Text (intstr(item_thief_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
	    label "item_thief_brown":
		Draw.Text ("Thief: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
		Draw.Text (intstr(item_thief_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
	end case
	
	% The second product from page 1's color
	case color_items_pages (1) (2) of 
	    label "white":
		% Output the arcade machine picture
		Pic.Draw (white_machine_smaller, 50, maxy - 203 - 120, 0)
		% Output the color indicator
		Draw.FillBox(maxx div 2 - 180, maxy div 2 + 20 - 120, maxx div 2 - 60, maxy div 2 + 40 - 120, white)
		Draw.Text("Classic White", maxx div 2 - 175, maxy div 2 + 25 - 120, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)           
	    label "brown":
		Pic.Draw (brown_machine_smaller, 50, maxy - 203 - 120, 0)
		Draw.FillBox(maxx div 2 - 180, maxy div 2 + 20 - 120, maxx div 2 - 60, maxy div 2 + 40 - 120, 41)
		Draw.Text("Original Brown", maxx div 2 - 175, maxy div 2 + 25 - 120, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)  
	end case
	
	if (num_different_items > 2) then 
	    Draw.FillPolygon(cart_polygon_x, cart_polygon_y, 3, 42)
	    Draw.FillPolygon(cart_polygon_2_x, cart_polygon_2_y, 3, 42)
	end if 

    end if

    % Resets the variables to reuse them in the subprogram loop, to keep track of which page the user is currently viewing
    current_page_number := 1
    current_page_position := 1

    % Main subprogram loop
    loop
    
	% Gets mouse location
	Mouse.Where(mouse_x, mouse_y, mouse_num)
	
	% Did the user click the back button
	if (((whatdotcolor(mouse_x, mouse_y) = 49 or whatdotcolor(mouse_x, mouse_y) = white or whatdotcolor(mouse_x, mouse_y) = 247) and mouse_num = 1) and ((mouse_x >= 15 and mouse_x <= 65) and (mouse_y >= maxy - 65 and mouse_y <= maxy - 15))) then
	    return_value := "welcome"
	% Did the user click the exit button
	elsif (((mouse_x >= 10 and mouse_x <= 90) and (mouse_y >= 20 and mouse_y <= 40)) and mouse_num = 1) then
	    return_value := "exitPage"
	% If the user clicked one of the arrows,
	elsif (whatdotcolor(mouse_x, mouse_y) = 42 and mouse_num = 1) then 
	    % Wait so that the clicks do not stack input
	    Time.Delay(time_delay)
	    % Erase the products that were displayed before
	    Draw.FillBox(25, maxy - 340, maxx - 25, maxy - 100, 15)
	    % If the next arrow was pressed and the maximum number of pages is not overreached,
	    if ((mouse_x > maxx - 25) and (current_page_number not= 4)) then 
		% Increase the current page number by 1
		current_page_number += 1
		% If not, and the minimum number of pages is not reached,
	    elsif ((mouse_x < 25) and (current_page_number not= 1)) then
		% Decrease the current page number by 1
		current_page_number -= 1
	    end if
	    
	    % - The identical code as the initial output of the products, but it takes into account the next pages --
	    % If the number of products is more than 1 for this current page,
	    if (num_different_items_pages(current_page_number) > 0) then 
		Draw.FillBox (25, maxy - 210, maxx - 25, maxy - 100, 255)
		Draw.FillBox (30, maxy - 205, 130, maxy - 105, white)
		Draw.Text ("Dimensions: 1.25m x 0.5m x 0.5m", maxx div 2 - 180, maxy - 140, normal_text, white)
		Draw.Text ("$200.00", maxx - 100, maxy - 200, normal_text_description, white)
		Draw.Text ("x", maxx div 2 - 180, maxy - 200, normal_text_description, white)    
		% Draw the quantity box
		Draw.FillBox(maxx div 2 - 30, maxy div 2, maxx div 2 + 95, maxy div 2 + 30, white)
		Draw.Text("Quantity:", maxx div 2 - 28, maxy div 2 + 10, normal_text, 255)
		% Draw the plus sign
		Draw.FillBox(maxx div 2 + 60, maxy div 2 + 15, maxx div 2 + 70, maxy div 2 + 16, red)
		Draw.FillBox(maxx div 2 + 65, maxy div 2 + 20, maxx div 2 + 66, maxy div 2 + 10, red)
		% Draw the minus sign
		Draw.FillBox(maxx div 2 + 80, maxy div 2 + 15, maxx div 2 + 90, maxy div 2 + 16, 13)
		
		% What is the title of the game of this page, at the first position on the page?
		case game_title_items_pages (current_page_number) (1) of
		    label "item_snake_white":
			Draw.Text ("Snake: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
			Draw.Text (intstr(item_snake_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		    label "item_snake_brown":
			Draw.Text ("Snake: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
			Draw.Text (intstr(item_snake_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		    label "item_shapes_white":
			Draw.Text ("Shapes: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
			Draw.Text (intstr(item_shapes_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		    label "item_shapes_brown":
			Draw.Text ("Shapes: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
			Draw.Text (intstr(item_shapes_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		    label "item_space_white":
			Draw.Text ("Space Defenders: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
			Draw.Text (intstr(item_space_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		    label "item_space_brown":
			Draw.Text ("Space Defenders: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
			Draw.Text (intstr(item_space_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		    label "item_thief_white":
			Draw.Text ("Thief: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
			Draw.Text (intstr(item_thief_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		    label "item_thief_brown":
			Draw.Text ("Thief: the arcade game.", maxx div 2 - 180, maxy - 120, semi_title, white)
			Draw.Text (intstr(item_thief_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		end case
	    
	    % What is the color?
	    case color_items_pages (current_page_number) (1) of 
		label "white":
		    % Output the arcade machine picture
		    Pic.Draw (white_machine_smaller, 50, maxy - 203, 0)
		    % Output the color indicator
		    Draw.FillBox(maxx div 2 - 180, maxy div 2 + 20, maxx div 2 - 60, maxy div 2 + 40, white)
		    Draw.Text("Classic White", maxx div 2 - 175, maxy div 2 + 25, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)           
		label "brown":
		    Pic.Draw (brown_machine_smaller, 50, maxy - 203, 0)
		    Draw.FillBox(maxx div 2 - 180, maxy div 2 + 20, maxx div 2 - 60, maxy div 2 + 40, 41)
		    Draw.Text("Original Brown", maxx div 2 - 175, maxy div 2 + 25, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)  
	    end case
	    
	    end if 
	    
	    % Same code but shifted downwards
	    if (num_different_items_pages(current_page_number) >= 2) then
		
		Draw.FillBox (25, maxy - 210 - 120, maxx - 25, maxy - 100 - 120, 255)
		Draw.FillBox (30, maxy - 205 - 120, 130, maxy - 105 - 120, white)
		Draw.Text ("Dimensions: 1.25m x 0.5m x 0.5m", maxx div 2 - 180, maxy - 140 - 120, normal_text, white)
		Draw.Text ("$200.00", maxx - 100, maxy - 200 - 120, normal_text_description, white)
		Draw.Text ("x", maxx div 2 - 180, maxy - 200 - 120, normal_text_description, white)    
		% Draw the quantity box
		Draw.FillBox(maxx div 2 - 30, maxy div 2 - 120, maxx div 2 + 95, maxy div 2 + 30 - 120, white)
		Draw.Text("Quantity:", maxx div 2 - 28, maxy div 2 + 10 - 120, normal_text, 255)
		% Draw the plus sign
		Draw.FillBox(maxx div 2 + 60, maxy div 2 + 15 - 120, maxx div 2 + 70, maxy div 2 + 16 - 120, red)
		Draw.FillBox(maxx div 2 + 65, maxy div 2 + 20 - 120, maxx div 2 + 66, maxy div 2 + 10 - 120, red)
		% Draw the minus sign
		Draw.FillBox(maxx div 2 + 80, maxy div 2 + 15 - 120, maxx div 2 + 90, maxy div 2 + 16 - 120, 13) 
		
		% For the second position on the page now
		case game_title_items_pages (current_page_number) (2) of
		    label "item_snake_white":
			Draw.Text ("Snake: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
			Draw.Text (intstr(item_snake_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		    label "item_snake_brown":
			Draw.Text ("Snake: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
			Draw.Text (intstr(item_snake_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		    label "item_shapes_white":
			Draw.Text ("Shapes: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
			Draw.Text (intstr(item_shapes_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		    label "item_shapes_brown":
			Draw.Text ("Shapes: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
			Draw.Text (intstr(item_shapes_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		    label "item_space_white":
			Draw.Text ("Space Defenders: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
			Draw.Text (intstr(item_space_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		    label "item_space_brown":
			Draw.Text ("Space Defenders: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
			Draw.Text (intstr(item_space_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		    label "item_thief_white":
			Draw.Text ("Thief: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
			Draw.Text (intstr(item_thief_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		    label "item_thief_brown":
			Draw.Text ("Thief: the arcade game.", maxx div 2 - 180, maxy - 120 - 120, semi_title, white)
			Draw.Text (intstr(item_thief_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		end case
    
		case color_items_pages (current_page_number) (2) of 
		    label "white":
			% Output the arcade machine picture
			Pic.Draw (white_machine_smaller, 50, maxy - 203 - 120, 0)
			% Output the color indicator
			Draw.FillBox(maxx div 2 - 180, maxy div 2 + 20 - 120, maxx div 2 - 60, maxy div 2 + 40 - 120, white)
			Draw.Text("Classic White", maxx div 2 - 175, maxy div 2 + 25 - 120, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)           
		    label "brown":
			Pic.Draw (brown_machine_smaller, 50, maxy - 203 - 120, 0)
			Draw.FillBox(maxx div 2 - 180, maxy div 2 + 20 - 120, maxx div 2 - 60, maxy div 2 + 40 - 120, 41)
			Draw.Text("Original Brown", maxx div 2 - 175, maxy div 2 + 25 - 120, selection_box_selected, COLOR_SELECTION_BOX_SELECTED)  
		end case
	    end if
	
	% If the user clicks on go to check out then 
	elsif (((mouse_x >= maxx - 200 and mouse_x <= maxx - 20) and (mouse_y >= 10 and mouse_y <= 50)) and mouse_num = 1) then 
	    % Go to check out
	    return_value := "checkout"

	% Is it the + from the first box 
	elsif (((mouse_x >= maxx div 2 + 60 and mouse_x <= maxx div 2 + 70) and (mouse_y >= maxy div 2 + 10 and mouse_y <= maxy div 2 + 20)) and mouse_num = 1) then 
	    % Waits a bit so that the mouse clicks do not activate twice
	    Time.Delay(time_delay)
	    % Erases the previous quantity number
	    Draw.FillBox(maxx div 2 - 170, maxy - 200, maxx div 2 - 60, maxy div 2 + 18, 255)
	    % Depending on the game displayed in the box, increase the quantity and write the new number
	    case game_title_items_pages (current_page_number)(1) of
		label "item_snake_white": 
		    item_snake_white += 1
		    Draw.Text (intstr(item_snake_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		label "item_snake_brown":
		    item_snake_brown += 1
		    Draw.Text (intstr(item_snake_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		label "item_shapes_white":
		    item_shapes_white +=1
		    Draw.Text (intstr(item_shapes_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		label "item_shapes_brown":
		    item_shapes_brown += 1
		    Draw.Text (intstr(item_shapes_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		label "item_space_white":
		    item_space_white += 1
		    Draw.Text (intstr(item_space_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		label "item_space_brown":
		    item_space_brown += 1
		    Draw.Text (intstr(item_space_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		label "item_thief_white":
		    item_thief_white += 1
		    Draw.Text (intstr(item_thief_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		label "item_thief_brown":
		    item_thief_brown += 1
		    Draw.Text (intstr(item_thief_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
	    end case 
	    
	% The + sign from the second box
	elsif (((mouse_x >= maxx div 2 + 60 and mouse_x <= maxx div 2 + 70) and (mouse_y >= maxy div 2 + 10 - 120 and mouse_y <= maxy div 2 + 20 - 120)) and mouse_num = 1) then
	    % Waits a bit so that the mouse clicks do not activate twice
	    Time.Delay(time_delay)
	    % Erases the previous quantity number
	    Draw.FillBox(maxx div 2 - 170, maxy - 200 - 120, maxx div 2 - 60, maxy div 2 + 18 - 120, 255)
	    % Erases the previous quantity number
	    Draw.FillBox(maxx div 2 - 170, maxy - 200 - 120, maxx div 2 - 60, maxy div 2 + 18 - 120, 255)
	    % Depending on the game displayed in the box, increase the quantity and write the new number
	    case game_title_items_pages (current_page_number)(2) of
		label "item_snake_white": 
		    item_snake_white += 1
		    Draw.Text (intstr(item_snake_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		label "item_snake_brown":
		    item_snake_brown += 1
		    Draw.Text (intstr(item_snake_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		label "item_shapes_white":
		    item_shapes_white +=1
		    Draw.Text (intstr(item_shapes_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		label "item_shapes_brown":
		    item_shapes_brown += 1
		    Draw.Text (intstr(item_shapes_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		label "item_space_white":
		    item_space_white += 1
		    Draw.Text (intstr(item_space_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		label "item_space_brown":
		    item_space_brown += 1
		    Draw.Text (intstr(item_space_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		label "item_thief_white":
		    item_thief_white += 1
		    Draw.Text (intstr(item_thief_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		label "item_thief_brown":
		    item_thief_brown += 1
		    Draw.Text (intstr(item_thief_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
	    end case 

	% Is it the - from the first box
	elsif (((mouse_x >= maxx div 2 + 80 and mouse_x <= maxx div 2 + 90) and (mouse_y >= maxy div 2 + 10 and mouse_y <= maxy div 2 + 20)) and mouse_num = 1) then 
	    % Waits a bit so that mouse clicks don't activate twice
	    Time.Delay(time_delay)
	    % Erases the previous quantity number
	    Draw.FillBox(maxx div 2 - 170, maxy - 200, maxx div 2 - 60, maxy div 2 + 18, 255)
	    % Depending on the game displayed in the box, increase the quantity and write the new number
	    case game_title_items_pages (current_page_number)(1) of
		label "item_snake_white": 
		    % Do not let negative number of items
		    if (item_snake_white not= 0) then 
			item_snake_white -= 1
		    end if 
		    Draw.Text (intstr(item_snake_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		label "item_snake_brown":
		    if (item_snake_brown not= 0) then 
			item_snake_brown -= 1
		    end if 
		    Draw.Text (intstr(item_snake_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		label "item_shapes_white":
		    if (item_shapes_white not= 0) then 
			item_shapes_white -=1
		    end if 
		    Draw.Text (intstr(item_shapes_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		label "item_shapes_brown":
		    if (item_shapes_brown not= 0) then 
			item_shapes_brown -= 1
		    end if 
		    Draw.Text (intstr(item_shapes_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		label "item_space_white":
		    if (item_space_white not= 0) then 
			item_space_white -= 1
		    end if 
		    Draw.Text (intstr(item_space_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		label "item_space_brown":
		    if (item_space_brown not= 0) then 
			item_space_brown -= 1
		    end if 
		    Draw.Text (intstr(item_space_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		label "item_thief_white":
		    if (item_thief_white not= 0) then 
			item_thief_white -= 1
		    end if 
		    Draw.Text (intstr(item_thief_white), maxx div 2 - 170, maxy - 200, normal_text_description, white)
		label "item_thief_brown":
		    if (item_thief_brown not= 0) then 
			item_thief_brown -= 1
		    end if 
		    Draw.Text (intstr(item_thief_brown), maxx div 2 - 170, maxy - 200, normal_text_description, white)
	    end case
	
	% The - sign from the second box
	elsif (((mouse_x >= maxx div 2 + 80 and mouse_x <= maxx div 2 + 90) and (mouse_y >= maxy div 2 + 10 - 120 and mouse_y <= maxy div 2 + 20 - 120)) and mouse_num = 1) then 
	    % Waits a bit so that mouse clicks do not activate twice
	    Time.Delay(time_delay)
	    % Erases the previous quantity number
	    Draw.FillBox(maxx div 2 - 170, maxy - 200 - 120, maxx div 2 - 60, maxy div 2 + 18 - 120, 255)
	    % Depending on the game displayed in the box, increase the quantity and write the new number
	    case game_title_items_pages (current_page_number)(2) of
		label "item_snake_white": 
		    % Do not let negative number of items
		    if (item_snake_white not= 0) then
			item_snake_white -= 1
		    end if
		    Draw.Text (intstr(item_snake_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		label "item_snake_brown":
		    if (item_snake_brown not= 0) then 
			item_snake_brown -= 1
		    end if 
		    Draw.Text (intstr(item_snake_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		label "item_shapes_white":
		    if (item_shapes_white not= 0) then 
			item_shapes_white -=1
		    end if 
		    Draw.Text (intstr(item_shapes_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		label "item_shapes_brown":
		    if (item_shapes_brown not= 0) then 
			item_shapes_brown -= 1
		    end if 
		    Draw.Text (intstr(item_shapes_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		label "item_space_white":
		    if (item_space_white not= 0) then 
			item_space_white -= 1
		    end if 
		    Draw.Text (intstr(item_space_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		label "item_space_brown":
		    if (item_space_brown not= 0) then 
			item_space_brown -= 1
		    end if 
		    Draw.Text (intstr(item_space_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		label "item_thief_white":
		    if (item_thief_white not= 0) then 
			item_thief_white -= 1
		    end if 
		    Draw.Text (intstr(item_thief_white), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
		label "item_thief_brown":
		    if (item_thief_brown not= 0) then 
			item_thief_brown -= 1
		    end if 
		    Draw.Text (intstr(item_thief_brown), maxx div 2 - 170, maxy - 200 - 120, normal_text_description, white)
	    end case 
		
	end if
	    
	exit when return_value not= VOID
	
    end loop  

    % Delays time so mouse clicks do not transfer
    Time.Delay (time_delay)
    % Returns the next subprogram that should be run
    result return_value

end myCart


body function checkout

    cls
    % Erases the other window if there is a window
    if (summary_box not= 0) then 
	GUI.CloseWindow(summary_box)
    end if 
    % Resets the return value to void and the mouse integer values to -1
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1
    
    % Resets the variables used in this subprogram to default
    summary_spot := 1
    total_cost:= 0
    shipping_cost:= 0
    total_cost_with_tax := 0
    total_num_items := 0
    
    Time.Delay (time_delay)
    
    % - Draws the graphics before the loop --
    % Background
    Draw.FillBox (0, 0, maxx, maxy, 15)
    % Draws the back button
    Draw.FillOval (40, maxy - 40, 25, 25, white)
    Draw.FillBox (30, maxy - 45, 60, maxy - 35, 49)
    Draw.FillPolygon (polygon_x, polygon_y, 3, 49)
    Draw.Line (55, maxy - 45, 55, maxy - 35, 247)
    Draw.FillBox (57, maxy - 45, 60, maxy - 35, 247)
    % The title Checkout
    Draw.FillBox(maxx div 2 - 55, maxy - 60, maxx div 2 + 85, maxy - 15, 12)
    Draw.Text("Checkout", maxx div 2 - 50, maxy - 45, semi_title, 255)
    % The exit button
    Draw.FillBox(10, 20, 90, 40, 40)
    Draw.Text("Exit page", 15, 25, normal_text, 255)
    % The Place your order button
    Draw.FillBox(maxx - 160, maxy - 60, maxx - 5, maxy - 15, 41)
    Draw.Text("Place your order", maxx - 160, maxy - 45, semi_title_3, 255)
    
    % Draw the black box for shipping
    Draw.FillBox(25, maxy div 2 + 75, maxx - 25, maxy div 2 + 125, 255)
    % Draw the shipping: box
    Draw.FillBox(28, maxy div 2 + 110, 103, maxy div 2 + 123, white)
    Draw.Text("Shipping: ", 33, maxy div 2 + 113, normal_text_description, 255)
    % Draw the select service box
    Draw.FillBox(33, maxy div 2 + 78, 193, maxy div 2 + 105, white)
    % Prints the correct shipping method
    case shipping_method of
	label "premium":
	    Draw.Text("Premium Service", 38, maxy div 2 + 85, normal_text_description, 255)
	label "business":
	    Draw.Text("Business Class", 38, maxy div 2 + 85, normal_text_description, 255)
	label "eco":
	    Draw.Text("Eco Class", 38, maxy div 2 + 85, normal_text_description, 255)
	label: 
	    Draw.Text("Select service", 38, maxy div 2 + 85, normal_text, 255)
    end case
    % The arrow
    Draw.FillBox(163, maxy div 2 + 85, 170, maxy div 2 + 103, 255)
    Draw.FillPolygon(checkout_polygon_x, checkout_polygon_y, 3, 255)
    % Draw the to: address box
    Draw.FillBox(200, 305, maxx - 28, maxy div 2 + 123, white)
    Draw.Text("To:", 205, 310, normal_text_description, 255)
    % If the user has already entered an address, print that out
    if (address not= VOID) then 
	Draw.Text(address, 230, 310, normal_text_description, 255)
    end if
    % Draw the date box
    Draw.FillBox(200, maxy div 2 + 78, maxx - 28, 295, white)
    Draw.Text("Receiving date:", 205, maxy div 2 + 83, normal_text_description, 255)
    % Write the appropriate delivery date
    case shipping_method of
	 label "premium":
	    Draw.Text(date_premium, 300, maxy div 2 + 83, normal_text_description, 255)
	 label "business":
	    Draw.Text(date_business, 300, maxy div 2 + 83, normal_text_description, 255)
	 label "eco":
	    Draw.Text(date_eco, 300, maxy div 2 + 83, normal_text_description, 255)
	 label:
	    Draw.Text("", 300, maxy div 2 + 83, normal_text_description, 255)
    end case
    
    % Draw the method of payment: box
    Draw.FillBox(25, maxy div 2 - 97, maxx - 28, maxy div 2 - 80, white)
    Draw.Text("Method of payment:", 30, maxy div 2 - 93, normal_text_description, black)
    % Draw the select service box
    Draw.FillBox(180, maxy div 2 - 97, 320, maxy div 2 - 80, white)
    Draw.Box(180, maxy div 2 - 97, 320, maxy div 2 - 80, 255)
    % Print the appropriate card method
    case card_method of
	label "master":
	    Draw.Text("Master Card", 182, maxy div 2 - 95, normal_text_description, 255)
	label "visa":
	    Draw.Text("Visa Card", 182, maxy div 2 - 95, normal_text_description, 255)
	label "credit":
	    Draw.Text("Credit Card", 182, maxy div 2 - 95, normal_text_description, 255)
	label: 
	    Draw.Text("Select service", 182, maxy div 2 - 95, normal_text, 255)
    end case
    % The arrow
    Draw.FillBox(300, maxy div 2 - 92, 306, maxy div 2 - 82, 255)
    Draw.FillPolygon(checkout_polygon_2_x, checkout_polygon_2_y, 3, 255)
    % Enyer your information here
    Draw.FillBox(410, maxy div 2 - 97, 580, maxy div 2 - 80, yellow)
    Draw.Box(410, maxy div 2 - 97, 580, maxy div 2 - 80, 255)
    Draw.Text("Enter your information here", 412, maxy div 2 - 95, normal_text_description, 255)

    % Make a new window to display the summary box
    summary_box := Window.Open("position:bottom;center, graphics, maxx, maxy")
    Window.Select(summary_box)
    
    % Draw the summary box
    Draw.Text("Summary", 2, maxy - 35, normal_text_description, 255)
    % Loop through the values of the game titles array (which we already assigned values to in myCart) and output the appropriate text in the summary box
    for i : 1 .. 4
	for j : 1 .. 2 
	    % If the game title is not void, 
	    if (game_title_items_pages (i) (j) not= VOID) then 
		% Draw the item in the summary box
		Draw.Text(" items", 20, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
		Draw.Text("$", 238, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
		Draw.Text("$200", 265, maxy - 35 - (30 * summary_spot), normal_text_description, 255)
		% Find out what item it is and print out accordingly
		case game_title_items_pages (i)(j) of
		    label "item_snake_white":
			% Title
			Draw.Text("Snake: the arcade game - white", 2, maxy - 35 - (30 * summary_spot), normal_text_description, 255)
			% Quantity 
			Draw.Text(intstr(item_snake_white), 2, maxy - 35 - 30 * summary_spot - 11, normal_text_description, 255)
			% Total price
			Draw.Text(intstr(item_snake_white * 200), 245, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			% Add to the total cost
			total_cost += item_snake_white * 200
			% Add to the total number of items
			total_num_items += item_snake_white
		    label "item_snake_brown":
			Draw.Text("Snake: the arcade game - brown", 2, maxy - 35 - (30 * summary_spot), normal_text_description, 255)
			Draw.Text(intstr(item_snake_brown), 2, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			Draw.Text(intstr(item_snake_brown * 200), 245, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			total_cost += item_snake_brown * 200
			total_num_items += item_snake_brown
		    label "item_shapes_white":
			Draw.Text("Shapes: the arcade game - white", 2, maxy - 35 - (30 * summary_spot), normal_text_description, 255)
			Draw.Text(intstr(item_shapes_white), 2, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			Draw.Text(intstr(item_shapes_white * 200), 245, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			total_cost += item_shapes_white * 200
			total_num_items += item_shapes_white
		    label "item_shapes_brown":
			Draw.Text("Shapes: the arcade game - brown", 2, maxy - 35 - (30 * summary_spot), normal_text_description, 255)
			Draw.Text(intstr(item_shapes_brown), 2, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			Draw.Text(intstr(item_shapes_brown * 200), 245, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			total_cost += item_shapes_brown * 200
			total_num_items += item_shapes_brown
		    label "item_space_white":
			Draw.Text("Space Defense: the arcade game - white", 2, maxy - 35 - (30 * summary_spot), normal_text_description, 255)
			Draw.Text(intstr(item_space_white), 2, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			Draw.Text(intstr(item_space_white * 200), 245, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			total_cost += item_space_white * 200
			total_num_items += item_space_white
		    label "item_space_brown":
			Draw.Text("Space Defense: the arcade game - brown", 2, maxy - 35 - (30 * summary_spot), normal_text_description, 255)
			Draw.Text(intstr(item_space_brown), 2, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			Draw.Text(intstr(item_space_brown * 200), 245, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			total_cost += item_space_brown * 200
			total_num_items += item_space_brown
		    label "item_thief_white":
			Draw.Text("Thief: the arcade game - white", 2, maxy - 35 - (30 * summary_spot), normal_text_description, 255)
			Draw.Text(intstr(item_thief_white), 2, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			Draw.Text(intstr(item_thief_white * 200), 245, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			total_cost += item_thief_white * 200
			total_num_items += item_thief_white
		    label "item_thief_brown":
			Draw.Text("Thief: the arcade game - brown", 2, maxy - 35 - (30 * summary_spot), normal_text_description, 255)
			Draw.Text(intstr(item_thief_brown), 2, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			Draw.Text(intstr(item_thief_brown * 200), 245, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
			total_cost += item_thief_brown * 200
			total_num_items += item_thief_brown
		end case
		% Increases the count by 1 (the count is used to print successive items)
		summary_spot += 1
	    end if
	end for
    end for
    % Print the shipping cost
    Draw.Text("Shipping", 2, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
    Draw.Text("$", 238, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
    % Which method did the user select?
    case shipping_method of
	label "premium": 
	    % Display shipping cost
	    Draw.Text(intstr(PREMIUM * total_num_items), 245, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
	    % Add the cost of shipping
	    total_cost += PREMIUM * total_num_items
	label "business": 
	    Draw.Text(intstr(BUSINESS * total_num_items), 245, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
	    total_cost += BUSINESS * total_num_items
	label "eco":
	    Draw.Text(intstr(ECO * total_num_items), 245, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
	    total_cost += ECO * total_num_items
	label:
	    Draw.Text("", 245, maxy - 35 - (30 * summary_spot) - 11, normal_text_description, 255)
    end case
    % Print the number of items summary
    Draw.Text(intstr(total_num_items), 302, maxy - 35 - (30 * summary_spot) - 31, normal_text_description, 255)
    Draw.Text("items + shipping", 325, maxy - 35 - (30 * summary_spot) - 31, normal_text_description, 255)
    % Print the total without tax
    Draw.Text("Total before tax", 302, maxy - 35 - (30 * summary_spot) - 51, normal_text_description, 255)
    Draw.Text("$", 538, maxy - 35 - (30 * summary_spot) - 51, normal_text_description, 255)
    Draw.Text(realstr(total_cost, 1), 547, maxy - 35 - (30 * summary_spot) - 51, normal_text_description, 255)
    % Print the toal with tax
    Draw.Text("Total(    % tax)", 302, maxy - 35 - (30 * summary_spot) - 71, normal_text_description, 255)
    % Tax rate as a percentage
    Draw.Text(intstr(tax_rate div (1/100)), 335, maxy - 35 - (30 * summary_spot) - 71, normal_text_description, 255)
    Draw.Text("$", 538, maxy - 35 - (30 * summary_spot) - 71, normal_text_description, 255)
    % The total cost with tax 
    total_cost_with_tax := total_cost * (1 + tax_rate)
    Draw.Text(realstr(total_cost_with_tax, 1), 547, maxy - 35 - (30 * summary_spot) - 71, normal_text_description, 255)
    
    % Set the original screen as the active one
    Window.SetActive (defWinID)

    % Main subprogram loop
    loop
    
	Mouse.Where(mouse_x, mouse_y, mouse_num)
	
	% Find what button the user pressed
	if (mouse_num = 1) then 
	    % Did the user click the back button
	    if (((whatdotcolor(mouse_x, mouse_y) = 49 or whatdotcolor(mouse_x, mouse_y) = white or whatdotcolor(mouse_x, mouse_y) = 247) and mouse_num = 1) and ((mouse_x >= 15 and mouse_x <= 65) and (mouse_y >= maxy - 65 and mouse_y <= maxy - 15))) then
		return_value := "myCart"
	    % Did the user click the exit button
	    elsif ((mouse_x >= 10 and mouse_x <= 90) and (mouse_y >= 20 and mouse_y <= 40)) then
		return_value := "exitPage"
	    % The place your order button
	    elsif ((mouse_x >= maxx - 160 and mouse_x <= maxx - 5) and (mouse_y >= maxy - 60 and mouse_y <= maxy - 15)) then
		% Check if the user has selected a shipping method, has entered a card number, selected a card method, entered an address, entered a pin and entered an expirary date
		if (shipping_method not= VOID and card_checked and card_method not= VOID and address not= VOID and name not= VOID and pin_number not= -1 and expirary_date not= VOID) then
		    return_value := "orderConfirmation" 
		end if
		% If the shipping method is not selected
		if (shipping_method = VOID) then
		    % Draw the select service box but red
		    Draw.FillBox(33, maxy div 2 + 78, 193, maxy div 2 + 105, 40)
		    Draw.Text("Select service", 38, maxy div 2 + 85, normal_text, 255)
		    % The arrow
		    Draw.FillBox(163, maxy div 2 + 85, 170, maxy div 2 + 103, 255)
		    Draw.FillPolygon(checkout_polygon_x, checkout_polygon_y, 3, 255)
		end if 
		% If the card method is not selected 
		if (card_method = VOID) then
		    % Draw the method of payment service box but red
		    Draw.FillBox(180, maxy div 2 - 97, 320, maxy div 2 - 80, 40)
		    Draw.Box(180, maxy div 2 - 97, 320, maxy div 2 - 80, 255)
		    Draw.Text("Select service", 182, maxy div 2 - 95, normal_text, 255)
		     % The arrow
		    Draw.FillBox(300, maxy div 2 - 92, 306, maxy div 2 - 82, 255)
		    Draw.FillPolygon(checkout_polygon_2_x, checkout_polygon_2_y, 3, 255)
		end if 
		% If the user has not entered a card or the information about the card 
		if (not(card_checked) or name = VOID or pin_number = -1 or expirary_date = VOID) then 
		    % Draw the enter information box but red
		    Draw.FillBox(410, maxy div 2 - 97, 580, maxy div 2 - 80, 40)
		    Draw.Box(410, maxy div 2 - 97, 580, maxy div 2 - 80, 255)
		    Draw.Text("Enter your information here", 412, maxy div 2 - 95, normal_text_description, 255)
		end if
		if (address = VOID) then 
		    % Draw the address box but red
		    Draw.FillBox(200, 305, maxx - 28, maxy div 2 + 123, 40)
		    Draw.Text("To:", 205, 310, normal_text_description, 255)
		end if
	    % The enter your information button
	    elsif ((mouse_x >= 410 and mouse_x <= 580) and (mouse_y >= maxy div 2 - 97 and mouse_y <= maxy div 2 + 80)) then
		return_value := "cardInformation"
	    % Select service for shipping
	    elsif ((mouse_x >= 33 and mouse_x <= 193) and (mouse_y >= maxy div 2 + 78 and mouse_y <= maxy div 2 + 105)) then
		Draw.FillBox(33, maxy div 2 + 78, 193, maxy div 2 - 47, white)
		Draw.Text("Premium Service (2 days)", 35, maxy div 2 + 48, normal_text_description, 255)
		Draw.Text("Business Class (14 days)", 35, maxy div 2 + 18, normal_text_description, 255)
		Draw.Text("Eco Class (Up to 3 months)", 33, maxy div 2 - 12, normal_text_description, 255)
		% Enter a loop where the user has to click something
		loop 
		    Mouse.Where(mouse_x, mouse_y, mouse_num)
		    if (mouse_num = 1) then
			% Determine which shipping method the user clicked on and assigns that value to the shipping method
			if ((mouse_x >= 35 and mouse_x <= 193) and (mouse_y >= maxy div 2 + 35 and mouse_y <= maxy div 2 + 78)) then 
			    shipping_method := "premium"
			    % If the user chooses a shipping method, restart the subprogram to update the summary
			    return_value := "checkout"
			elsif ((mouse_x >= 35 and mouse_x <= 193) and (mouse_y >= maxy div 2 + 5 and mouse_y <= maxy div 2 + 34)) then
			    shipping_method := "business"
			    return_value := "checkout"
			elsif ((mouse_x >= 35 and mouse_x <= 193) and (mouse_y >= maxy div 2 - 47 and mouse_y <= maxy div 2 + 4)) then
			    shipping_method := "eco"
			    return_value := "checkout" 
			end if
			% Erases the box
			Draw.FillBox(33, maxy div 2 + 78, 193, maxy div 2 - 47, 15)
			Draw.FillBox(33, maxy div 2 + 78, 193, maxy div 2 + 75, 255)
		    end if
		    % Exit this loop when the user clicks something
		    exit when mouse_num = 1
		end loop
	    % Did the user click on the address box
	    elsif((mouse_x >= 200 and mouse_x <= maxx - 28) and (mouse_y >= 305 and mouse_y <= maxy div 2 + 123)) then 
		% Erase the text
		Draw.FillBox(200, 305, maxx - 28, maxy div 2 + 123, white)
		Draw.Text("To:", 205, 310, normal_text_description, 255)
		locatexy(230, 310)
		get address:*
	    % Did the user click on the select service for method of payment
	    elsif ((mouse_x >= 180 and mouse_x <= 320) and (mouse_y >= maxy div 2 - 97 and mouse_y <= maxy div 2 - 80)) then 
		Draw.FillBox(180, maxy div 2 - 97, 320, maxy div 2 - 222, white)
		Draw.Text("Master Card", 182, maxy div 2 - 127, normal_text_description, 255)
		Draw.Text("Visa Card", 182, maxy div 2 - 157, normal_text_description, 255)
		Draw.Text("Credit Card", 182, maxy div 2 - 187, normal_text_description, 255)
		% Enter a loop where the user has to click something
		loop 
		    Mouse.Where(mouse_x, mouse_y, mouse_num)
		    if (mouse_num = 1) then
			% Determine which shipping method the user clicked on and assigns that value to the shipping method
			if ((mouse_x >= 180 and mouse_x <= 320) and (mouse_y >= maxy div 2 - 135 and mouse_y <= maxy div 2 - 97)) then 
			    card_method := "master"
			    % If the user chooses a shipping method, restart the subprogram to update the summary
			    return_value := "checkout"
			elsif ((mouse_x >= 180 and mouse_x <= 320) and (mouse_y >= maxy div 2 - 165 and mouse_y <= maxy div 2 - 134)) then
			    card_method := "visa"
			    return_value := "checkout"
			elsif ((mouse_x >= 180 and mouse_x <= 320) and (mouse_y >= maxy div 2 - 222 and mouse_y <= maxy div 2 - 164)) then
			    card_method := "credit"
			    return_value := "checkout" 
			end if
			% Erases the box 
			Draw.FillBox(180, maxy div 2 - 222, 320, maxy div 2 - 97, 15)
		    end if
		    % Exit this loop when the user clicks something
		    exit when mouse_num = 1
		end loop
	    end if
			    
	end if
	
	exit when return_value not= VOID   
	
    end loop

    % Returns the next subprogram that should be run
    result return_value
     
end checkout


body function cartConfirmation
    cls
    % Resets the return value to void and the mouse integer values to -1
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1

    Time.Delay (time_delay)

    % - Draws graphics before loop --
    % Background
    Draw.FillBox (0, 0, maxx, maxy, 15)
    % Question title
    Draw.Text("Are you sure you want to add the following to your cart?", 50, maxy - 20, semi_title_3, 255)
    % The whtie rectangle
    Draw.FillBox(50, maxy - 220, maxx - 50, maxy - 30, white)
    % The Yes button
    Draw.FillBox(200, maxy - 300, 280, maxy - 240, 10)
    Draw.Text("Yes", 215, maxy - 280, semi_title, 255)
    % The No button
    Draw.FillBox(maxx - 280, maxy - 300, maxx - 200, maxy - 240, 12)
    Draw.Text("No", maxx - 255, maxy - 280, semi_title, 255)
    % The number of items 
    Draw.Text("x", maxx - 185, maxy - 45, normal_text, 255)
    Draw.Text(intstr(num_items_chosen), maxx - 179, maxy - 45, normal_text, 255)
    % The cost of the item
    Draw.Text("$", maxx - 150, maxy - 45, normal_text, 255)
    Draw.Text(intstr(200 * num_items_chosen), maxx - 130, maxy - 45, normal_text, 255)

    % Prints out the item that is being added to cart 
    case item_confirm of 
	label "item_snake_white":
	    Draw.Text("Snake: the arcade game, classic white", 51, maxy - 45, normal_text, 255)
	label "item_snake_brown":
	    Draw.Text("Snake: the arcade game, original brown", 51, maxy - 45, normal_text, 255)
	label "item_shapes_white":
	    Draw.Text("Shapes: the arcade game, classic white", 51, maxy - 45, normal_text, 255)
	label "item_shapes_brown":
	    Draw.Text("Shapes: the arcade game, original brown", 51, maxy - 45, normal_text, 255)
	label "item_space_white":
	    Draw.Text("Space Defense: the arcade game, classic white", 51, maxy - 45, normal_text, 255)
	label "item_space_brown":
	    Draw.Text("Space Defense: the arcade game, original brown", 51, maxy - 45, normal_text, 255)
	label "item_thief_white":
	    Draw.Text("Space Defense: the arcade game, classic white", 51, maxy - 45, normal_text, 255)
	label "item_thief_brown":
	    Draw.Text("Space Defnese: the arcade game, original brown", 51, maxy - 45, normal_text, 255)
    end case
    
    %Main subprogram loop
    loop
    
	Mouse.Where(mouse_x, mouse_y, mouse_num)

	% Checks if the user presses no or yes 
	if (((mouse_x >= 200 and mouse_x <= 280) and (mouse_y >= maxy - 300 and mouse_y <= maxy - 240)) and mouse_num = 1) then
	    do_add := true
	    return_value := "myCart"
	elsif (((mouse_x >= maxx - 280 and mouse_x <= maxx - 200) and (mouse_y >= maxy - 300 and mouse_y <= maxy - 240)) and mouse_num = 1) then
	    do_add := false
	    return_value := "myCart"
	end if

	exit when return_value not= VOID
	
    end loop
    
    % If the user pressed yes, add that item(s) to the cart
    if (do_add) then 
	case item_confirm of 
	    label "item_snake_white":
		item_snake_white += num_items_chosen
	    label "item_snake_brown":
		item_snake_brown += num_items_chosen
	    label "item_shapes_white":
		item_shapes_white += num_items_chosen
	    label "item_shapes_brown":
		item_shapes_brown += num_items_chosen
	    label "item_space_white":
		item_space_white += num_items_chosen 
	    label "item_space_brown":
		item_space_brown += num_items_chosen
	    label "item_thief_white":
		item_thief_white += num_items_chosen
	    label "item_thief_brown":
		item_thief_brown += num_items_chosen
	end case
    end if


    % Returns the next subprogram that should be run
    result return_value

end cartConfirmation


body function orderConfirmation

    cls
    % Resets the return value to void and the mouse integer values to -1
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1

    Time.Delay (time_delay)
    
    % Draw the graphics before the subprogram loop 
    % Draw the graphics before the subprogram loop 
    % Draw the background
    Draw.FillBox(0, 0, maxx, maxy, 15)
    % The title text
    Draw.Text("Are you sure you want to place your order?", 38, maxy - 30, semi_title, 255)
    % The white box
    Draw.FillBox(100, 200, maxx - 100, maxy - 60, white)
    % Draw the yes box
    Draw.FillBox(170, 10, 230, 60, 10)
    Draw.Text("Yes", 175, 25, semi_title, 255)
    % Draw the  no box
    Draw.FillBox(maxx - 230, 10, maxx - 170, 60, 40)
    Draw.Text("No", maxx - 220, 25, semi_title, 255)
    % Draw the text
    Draw.Text("Please look at the summary window and verify that order is correct", 105, 310, normal_text_description, 255)
    Draw.Text("Please verify your address and shipping service you selected", 105, 290, normal_text_description, 255)
    % The Address 
    Draw.Text("Your address:", 105, 250, normal_text_description, 255)
    Draw.Text(address, 190, 250, normal_text_description, 255)
    % The Shipping method
    Draw.Text("The shipping method you chose:", 105, 230, normal_text_description, 255)
    % Prints the correct shipping method
    case shipping_method of
	label "premium":
	    Draw.Text("Premium Service", 300, 230, normal_text_description, 255)
	label "business":
	    Draw.Text("Business Class", 300, 230, normal_text_description, 255)
	label "eco":
	    Draw.Text("Eco Class", 300, 230, normal_text_description, 255)
	label: 
	    Draw.Text("Select service", 300, 230, normal_text_description, 255)
    end case
    
    % Main subprogram loop
    loop
    
	Mouse.Where(mouse_x, mouse_y, mouse_num)
	
	% If the user clicks something
	if (mouse_num = 1) then
	    % If the user clicks yes 
	    if ((mouse_x >= 170 and mouse_x <= 230) and (mouse_y >= 10 and mouse_y <= 60)) then 
		% Take the user to the pay page
		return_value := "payPage"
	     % If the user clicks no
	    elsif ((mouse_x >= maxx - 230 and mouse_x <= maxx - 170) and (mouse_y >= 10 and mouse_y <= 60)) then
		% Take the user back to check out
		return_value := "checkout"
	    end if
	end if
	
	exit when return_value not= VOID
	
    end loop

    % Returns the next subprogram that should be run
    result return_value

end orderConfirmation


body function cardInformation

    cls
    % Resets the return value to void and the mouse integer values to -1
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1
    
    % Resets the values used in this subprogram to default
    number_of_digits := 0
    number_of_digits_2 := 0
    digit_sum := 0
    luhn_weight := 1

    Time.Delay (time_delay)
    
    % Draws the graphics before the subprogram loops
    % Background
    Draw.FillBox (0, 0, maxx, maxy, 15)
    % Draws the back button
    Draw.FillOval (40, maxy - 40, 25, 25, white)
    Draw.FillBox (30, maxy - 45, 60, maxy - 35, 49)
    Draw.FillPolygon (polygon_x, polygon_y, 3, 49)
    Draw.Line (55, maxy - 45, 55, maxy - 35, 247)
    Draw.FillBox (57, maxy - 45, 60, maxy - 35, 247)
    % The title card info
    Draw.FillBox(maxx div 2 - 45, maxy - 60, maxx div 2 + 85, maxy - 15, yellow)
    Draw.Text("Card Info", maxx div 2 - 40, maxy - 45, semi_title, 255)
    % The black box 
    Draw.FillBox(10, 5, maxx - 10, maxy - 70, 255)
    % The button go back to check out
    Draw.FillBox(maxx - 240, 10, maxx - 10, 50, 10)
    Draw.Text("Go back to check out", maxx - 232, 23, check_out_font, 255)
    % The exit button
    Draw.FillBox(10, 20, 90, 40, 40)
    Draw.Text("Exit page", 15, 25, normal_text, 255)
    % Write The text
    Draw.Text("My Information: ", 20, maxy - 95, normal_text, white)
    Draw.Text("Name on Card:", 80, maxy - 140, normal_text_description, white)
    Draw.Text("Card Number:", 87, maxy - 170, normal_text_description, white)
    Draw.Text("Pin:", 145, maxy - 200, normal_text_description, white)
    Draw.Text("Expirary Date: ", 85, maxy - 230, normal_text_description, white)
    % Draw the text boxes
    % Name
    if (name = VOID) then 
	Draw.FillBox(175, maxy - 150, maxx - 30, maxy - 125, white)
	Draw.Text("Enter your name and then press enter", 178, maxy - 140, normal_text_description_italics, 255)
    else 
	Draw.FillBox(175, maxy - 150, maxx - 30, maxy - 125, white)
	Draw.Text(name, 178, maxy - 140, normal_text_description, 255)        
    end if
    % Card Number
    Draw.FillBox(175, maxy - 180, maxx - 30, maxy - 155, white)
    Draw.Text("Enter your card number *hit enter once after the first eight digits", 178, maxy - 170, normal_text_description_italics, 255)
    % Pin 
    Draw.FillBox(175, maxy - 210, maxx - 30, maxy - 185, white)
    Draw.Text("Enter your Pin and then press enter", 178, maxy - 200, normal_text_description_italics, 255)
    % Expiary Date
    if (expirary_date = VOID) then 
	Draw.FillBox(175, maxy - 240, maxx - 30, maxy - 215, white)
	Draw.Text("Enter your expirary date on your card and then press enter", 178, maxy - 230, normal_text_description_italics, 255)
    else 
	Draw.FillBox(175, maxy - 240, maxx - 30, maxy - 215, white)
	Draw.Text(expirary_date, 178, maxy - 230, normal_text_description, 255)        
    end if
    
    % Main subprogram loop
    loop
    
	Mouse.Where(mouse_x, mouse_y, mouse_num)
    
	if (mouse_num = 1) then 
	    % Did the user click the back button
	    if (((whatdotcolor(mouse_x, mouse_y) = 49 or whatdotcolor(mouse_x, mouse_y) = white or whatdotcolor(mouse_x, mouse_y) = 247) and mouse_num = 1) and ((mouse_x >= 15 and mouse_x <= 65) and (mouse_y >= maxy - 65 and mouse_y <= maxy - 15))) then
		return_value := "checkout"
	    % Did the user click the exit button
	    elsif ((mouse_x >= 10 and mouse_x <= 90) and (mouse_y >= 20 and mouse_y <= 40)) then
		return_value := "exitPage"
	    % If the user clicks on the name field
	    elsif ((mouse_x >= 175 and mouse_x <= maxx - 30) and (mouse_y >= maxy - 150 and mouse_y <= maxy - 130)) then
		% Erase the text
		Draw.FillBox(175, maxy - 150, maxx - 30, maxy - 125, white)
		% Get the name input (locates the input to the textbox)
		locatexy(178, maxy - 143)
		get name:*
	    % Card number 
	    elsif ((mouse_x >= 175 and mouse_x <= maxx - 30) and (mouse_y >= maxy - 180 and mouse_y <= maxy - 160)) then 
		% Erases the text
		Draw.FillBox(175, maxy - 180, maxx - 30, maxy - 155, white)
		% Get the first eight digits of the card number
		locatexy(178, maxy - 173)
		get card_number_1_string:*
		% Checks if the user entered an appropirate value
		if (card_number_1_string >= '0' and card_number_1_string <= '9') then 
		    card_number_1 := strint(card_number_1_string)
		end if
		% Get the second eight digits
		locatexy(250, maxy - 173)
		get card_number_2_string:*
		% Check if the user entered an appropriate value
		if (card_number_2_string >= '0' and card_number_2_string <= '9') then 
		    card_number_2 := strint(card_number_2_string)
		end if
		% Credit card verification with check sum algorithm 
		% Use luhn algorithm to determine if the card is valid
		% Check if the card number is 16 digits only then continue
		if ((card_number_1 >= 10000000 and card_number_1 < 100000000) and (card_number_2 >= 10000000 and card_number_2 < 100000000)) then 
		
		    % First get the digits of the card number which is represented as an int to be represented as individual digits
		    loop
			% Set the digit to the card number divided by the power of 10 higher and most closest to it and then divide that number by the power of 10 that is lowest and the most closest to it, this gets the digit
			the_digit := (card_number_1 mod 10**(number_of_digits + 1)) div 10**(number_of_digits)
			% Exit the loop when the power of 10 we are dividing the card number by is an order of magnitude higher than it
			exit when 10**(number_of_digits + 1) > card_number_1 * 10 
			% Increase the number of digits by 1 
			number_of_digits += 1
			% Give the digit a position in the array
			card_numbers_array(number_of_digits) := the_digit
		    end loop
		    
		    % Repeat the code, but for the second half
		    loop
			the_digit := (card_number_2 mod 10**(number_of_digits_2 + 1)) div 10**(number_of_digits_2)
			% If we were to resue number_of_digits, there would be an integer overflow here
			exit when 10**(number_of_digits_2 + 1) > card_number_2 * 10 
			number_of_digits_2 += 1
			% +8 to fill the array
			card_numbers_array(number_of_digits_2 + 8) := the_digit
		    end loop
		    
		    % Use luhn algorithm to determine if the card is valid
		    for i : 1 .. 16
			% If the weight is 1
			if (luhn_weight = 1) then
			    % Add the digit in the array to digt sum 
			    digit_sum += card_numbers_array(i)
			    % Reasigns the weight to 2
			    luhn_weight := 2
			% If the weight is 2
			else
			    % If the digit times 2 is one digit
			    if (card_numbers_array(i) * 2 < 10) then 
				% Add the digit in the array times 2 to digit sum
				digit_sum += card_numbers_array(i) * 2
			    % If not
			    else
				% Add the sum of the digits to the digit sum, we can assume the tens digit is 1
				digit_sum += 1 + ((card_numbers_array(i) * 2) mod 10)
			    end if 
			    % Reasigns the weight to 1
			    luhn_weight := 1
			end if
		    end for
		    
		    % If the ones digit of the digit sum is 0, then the algorithm saids it is valid
		    if (digit_sum mod 10 = 0) then 
			card_checked := true
		    else
			card_checked := false
		    end if
		    
		else 
		    % Make it so that the card is not valid
		    card_checked := false
		end if
		
		% If the card number is not valid, draw a red box and write that it is invalid
		if (not card_checked) then 
		    Draw.FillBox(175, maxy - 180, maxx - 30, maxy - 155, 40)
		    Draw.Text("Invalid Card Number", 178, maxy - 170, normal_text_description_italics, 255)
		end if
	    % Pin
	    elsif ((mouse_x >= 175 and mouse_x <= maxx - 30) and (mouse_y >= maxy - 210 and mouse_y <= maxy - 190)) then
		% Erases the text
		Draw.FillBox(175, maxy - 210, maxx - 30, maxy - 185, white)
		% Get the pin number 
		locatexy(178, maxy - 203)
		get pin_number_string:*
		% Check to see if the pin is an integer
		if (pin_number_string >= '0' and pin_number_string <= '9') then
		    pin_number := strint(pin_number_string)
		end if
	    % Expirary date
	    elsif ((mouse_x >= 175 and mouse_x <= maxx - 30) and (mouse_y >= maxy - 240 and mouse_y <= maxy - 220)) then 
		% Erases the text
		Draw.FillBox(175, maxy - 240, maxx - 30, maxy - 215, white)
		% Get the date
		locatexy(178, maxy - 233)
		get expirary_date:*
	    % Go back to check out
	    elsif ((mouse_x >= maxx - 240 and mouse_x <= maxx - 10) and (mouse_y >= 10 and mouse_y <= 50)) then
		return_value := "checkout"
	    end if 
	end if
	
	exit when return_value not= VOID
	
    end loop

    % Returns the next subprogram that should be run
    result return_value

end cardInformation


% Displays the page where the user pays
body function payPage

    cls
    % Resets the return value to void and the mouse integer values to -1
    return_value := VOID
    mouse_x := -1
    mouse_y := -1
    mouse_num := -1
    
    % Resets the values used in this subprogram to default
    payPage_counter := 0
    
    % Draw the graphics before the subprogram loop starts
    % Draw the background
    Draw.FillBox(0, 0, maxx, maxy, 15)
    % Draw the white box
    Draw.FillBox(50, 10, maxx - 50, maxy - 10, white)
    % Set the amount left to the total cost 
    amount_left := total_cost_with_tax
    
    Time.Delay (time_delay)

    % Main subprogram loop
    loop
    
	% If the screen is already full, clear the pay box and start at the top
	if (payPage_counter = 22) then
	    Draw.FillBox(50, 10, maxx - 50, maxy - 10, white)
	    payPage_counter := 0
	end if

	% Move the output and input down by the counter
	locatexy(60, maxy - 40 - payPage_counter * 16)
	
	% If the amount left is less than 0 or equal to 0, the user is done paying and output the change
	if (amount_left <= 0) then 
	    put "Change: $", amount_left * -1 : 0 : 2
	    % Wait a bit before ending the subprogram
	    Time.Delay(time_delay + 4000)
	% If the amount left is more than 0, write amount left 
	else
	    put "Amount left: $", amount_left : 0 : 2
	end if
	
	% Exit the loop when the user is done paying
	exit when amount_left <= 0
	
	% Move the ouput down
	payPage_counter += 1
	locatexy(60, maxy - 40 - payPage_counter * 16)
	
	% Prompt the user for the amount they payed
	put "Pay: $"..
	get amount_payed_string:*
	% Check if the amount payed is a number
	if (amount_payed_string >= '0' and amount_payed_string <= '9') then 
	    amount_payed := strreal(amount_payed_string)
	end if
	% Subtract amount payed from amount left
	amount_left := amount_left - amount_payed
	
	% Increase the counter to move the output down
	payPage_counter += 1

	% Redraw the borders
	Draw.FillBox(0, 0, 50, maxy - 10, 15)
	Draw.FillBox(maxx - 50, 0, maxx, maxy, 15)
	
    end loop

    % Returns the next subprogram that should be run
    result "exitPage"
    
end payPage


body procedure exitPage
    cls
    Draw.FillBox (0, 0, maxx, maxy, 15)
    Draw.FillBox (50, 50, maxx - 50, maxy - 50, 255)
    Draw.Text ("Thank you for shopping at", 130, maxy - 170, semi_title_2, 100)
    Draw.Text ("Authentic Arcade Games", 145, maxy - 220, semi_title_2, 100)
    program_running := false
end exitPage



% Where the program begins -------------------------------------------------------------------------------------------------------------------------------------------------------

% Clear everything
cls

% Asks the user for the date, this date will be used in determining the delivery date for shipping options
loop
    put "Enter the day: "..
    get day_string
    % Make sure the input is a number so that the program do not crash
    if (day_string >= '0' and day_string <= '9') then 
	day := strint(day_string)
    end if 
    put "Enter the month (1-12): "..
    get month_string
    if (month_string >= '0' and month_string <= '9') then 
	month := strint(month_string)
    end if 
    put "Enter the year: "..
    get year_string
    if (year_string >= '0' and year_string <= '9') then 
	year := strint(year_string)
    end if 
    % Determine the number of days in the month the user entered
    case month of
	label 1: 
	    num_days := JAN
	label 2: 
	    num_days := FEB
	label 3: 
	    num_days := MAR
	label 4: 
	    num_days := APR 
	label 5: 
	    num_days := MAY
	label 6: 
	    num_days := JUN
	label 7: 
	    num_days := JUL
	label 8: 
	    num_days := AUG
	label 9: 
	    num_days := SEP
	label 10: 
	    num_days := OCT
	label 11:
	    num_days := NOV
	label 12: 
	    num_days := DEC
	% Make the loop loop again
	label: 
	    num_days := 0
    end case
    % Asks the user until they enter a possible date
    exit when day >= 1 and day <= num_days and month >= 1 and month <= 12
    put "Please enter the correct day or month"
end loop

% Calculates the delivery dates for each shipping options and creates strings to be printed at checkout

% Premium
if (day + 2 <= num_days) then 
    day_delivery := day + 2
    month_delivery := month
    year_delivery := year
% If the months move 
else 
    % If the month is the last month
    if (month = 12) then 
	day_delivery := (num_days - day - 2) * -1
	month_delivery := 1
	year_delivery := year + 1
    else 
	day_delivery := (num_days - day - 2) * -1
	month_delivery := month + 1
	year_delivery := year
    end if
end if 

case month_delivery of
    label 1: 
	month_in_words:= "January"
    label 2: 
	month_in_words:= "Feburary"
    label 3: 
	month_in_words:= "March"
    label 4: 
	month_in_words:= "April" 
    label 5: 
	month_in_words:= "May"
    label 6: 
	month_in_words:= "June"
    label 7: 
	month_in_words:= "July"
    label 8: 
	month_in_words:= "August"
    label 9: 
	month_in_words:= "September"
    label 10: 
	month_in_words:= "October"
    label 11:
	month_in_words:= "November"
    label 12: 
       month_in_words:= "December"
end case 

date_premium := intstr(day_delivery) + " " + month_in_words + " " + intstr(year_delivery)

% Business
if (day + 14 <= num_days) then 
    day_delivery := day + 14
    month_delivery := month
    year_delivery := year
% If the months move 
else 
    % If the month is the last month
    if (month = 12) then 
	day_delivery := (num_days - day - 14) * -1
	month_delivery := 1
	year_delivery := year + 1
    else 
	day_delivery := (num_days - day - 14) * -1
	month_delivery := month + 1
	year_delivery := year
    end if
end if 

case month_delivery of
    label 1: 
	month_in_words:= "January"
    label 2: 
	month_in_words:= "Feburary"
    label 3: 
	month_in_words:= "March"
    label 4: 
	month_in_words:= "April" 
    label 5: 
	month_in_words:= "May"
    label 6: 
	month_in_words:= "June"
    label 7: 
	month_in_words:= "July"
    label 8: 
	month_in_words:= "August"
    label 9: 
	month_in_words:= "September"
    label 10: 
	month_in_words:= "October"
    label 11:
	month_in_words:= "November"
    label 12: 
       month_in_words:= "December"
end case 

date_business := intstr(day_delivery) + " " + month_in_words + " " + intstr(year_delivery)

% Eco
if (month <= 9) then 
    day_delivery := day
    month_delivery := month + 3
    year_delivery := year
else 
    day_delivery := day
    case month of
	label 10: 
	    month_delivery := 1
	label 11:
	    month_delivery := 2
	label 12: 
	    month_delivery := 3
    end case
    year_delivery := year + 1
end if

case month_delivery of
    label 1: 
	month_in_words:= "January"
    label 2: 
	month_in_words:= "Feburary"
    label 3: 
	month_in_words:= "March"
    label 4: 
	month_in_words:= "April" 
    label 5: 
	month_in_words:= "May"
    label 6: 
	month_in_words:= "June"
    label 7: 
	month_in_words:= "July"
    label 8: 
	month_in_words:= "August"
    label 9: 
	month_in_words:= "September"
    label 10: 
	month_in_words:= "October"
    label 11:
	month_in_words:= "November"
    label 12: 
       month_in_words:= "December"
end case 

date_eco := intstr(day_delivery) + " " + month_in_words + " " + intstr(year_delivery)

% More complicated tax calculation
% Asks the user to enter the province they are in and set the tax rate to that province's rate
loop
    put "This represents the website receiving the user's location when the user visits the website. Enter the province you are in: " ..
    get province : *
    exit_sign := true
    case province of
	label "Alberta", "ALBERTA", "AB", "alberta" :
	    tax_rate := ALBERTA
	label "British Columbia", "BRITISH COLUMBIA", "british columbia", "BC" :
	    tax_rate := BC
	label "Manitoba", "MANITOBA", "manitoba", "MB" :
	    tax_rate := MANITOBA
	label "New Brunswick", "NEW BRUNSWICK", "new brunswick", "NB" :
	    tax_rate := NEW_BRUNSWICK
	label "Newfoundland and Labrador", "NEWFOUNDLAND AND LABRADOR", "newfoundland and labrador", "NL" :
	    tax_rate := NEWFOOUNDLAND_AND_LABRADOR
	label "Northwest Territories", "NORTHWEST TERRITORIES", "northwest territories", "NT" :
	    tax_rate := NORTHWEST_TERRITORIES
	label "Nova Scotia", "NOVA SCOTIA", "nova scotia", "NS" :
	    tax_rate := NOVA_SCOTIA
	label "Nunavut", "NUNAVUT", "nunavut", "NU" :
	    tax_rate := NUNAVUT
	label "Ontario", "ONTARIO", "ontario", "ON" :
	    tax_rate := ONTARIO
	label "Prince Edward Island", "PRINCE EDWARD ISLAND", "prince edward island", "PEI", "pei" :
	    tax_rate := PEI
	label "Quebec", "QUEBEC", "quebec", "QC" :
	    tax_rate := QUEBEC
	label "Saskatchewan", "SASKATCHEWAN", "saskatchewan", "SK" :
	    tax_rate := SASKATCHEWAN
	label "Yukon", "YUKON", "yukon", "YT" :
	    tax_rate := YUKON
	label :
	    exit_sign := false
    end case

    exit when exit_sign = true
end loop
cls

now_running := "welcome"

% This is the main program loop
loop
    case now_running of
	label "welcome" :
	    now_running := welcome
	label "gameSnake" :
	    now_running := gameSnake
	label "gameShapes" :
	    now_running := gameShapes
	label "gameSpace" :
	    now_running := gameSpace
	label "gameThief" :
	    now_running := gameThief
	label "pageSnake" :
	    now_running := pageSnake
	label "pageShapes" :
	    now_running := pageShapes
	label "pageSpace" :
	    now_running := pageSpace
	label "pageThief" :
	    now_running := pageThief
	label "myCart":
	    now_running := myCart
	label "checkout": 
	    now_running := checkout
	label "cartConfirmation":
	    now_running := cartConfirmation
	label "orderConfirmation":
	    now_running := orderConfirmation
	label "cardInformation":
	    now_running := cardInformation
	label "payPage":
	    now_running := payPage
	label "exitPage" :
	    exitPage
    end case
    exit when program_running = false
end loop


