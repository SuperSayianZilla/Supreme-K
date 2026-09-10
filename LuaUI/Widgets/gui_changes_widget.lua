
function widget:GetInfo()
	return {
		name    = "Changes Widget",
		desc    = "Displays patch notes and recent changes",
		author  = "UGZ",
		date    = "5 Septemeber 2026",
		license = "GPL",
		layer   = 0,
		enabled = true,
	}
end

local window

-------------------------------------------------------
-- COLORS
-------------------------------------------------------

local BLACK       = {0.01, 0.01, 0.01, 1.00}
local WHITE       = {1.00, 1.00, 1.00, 1.00}
local LIGHT_GREY  = {0.78, 0.78, 0.78, 1.00}
local GREY        = {0.52, 0.52, 0.52, 1.00}
local DARK_GREY   = {0.22, 0.22, 0.22, 1.00}
local DESCRIPTION = {0.86, 0.86, 0.86, 1.00}


function widget:Initialize()

	local Chili = WG.Chili

	if not Chili then
		widgetHandler:RemoveWidget()
		return
	end


	-------------------------------------------------------
	-- MAIN WINDOW
	-------------------------------------------------------

	window = Chili.Window:New {
		caption = "",

		x = "22%",
		y = "7%",
		right = "22%",
		bottom = "7%",

		parent = Chili.Screen0,

		backgroundColor = BLACK,

		padding = {0, 0, 0, 0},

		resizable = false,

		children = {

			---------------------------------------------------
			-- TITLE
			---------------------------------------------------

			Chili.Label:New {
				x = 20,
				y = 10,
				right = 50,
				height = 28,

				caption = "SUPREME-K",

				fontsize = 24,

				textColor = WHITE,

				align = "left",
				valign = "center",
			},

			---------------------------------------------------
			-- SUBTITLE
			---------------------------------------------------

			Chili.Label:New {
				x = 21,
				y = 38,
				right = 55,
				height = 17,

				caption = "PATCH NOTES  •  September 2026",

				fontsize = 11,

				textColor = GREY,

				align = "left",
				valign = "center",
			},

			---------------------------------------------------
			-- CLOSE BUTTON
			---------------------------------------------------

			Chili.Button:New {
				x = -44,
				y = 8,
				width = 32,
				height = 28,

				caption = "X",

				fontsize = 16,

				textColor = WHITE,

				backgroundColor = DARK_GREY,

				OnMouseUp = {
					function()
						window:Hide()
					end
				},
			},

			---------------------------------------------------
			-- HEADER DIVIDER
			---------------------------------------------------

			Chili.Panel:New {
				x = 20,
				y = 61,
				right = 20,
				height = 1,

				backgroundColor = DARK_GREY,
			},
		}
	}


	-------------------------------------------------------
	-- BUILD PATCH NOTE CONTENT
	-------------------------------------------------------

	local content = {}
	local y = 8


	-------------------------------------------------------
	-- HELPER: SECTION
	-------------------------------------------------------

	local function AddSection(text)

		table.insert(content, Chili.Label:New {
			x = 2,
			y = y,
			right = 12,
			height = 25,

			caption = text,

			fontsize = 18,

			textColor = WHITE,

			align = "left",
			valign = "center",
		})

		y = y + 31
	end


	-------------------------------------------------------
	-- HELPER: ENTRY
	-------------------------------------------------------

	local function AddEntry(title, description, descriptionHeight)

		-- Entry title
		table.insert(content, Chili.Label:New {
			x = 3,
			y = y,
			right = 12,
			height = 19,

			caption = title,

			fontsize = 14,

			textColor = LIGHT_GREY,

			align = "left",
			valign = "center",
		})

		y = y + 19


		-- Entry description
		table.insert(content, Chili.Label:New {
			x = 3,
			y = y,
			right = 12,
			height = descriptionHeight or 32,

			caption = description,

			fontsize = 13,

			textColor = DESCRIPTION,

			align = "left",
			valign = "top",
		})

		y = y + (descriptionHeight or 32) + 12
	end


	-------------------------------------------------------
	-- HELPER: DIVIDER
	-------------------------------------------------------

	local function AddDivider()

		table.insert(content, Chili.Panel:New {
			x = 2,
			y = y,
			right = 12,
			height = 1,

			backgroundColor = DARK_GREY,
		})

		y = y + 18
	end


	-------------------------------------------------------
	-- NEW CONTENT
	-------------------------------------------------------

	AddSection("NEW CONTENT")

	AddEntry(
		"FACTORIES",
		"Four new factories have been added, each with a large roster of new units.\nAll factories are balanced around the existing vanilla roster.",
		34
	)

	AddEntry(
		"SIEGEBOTS",
		"Heavy assault bots designed around burst damage and area-of-effect weaponry.\nThey are especially effective during the early game.",
		34
	)

	AddEntry(
		"WALKERS",
		"Heavy-duty all-terrain units suited to defensive and positional play.",
		22
	)

	AddEntry(
		"TRUCKS",
		"A middle ground between rovers and tanks. Agile, durable, and affordable.",
		22
	)

	AddEntry(
		"VTOLS",
		"A new support-focused air factory. VTOLs provide utility without replacing\nthe role of dedicated combat air factories.",
		34
	)


	-------------------------------------------------------
	-- NEW UNITS / STRUCTURES
	-------------------------------------------------------

	AddDivider()

	AddSection("NEW UNITS / STRUCTURES")

	AddEntry(
		"SPEAR",
		"Hover demi-strider featuring an assault/skirmisher role, missiles,\nand a disarming weapon.",
		34
	)

	AddEntry(
		"ONI",
		"Tank skirmisher equipped with burst-fire plasma weaponry.",
		22
	)

	AddEntry(
		"APOC",
		"New heavy riot turret designed for static defensive positions.",
		22
	)


	-------------------------------------------------------
	-- ECONOMY
	-------------------------------------------------------

	AddDivider()

	AddSection("ECONOMY")

	AddEntry(
		"ADVANCED MEX",
		"Produces 5% more metal every 30 seconds while active, up to a\nmaximum of 100% increased production, alongside +4 innate metal.",
		34
	)

	AddEntry(
		"STANDARD MEX REWORK",
		"Metal extractors now gain 5% additional production every 30 seconds,\nup to a maximum of 100% increased production.",
		34
	)


	-------------------------------------------------------
	-- VISUAL UPDATES
	-------------------------------------------------------

	AddDivider()

	AddSection("VISUAL UPDATES")

	AddEntry(
		"IMPROVED TEXTURES",
		"Improved textures across a large number of units and structures,\nincluding Mino, Ogre, Tank Factory, Shield Factory, Spider Factory,\nAmphibious Factory, Dominator,all hover units added normals, Cyclops,Stinger, Mex, Solar, Emissary, Koda,\nBandit, Rogue, and Jug.",
		68
	)


	-------------------------------------------------------
	-- AUDIO
	-------------------------------------------------------

	AddDivider()

	AddSection("AUDIO")

	AddEntry(
		"EPIC MUSIC",
		"A new album named Epic Music is now available.\nOpen AUDIO settings and select Epic Music.\nYou may need to disable Simple Settings to locate it.",
		50
	)


	-------------------------------------------------------
	-- END MESSAGE
	-------------------------------------------------------

	AddDivider()

	table.insert(content, Chili.Label:New {
		x = 3,
		y = y,
		right = 12,
		height = 25,

		caption = "More changes and improvements are on the way.",

		fontsize = 12,

		textColor = GREY,

		align = "left",
		valign = "center",
	})

	y = y + 35


	-------------------------------------------------------
	-- SCROLL PANEL
	-------------------------------------------------------

	Chili.ScrollPanel:New {

		x = 20,
		right = 16,

		y = 72,
		bottom = 14,

		parent = window,

		backgroundColor = BLACK,

		children = content,
	}

end

