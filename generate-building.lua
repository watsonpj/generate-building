------------------------------------------------------------------------------------------------------------------------
-- SETUP
-- Define variables
local canvasWidth = 320
local canvasHeight = 480

local sectionWidth = 32
local sectionHeight = 48

local brush = Brush {
    type = BrushType.CIRCLE,
    size = 1
}

-- Filepaths for assets
local pathDirectory = "C:/Users/hidde/Pictures/aseprite/asset pipeline buildings/"
local pathWalls = pathDirectory .. "walls/"
local pathWindows = pathDirectory .. "windows/"
local pathHorizontalTrims = pathDirectory .. "horizontal trims/"
local pathVerticalTrims = pathDirectory .. "vertical trims/"
local pathCornerTrims = pathDirectory .. "corner trims/"
local pathRooves = pathDirectory .. "rooves/"
local pathRoofSides = pathDirectory .. "roof sides/"
local pathRooftops = pathDirectory .. "rooftops/"

------------------------------------------------------------------------------------------------------------------------
-- Generate canvas
sprite = Sprite(canvasWidth, canvasHeight)
app.activeSprite = sprite

------------------------------------------------------------------------------------------------------------------------
-- Establish building variables; how many sections wide, tall, etc
local buildingWidth = math.random(2, 4)
local buildingHeight = math.random(1, 5)
local buildingDepth = math.random(2, 4)

------------------------------------------------------------------------------------------------------------------------
-- Nested loop to build sections for as many times as building is wide, and then for as many times as the building is high
local ix
local iy
local iz

for iy = 1, buildingHeight, 1 do
    for ix = 1, buildingWidth, 1 do

    -- Create new layer and new cel
    local wallLayer = sprite:newLayer()
    wallLayer.name = "left walls level " .. iy .. ", section " .. ix
    local cel = sprite:newCel(wallLayer, 1)

    -- Choose a wall variant
    local variantCurrentWall = math.random(1)
    local pathCurrentWall = pathWalls .. variantCurrentWall .. ".png"

    -- Add the wall
    local img = Image{ fromFile=pathCurrentWall }

    -- Place it into the cel at a given position
    cel.image = img
    cel.position = Point(
        20 + ix * (sectionWidth),
        canvasHeight/2 + (ix * (sectionWidth/2)) - (iy * sectionHeight)
    )

    -- Recolour

    end
end

-- Reset and go again for the other side
for iy = 1, buildingHeight, 1 do
    for iz = 1, buildingDepth, 1 do

        -- Create new layer and new cel
        local wallLayer = sprite:newLayer()
        wallLayer.name = "right walls level " .. iy .. ", section " .. iz
        local cel = sprite:newCel(wallLayer, 1)

        -- Choose a wall variant
        local variantCurrentWall = math.random(1)
        local pathCurrentWall = pathWalls .. variantCurrentWall .. ".png"

        -- Add the wall
        local img = Image{ fromFile=pathCurrentWall }

        -- Place it into the cel at a given position
        cel.image = img
        
        -- Flip the segment
        app.command.Flip{ target="mask", orientation="horizontal" }
        cel.position = Point(
            20 + (sectionWidth * buildingWidth) + iz * (sectionWidth),
            canvasHeight/2 - (iz * (sectionWidth/2)) - ((iy - 1) * sectionHeight)
        )

        -- Recolour

    end
end


------------------------------------------------------------------------------------------------------------------------
app.refresh()