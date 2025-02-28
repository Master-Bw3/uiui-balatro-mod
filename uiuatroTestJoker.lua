local function init_joker(joker, no_sprite)
    no_sprite = no_sprite or false

    joker.atlas = "Uiuatro"
    local joker = SMODS.Joker(joker)
end

local test_joker = {
    key = "test",
    config = {
        extra = {
            dollars = 5,
            trash_list = {}
        },
    },
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    pos = { x = 5, y = 3 },
    soul_pos = { x = 0, y = 4 }
}

function test_joker.loc_vars(self, info, card)
    return { vars = { card.ability.extra.dollars } }
end

test_joker.calculate = function(self, card, context)
    if context.destroying_card and context.destroying_card.area == G.play and not context.blueprint and G.GAME.current_round.hands_played == 0 then
        if not (context.destroying_card:is_face() or context.destroying_card:get_id() == 14) then
            return {
                message = localize('$') .. card.ability.extra.dollars,
                colour = G.C.MONEY,
                delay = 0.45,
                remove = true,
                card = card,
                extra = {
                    func = function()
                        ease_dollars(card.ability.extra.dollars)
                    end
                },
            }
        end
    end
end

-- Initialize Joker
init_joker(test_joker)
