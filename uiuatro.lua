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


UIUATRO.STATES = {
    SELECTING_STACK_HAND = 42,
}


UIUATRO.secondHand = nil;

function UIUATRO:start_up()

end

function UIUATRO:set_up_ui()
    print("setting up uiuatro ui")

    self.secondHand = CardArea(
        0, 0,
        6*G.CARD_W, 0.95*G.CARD_H,
        { card_limit = G.GAME.starting_params.hand_size, type = 'hand' }
    )

end

function UIUATRO:set_screen_positions()
    print("setting positions")

    self.secondHand.T.x = G.TILE_W - self.secondHand.T.w - 2.85
    self.secondHand.T.y = G.TILE_H - self.secondHand.T.h - 4.8
    self.secondHand:hard_set_VT()

end


function doThing(e)
    print("i pressed")
    if (G.STATE == G.STATES.SELECTING_HAND) then 
        draw_card(G.deck, UIUATRO.secondHand, 50, 'up', true)
    end
end

SMODS.Keybind({key_pressed = "i", action = doThing})







