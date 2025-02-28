mod_dir = '' .. SMODS.current_mod.path


-- SMODS.Atlas({
--     key = "Uiuatro",
--     atlas_table = "ASSET_ATLAS",
--     path = "jokers.png",
--     px = 71,
--     py = 95,
-- })


-- local function init_joker(joker, no_sprite)
--     no_sprite = no_sprite or false

--     --joker.atlas = "Uiuatro"
--     local joker = SMODS.Joker(joker)
-- end

-- local test_joker = {
--     key = "test",
--     config = {
--         extra = {
--             dollars = 5,
--             trash_list = {}
--         },
--     },
--     rarity = 4,
--     cost = 20,
--     unlocked = true,
--     discovered = true,
--     blueprint_compat = false,
--     eternal_compat = true,
--     pos = { x = 5, y = 3 },
--     soul_pos = { x = 0, y = 4 }
-- }

-- function test_joker.loc_vars(self, info, card)
--     return { vars = { card.ability.extra.dollars } }
-- end

-- -- Initialize Joker
-- init_joker(test_joker)

-- added game states

if not UIUATRO then UIUATRO = {} end

UIUATRO.stack_hand = nil;
UIUATRO.stack_deck = nil;



function UIUATRO:hide_stack_hand()
    self.stack_hand.states.visible = false

    
end

function UIUATRO:show_stack_hand()
    self.stack_hand.states.visible = true
end

local game_state = -1;
local on_game_state_change
on_game_state_change = Event({
    func = function()
        if G.STATE == game_state then
            return false
        end

        game_state = G.STATE;
        G.E_MANAGER:add_event(on_game_state_change)


        if (G.STATE == G.STATES.SELECTING_HAND) then
            UIUATRO:show_stack_hand()
        else
            UIUATRO:hide_stack_hand()
        end

        return true
    end,
    blocking = false
})

function UIUATRO:start_up()

end

function UIUATRO:set_up_ui()
    print("setting up uiuatro ui")

    self.stack_hand = CardArea(
        0, 0,
        6 * G.CARD_W, 0.95 * G.CARD_H,
        { card_limit = G.GAME.starting_params.hand_size, type = 'hand' }
    )

    self.stack_deck = CardArea(
        0, 0,
        G.CARD_W * 1.1, 0.95 * G.CARD_H,
        { card_limit = 52, type = 'deck' })

    G.E_MANAGER:add_event(on_game_state_change)
end

function UIUATRO:set_screen_positions()
    print("setting positions")

    self.stack_hand.T.x = G.TILE_W - self.stack_hand.T.w - 2.85
    self.stack_hand.T.y = G.TILE_H - self.stack_hand.T.h - 5.5
    self.stack_hand:hard_set_VT()

    self.stack_deck.T.x = G.TILE_W - self.stack_deck.T.w - 0.5
    self.stack_deck.T.y = G.TILE_H - self.stack_deck.T.h - 4
    self.stack_deck:hard_set_VT()
end

function doThing(e)
    print("i pressed")
    if (G.STATE == G.STATES.SELECTING_HAND) then
        draw_card(G.hand, UIUATRO.stack_deck, 1, 'up', true)

        draw_card(UIUATRO.stack_deck, UIUATRO.stack_hand, 1, 'up', true)
    end
end

SMODS.Keybind({ key_pressed = "i", action = doThing })
