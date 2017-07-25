--- This module is resposible for draw player ship
--
-- @module painters.ships.player
-- @author	Rafael Alcalde Azpiazu (NEKERAFA)
-- @license GNU General Public License v3

local painter_bullet = require "src.main.painters.bullet"
local painter_ship	 = require "src.main.painters.ship"

-- Module
local player = {}

function player.draw(ship)
	-- Draw bullets
	if ship.weapon.type == "ray_blaster" then
		painter_bullet.draw_ray_tracer(ship.weapon)
	else
		painter_bullet.draw_bullets(ship.weapon)
	end
	
	if ship.life > 0 then
		-- If ship is damaged, show damaged animation
		-- Get current colors
		local r, g, b, a = love.graphics.getColor()
		
		-- Draw damage effect
		if ship.damaged then
			-- Alpha value
			local alpha = math.round(math.abs(math.cos(ship.damaged_value*2*math.pi))) * 255
			-- Set effect
			love.graphics.setColor(255, 192, 192, alpha)
		end
		
		-- Draw flame and ship
		ship.flame:draw(img.animations.flame_medium, math.round(ship.x)-24, math.round(ship.y), 0, 1, 1, 8, 8)
		love.graphics.draw(img.ships[ship.type], math.round(ship.x), math.round(ship.y), 0, 1, 1, 16, 16)
		
		-- Reset colors
		love.graphics.setColor(r, g, b, a)
	end
	
	-- Draw hitbox
	if app.debug then
		painter_ship.draw_hitbox(ship)
	end
end

return player