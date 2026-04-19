------------------------------------------------------------------------------------------------------------------------
-- SETUP
-- Define variables
local canvasWidth = 320
local canvasHeight = 480

local sectionWidth = 32
local sectionHeight = 48

local assetSpriteWidth = 80
local assetSpriteHeight = 80

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
local pathRoofSidesLeft = pathDirectory .. "roof sides, left/"
local pathRoofSidesRight = pathDirectory .. "roof sides, right/"
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

--buildingWidth = 3
--buildingHeight = 2
--buildingDepth = 3

local gableTable = {"left", "right"}

local gableSide = gableTable[math.random(#gableTable)]
gableSide = "left"

------------------------------------------------------------------------------------------------------------------------
-- Nested loop to build sections for as many times as building is wide, and then for as many times as the building is high
local ix
local iy
local iz

-- Calculate draw start position based on building sections
local buildingPixelWidth = (buildingWidth + buildingDepth) * sectionWidth
local buildingPixelHeight = (buildingHeight * sectionHeight) + (buildingWidth * sectionWidth) + sectionHeight * 3

local drawStartX = ((canvasWidth - buildingPixelWidth) / 2) - (sectionWidth / 2)
--local drawStartY = (canvasHeight - buildingPixelHeight) / 2
local drawStartY = buildingPixelHeight

local drawX
local drawY

for iy = 1, buildingHeight, 1 do
    for ix = 1, buildingWidth, 1 do

        -- Wall
        local wallLayer = sprite:newLayer()
        wallLayer.name = "walls left level " .. iy .. ", section " .. ix
        local cel = sprite:newCel(wallLayer, 1)

        -- Choose a wall variant
        local variantCurrentWall = math.random(1)
        local pathCurrentWall = pathWalls .. variantCurrentWall .. ".png"
        local img = Image{ fromFile=pathCurrentWall }

        drawX = drawStartX + ((ix - 1) * sectionWidth)
        drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight)

        -- Place it into the cel at a given position
        cel.image = img
        cel.position = Point( drawX, drawY )

        -- Window
        local windowLayer = sprite:newLayer()
        windowLayer.name = "windows left level " .. iy .. ", section " .. ix

        local cel = sprite:newCel(windowLayer, 1)
        local variantCurrentWindow = math.random(1)
        local pathCurrentWindow = pathWindows .. variantCurrentWindow .. ".png"
        
        local img = Image{ fromFile=pathCurrentWindow }

        cel.image = img
        cel.position = Point( drawX, drawY )

        -- Horizontal trim
        local trimHorizontalLayer = sprite:newLayer()
        trimHorizontalLayer.name = "horizontal trim left level " .. iy .. ", section " .. ix

        local cel = sprite:newCel(trimHorizontalLayer, 1)
        local variantCurrentHorizontalTrim = math.random(1)
        local pathCurrentHorizontalTrim = pathHorizontalTrims .. variantCurrentHorizontalTrim .. ".png"
        
        local img = Image{ fromFile=pathCurrentHorizontalTrim }

        cel.image = img
        cel.position = Point( drawX, drawY + (sectionHeight / 2))

        -- Vertical trim
        local trimVerticalLayer = sprite:newLayer()
        trimVerticalLayer.name = "vertical trim left level " .. iy .. ", section " .. ix

        local cel = sprite:newCel(trimVerticalLayer, 1)
        local variantCurrentVerticalTrim = math.random(1)
        local pathCurrentVerticalTrim = pathVerticalTrims .. variantCurrentVerticalTrim .. ".png"
        
        local img = Image{ fromFile=pathCurrentVerticalTrim }

        cel.image = img
        cel.position = Point( drawX - (sectionWidth/2), drawY - 7)

        -- Corner trim
        if ix == buildingWidth then
            
            local trimCornerLayer = sprite:newLayer()
            trimCornerLayer.name = "corner trim level " .. iy

            local cel = sprite:newCel(trimCornerLayer, 1)
            local variantCurrentCornerTrim = math.random(1)
            local pathCurrentCornerTrim = pathCornerTrims .. variantCurrentCornerTrim .. ".png"
            
            local img = Image{ fromFile=pathCurrentCornerTrim }

            cel.image = img
            cel.position = Point( drawX + (sectionWidth/2), drawY + 7)

        end

        -- Gable
        if iy == buildingHeight then
            if gableSide == "left" then

                local roofLayer = sprite:newLayer()
                roofLayer.name = "roof left " .. ix
                local cel = sprite:newCel(roofLayer, 1)

                -- Choose a roof variant
                local variantCurrentRoof = math.random(1)
                local pathCurrentRoof = pathRooves .. variantCurrentRoof .. ".png"
                local img = Image{ fromFile=pathCurrentRoof }

                drawX = drawStartX + ((ix - 1) * sectionWidth) + (sectionWidth / 2)
                drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight) - sectionHeight - 7

                -- Place it into the cel at a given position
                cel.image = img
                cel.position = Point( drawX, drawY )

                -- Roof sides
                if ix == buildingWidth then
                
                    local roofSideLeft = sprite:newLayer()
                    roofSideLeft.name = "roof side left"
                    local cel = sprite:newCel(roofSideLeft, 1)

                    -- Choose a roof side variant
                    local variantCurrentRoofSide = math.random(1)
                    local pathCurrentRoofSide = pathRoofSidesLeft .. variantCurrentRoofSide .. ".png"
                    local img = Image{ fromFile=pathCurrentRoofSide }

                    drawX = drawStartX + ((ix - 1) * sectionWidth) + sectionWidth
                    drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight) - sectionHeight

                    -- Place it into the cel at a given position
                    cel.image = img
                    cel.position = Point( drawX, drawY )

                end

                -- Rooftops
                if buildingDepth > 2 then

                    local roofTop = sprite:newLayer()
                    roofTop.name = "roof top " .. ix
                    local cel = sprite:newCel(roofTop, 1)

                    -- Choose a rooftop variant
                    local variantCurrentRooftop = math.random(1)
                    local pathCurrentRooftop = pathRooftops .. variantCurrentRooftop .. ".png"
                    local img = Image{ fromFile=pathCurrentRooftop }

                    drawX = drawStartX + ((ix - 1) * sectionWidth) + (sectionWidth / 2) + sectionWidth
                    drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionHeight * 2)

                    -- Place it into the cel at a given position
                    cel.image = img
                    cel.position = Point( drawX, drawY )
                    
                end
                
            end
        end

        -- Recolour

    end
end

-- Reset and go again for the other side
for iy = 1, buildingHeight, 1 do
    for iz = 1, buildingDepth, 1 do

        -- Create new layer and new cel
        local wallLayer = sprite:newLayer()
        wallLayer.name = "walls right level " .. iy .. ", section " .. iz
        local cel = sprite:newCel(wallLayer, 1)

        -- Choose a wall variant
        local variantCurrentWall = math.random(1)
        local pathCurrentWall = pathWalls .. variantCurrentWall .. ".png"

        -- Add the wall
        local img = Image{ fromFile=pathCurrentWall }

        -- Place it into the cel at a given position
        cel.image = img

        drawX = drawStartX + (sectionWidth * buildingWidth) + (iz - 1) * (sectionWidth)
        drawY = drawStartY + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionWidth/2)
        
        -- Flip the segment
        app.command.Flip{ target="mask", orientation="horizontal" }
        cel.position = Point( drawX, drawY )

        -- Window
        local windowLayer = sprite:newLayer()
        windowLayer.name = "windows right level " .. iy .. ", section " .. iz

        local cel = sprite:newCel(windowLayer, 1)
        local variantCurrentWindow = math.random(1)
        local pathCurrentWindow = pathWindows .. variantCurrentWindow .. ".png"
        
        local img = Image{ fromFile=pathCurrentWindow }

        cel.image = img
        app.command.Flip{ target="mask", orientation="horizontal" }
        cel.position = Point( drawX, drawY )

        -- Horizontal trim
        local trimHorizontalLayer = sprite:newLayer()
        trimHorizontalLayer.name = "horizontal trim right level " .. iy .. ", section " .. iz

        local cel = sprite:newCel(trimHorizontalLayer, 1)
        local variantCurrentHorizontalTrim = math.random(1)
        local pathCurrentHorizontalTrim = pathHorizontalTrims .. variantCurrentHorizontalTrim .. ".png"
        
        local img = Image{ fromFile=pathCurrentHorizontalTrim }

        cel.image = img
        app.command.Flip{ target="mask", orientation="horizontal" }
        cel.position = Point( drawX, drawY + (sectionHeight / 2))

        -- Vertical trim
        local trimVerticalLayer = sprite:newLayer()
        trimVerticalLayer.name = "vertical trim right level " .. iy .. ", section " .. iz

        local cel = sprite:newCel(trimVerticalLayer, 1)
        local variantCurrentVerticalTrim = math.random(1)
        local pathCurrentVerticalTrim = pathVerticalTrims .. variantCurrentVerticalTrim .. ".png"
        
        local img = Image{ fromFile=pathCurrentVerticalTrim }

        cel.image = img
        app.command.Flip{ target="mask", orientation="horizontal" }
        cel.position = Point( drawX + (sectionWidth/2), drawY - 7)

        -- Gable check
        if iy == buildingHeight then
            if gableSide == "right" then
            -- Flipped gable process

            -- If gable isn't this end...
            else
                -- If we are section buildingDepth, add the flipped diagonal gable face
                if iz == buildingDepth then

                    local roofSideRight = sprite:newLayer()
                    roofSideRight.name = "roof side right"
                    local cel = sprite:newCel(roofSideRight, 1)

                    -- Choose a roof side variant
                    local variantCurrentRoofSide = math.random(1)
                    local pathCurrentRoofSide = pathRoofSidesRight .. variantCurrentRoofSide .. ".png"
                    local img = Image{ fromFile=pathCurrentRoofSide }

                    drawX = drawStartX + (sectionWidth * buildingWidth) + (iz - 1) * (sectionWidth)
                    drawY = drawStartY + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionWidth/2) - sectionHeight + 8

                    -- Place it into the cel at a given position
                    cel.image = img
                    cel.position = Point( drawX, drawY )

                -- Else if we aren't the first section, add a flat gable end (current wall variant)
                elseif iz > 1 then

                    local gableEnd = sprite:newLayer()
                    gableEnd.name = "gable end"
                    local cel = sprite:newCel(gableEnd, 1)

                    local img = Image{ fromFile=pathCurrentWall }

                    -- Place it into the cel at a given position
                    cel.image = img

                    drawX = drawStartX + (sectionWidth * buildingWidth) + (iz - 1) * (sectionWidth)
                    drawY = drawStartY + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionWidth/2) - sectionHeight
                    
                    -- Flip the segment
                    app.command.Flip{ target="mask", orientation="horizontal" }
                    cel.position = Point( drawX, drawY )

                end
            end
        end


        -- Recolour

    end
end


------------------------------------------------------------------------------------------------------------------------
app.refresh()