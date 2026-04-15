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

local drawX
local drawY

for iy = 1, buildingHeight, 1 do
    for ix = 1, buildingWidth, 1 do

    -- Wall
    local wallLayer = sprite:newLayer()
    wallLayer.name = "left walls level " .. iy .. ", section " .. ix
    local cel = sprite:newCel(wallLayer, 1)

    -- Choose a wall variant
    local variantCurrentWall = math.random(1)
    local pathCurrentWall = pathWalls .. variantCurrentWall .. ".png"
    local img = Image{ fromFile=pathCurrentWall }

    drawX = 20 + ix * (sectionWidth)
    drawY = canvasHeight/2 + (ix * (sectionWidth/2)) - (iy * sectionHeight)

    -- Place it into the cel at a given position
    cel.image = img
    cel.position = Point( drawX, drawY )

    -- Window
    local windowLayer = sprite:newLayer()
    windowLayer.name = "left windows level " .. iy .. ", section " .. ix

    local cel = sprite:newCel(windowLayer, 1)
    local variantCurrentWindow = math.random(1)
    local pathCurrentWindow = pathWindows .. variantCurrentWindow .. ".png"
    
    local img = Image{ fromFile=pathCurrentWindow }

    cel.image = img
    cel.position = Point( drawX, drawY )

    -- Trims
    local trimVerticalLayer = sprite:newLayer()
    trimVerticalLayer.name = "left trim vertical left level " .. iy .. ", section " .. ix

    local cel = sprite:newCel(trimVerticalLayer, 1)
    local variantCurrentVerticalTrim = math.random(1)
    local pathCurrentVerticalTrim = pathVerticalTrims .. variantCurrentVerticalTrim .. ".png"
    
    local img = Image{ fromFile=pathCurrentVerticalTrim }

    cel.image = img
    cel.position = Point( drawX - (sectionWidth/2), drawY - 7)

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

        drawX = 20 + (sectionWidth * buildingWidth) + iz * (sectionWidth)
        drawY = canvasHeight/2 + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight)
        
        -- Flip the segment
        app.command.Flip{ target="mask", orientation="horizontal" }
        cel.position = Point( drawX, drawY )

        -- Recolour

    end
end


------------------------------------------------------------------------------------------------------------------------
app.refresh()