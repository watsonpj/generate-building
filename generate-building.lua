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

local wallVariantCount = 7
local windowVariantCount = 2
local horizontalTrimVariantCount = 1
local verticalTrimVariantCount = 2
local cornerTrimVariantCount = 2
local roofVariantCount = 1

-- Defining the colours we replace in the original sprites
local color1A = Color{ r=255, g=255, b=255, a=255 }
local color1B = Color{ r=203, g=219, b=252, a=255 }
local color1C = Color{ r=155, g=173, b=183, a=255 }

local color2A = Color{ r=255, g=255, b=255, a=255 }
local color2B = Color{ r=255, g=255, b=255, a=255 }
local color2C = Color{ r=255, g=255, b=255, a=255 }

-- Define a series of wall, roof, and trim colours to choose from
-- Red
local colorReplaceRedBaseR = math.random(200, 220)
local colorReplaceRedBaseG = math.random(60, 80)
local colorReplaceRedBaseB = math.random(10, 30)
local colorReplaceRed = Color{ r=colorReplaceRedBaseR, g=colorReplaceRedBaseG, b=colorReplaceRedBaseB, a=255 }

-- Orange
local colorReplaceOrangeBaseR = math.random(200, 220)
local colorReplaceOrangeBaseG = math.random(160, 180)
local colorReplaceOrangeBaseB = math.random(10, 30)
local colorReplaceOrange = Color{ r=colorReplaceOrangeBaseR, g=colorReplaceOrangeBaseG, b=colorReplaceOrangeBaseB, a=255 }

-- Yellow
local colorReplaceYellowBaseR = math.random(200, 220)
local colorReplaceYellowBaseG = math.random(200, 220)
local colorReplaceYellowBaseB = math.random(10, 30)
local colorReplaceYellow = Color{ r=colorReplaceYellowBaseR, g=colorReplaceYellowBaseG, b=colorReplaceYellowBaseB, a=255 }

-- Green
local colorReplaceGreenBaseR = math.random(60, 80)
local colorReplaceGreenBaseG = math.random(180, 200)
local colorReplaceGreenBaseB = math.random(60, 80)
local colorReplaceGreen = Color{ r=colorReplaceGreenBaseR, g=colorReplaceGreenBaseG, b=colorReplaceGreenBaseB, a=255 }

-- Grey
local colorReplaceGreyBaseR = math.random(100, 120)
local colorReplaceGreyBaseG = math.random(100, 120)
local colorReplaceGreyBaseB = math.random(100, 120)
local colorReplaceGrey = Color{ r=colorReplaceGreyBaseR, g=colorReplaceGreyBaseG, b=colorReplaceGreyBaseB, a=255 }

-- Black
local colorReplaceBlackBaseR = math.random(60, 80)
local colorReplaceBlackBaseG = math.random(60, 80)
local colorReplaceBlackBaseB = math.random(60, 80)
local colorReplaceBlack = Color{ r=colorReplaceBlackBaseR, g=colorReplaceBlackBaseG, b=colorReplaceBlackBaseB, a=255 }

-- White
local colorReplaceWhiteBaseR = math.random(230, 250)
local colorReplaceWhiteBaseG = math.random(230, 250)
local colorReplaceWhiteBaseB = math.random(230, 250)
local colorReplaceWhite = Color{ r=colorReplaceWhiteBaseR, g=colorReplaceWhiteBaseG, b=colorReplaceWhiteBaseB, a=255 }

local tableColorPresets = {
    colorReplaceRed,
    colorReplaceOrange,
    colorReplaceYellow,
    colorReplaceGreen,
    colorReplaceGrey,
    colorReplaceBlack,
    colorReplaceWhite,
}

local colorRooves = tableColorPresets[math.random(#tableColorPresets)]
local colorWalls = tableColorPresets[math.random(#tableColorPresets)]
local colorTrims = tableColorPresets[math.random(#tableColorPresets)]

------------------------------------------------------------------------------------------------------------------------
-- Functions
function replaceColours(component, direction)

    local recolorColor

    if component == "roof" then
        recolorColor = colorRooves
    elseif component == "wall" then
        recolorColor = colorWalls
    elseif component == "trim" then
        recolorColor = colorTrims
    end

    -- Generate all colour variants 
    local colorReplace1A = recolorColor
    local colorReplace1B = Color{ r=recolorColor.red * 0.90, g=recolorColor.green * 0.90, b=recolorColor.blue * 1.05, a=255 }
    local colorReplace1C = Color{ r=recolorColor.red * 0.80, g=recolorColor.green * 0.80, b=recolorColor.blue * 1.10, a=255 }
    local colorReplace1D = Color{ r=recolorColor.red * 0.70, g=recolorColor.green * 0.70, b=recolorColor.blue * 1.15, a=255 }
    local colorReplace1E = Color{ r=recolorColor.red * 0.60, g=recolorColor.green * 0.60, b=recolorColor.blue * 1.20, a=255 }

    -- Top
    if direction == "top" then
        app.command.ReplaceColor { ui=false, from=color1A, to=colorReplace1A, }
        app.command.ReplaceColor { ui=false, from=color1B, to=colorReplace1B, }
        app.command.ReplaceColor { ui=false, from=color1C, to=colorReplace1C, }

    -- Left
    elseif direction == "left" then
        app.command.ReplaceColor { ui=false, from=color1A, to=colorReplace1B, }
        app.command.ReplaceColor { ui=false, from=color1B, to=colorReplace1C, }
        app.command.ReplaceColor { ui=false, from=color1C, to=colorReplace1D, }

    -- Right
    elseif direction == "right" then
        app.command.ReplaceColor { ui=false, from=color1A, to=colorReplace1C, }
        app.command.ReplaceColor { ui=false, from=color1B, to=colorReplace1D, }
        app.command.ReplaceColor { ui=false, from=color1C, to=colorReplace1E, }

    end

end

------------------------------------------------------------------------------------------------------------------------
-- Establish building variables; how many sections wide, tall, etc
local buildingWidth = math.random(2, 4)
local buildingHeight = math.random(1, 5)
local buildingDepth = math.random(2, 4)

buildingWidth = 4
buildingHeight = 2
buildingDepth = 3

local gableTable = {"left", "right"}

local gableSide = gableTable[math.random(#gableTable)]
gableSide = "left"

-- Choose variants
local variantCurrentWall = math.random(1, wallVariantCount)
local variantCurrentWindow = math.random(1, windowVariantCount)
local variantCurrentVerticalTrim = math.random(1, verticalTrimVariantCount)
local variantCurrentCornerTrim = math.random(1, cornerTrimVariantCount)

------------------------------------------------------------------------------------------------------------------------
-- Generate canvas
sprite = Sprite(canvasWidth, canvasHeight)
app.activeSprite = sprite

-- Create layer groups
local trimCornerGroup = sprite:newGroup()
trimCornerGroup.name = "corner trims"

local roofGroup = sprite:newGroup()
roofGroup.name = "rooves"

local trimVerticalGroup = sprite:newGroup()
trimVerticalGroup.name = "vertical trims"

local trimHorizontalGroup = sprite:newGroup()
trimHorizontalGroup.name = "horizontal trims"

------------------------------------------------------------------------------------------------------------------------
-- Nested loop to build sections for as many times as building is wide, and then for as many times as the building is high
local ix
local iy
local iz

-- Calculate draw start position based on building sections
local buildingPixelWidth = (buildingWidth + buildingDepth) * sectionWidth
local buildingPixelHeight = (buildingHeight * sectionHeight) + (buildingWidth * sectionWidth) + sectionHeight * 3

local drawStartX = ((canvasWidth - buildingPixelWidth) / 2) - (sectionWidth / 2)
local drawStartY = canvasHeight - ((canvasHeight - buildingPixelHeight) / 2) - sectionHeight - (buildingWidth * sectionWidth) + sectionHeight

local drawX
local drawY

for iy = 1, buildingHeight, 1 do
    for ix = 1, buildingWidth, 1 do

        -- Wall
        local wallLayer = sprite:newLayer()
        wallLayer.name = "walls left level " .. iy .. ", section " .. ix
        local cel = sprite:newCel(wallLayer, 1)

        local pathCurrentWall = pathWalls .. variantCurrentWall .. ".png"
        local img = Image{ fromFile=pathCurrentWall }

        drawX = drawStartX + ((ix - 1) * sectionWidth) + 1
        drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight)

        -- Place it into the cel at a given position
        cel.image = img
        cel.position = Point( drawX, drawY )
        replaceColours("wall", "left")

        -- Window
        local windowLayer = sprite:newLayer()
        windowLayer.name = "windows left level " .. iy .. ", section " .. ix

        local cel = sprite:newCel(windowLayer, 1)
        local pathCurrentWindow = pathWindows .. variantCurrentWindow .. ".png"
        
        local img = Image{ fromFile=pathCurrentWindow }

        cel.image = img
        cel.position = Point( drawX, drawY )
        replaceColours("wall", "left")

        -- Horizontal trim
        local trimHorizontalLayer = sprite:newLayer()
        trimHorizontalLayer.name = "horizontal trim left level " .. iy .. ", section " .. ix
        trimHorizontalLayer.parent = trimHorizontalGroup

        local cel = sprite:newCel(trimHorizontalLayer, 1)
        local variantCurrentHorizontalTrim = math.random(horizontalTrimVariantCount)
        local pathCurrentHorizontalTrim = pathHorizontalTrims .. variantCurrentHorizontalTrim .. ".png"
        
        local img = Image{ fromFile=pathCurrentHorizontalTrim }

        cel.image = img
        cel.position = Point( drawX, drawY + (sectionHeight / 2))
        replaceColours("trim", "left")

        -- Vertical trim
        local trimVerticalLayer = sprite:newLayer()
        trimVerticalLayer.name = "vertical trim left level " .. iy .. ", section " .. ix
        trimVerticalLayer.parent = trimVerticalGroup

        local cel = sprite:newCel(trimVerticalLayer, 1)
        --local variantCurrentVerticalTrim = math.random(1, verticalTrimVariantCount)
        local pathCurrentVerticalTrim = pathVerticalTrims .. variantCurrentVerticalTrim .. ".png"
        
        local img = Image{ fromFile=pathCurrentVerticalTrim }

        cel.image = img
        cel.position = Point( drawX - (sectionWidth/2), drawY - 7)
        replaceColours("trim", "left")

        -- Corner trim
        if ix == buildingWidth then

            local trimCornerLayer = sprite:newLayer()
            trimCornerLayer.name = "corner trim level " .. iy
            trimCornerLayer.parent = trimCornerGroup

            local cel = sprite:newCel(trimCornerLayer, 1)
            local pathCurrentCornerTrim = pathCornerTrims .. variantCurrentCornerTrim .. ".png"
            
            local img = Image{ fromFile=pathCurrentCornerTrim }

            cel.image = img
            cel.position = Point( drawX + (sectionWidth/2), drawY + 9)
            replaceColours("trim", "left")

        end

        -- Gable
        if iy == buildingHeight then
            if gableSide == "left" then

                local roofLayer = sprite:newLayer()
                roofLayer.name = "roof left " .. ix
                roofLayer.parent = roofGroup

                local cel = sprite:newCel(roofLayer, 1)

                -- Choose a roof variant
                local variantCurrentRoof = math.random(roofVariantCount)
                local pathCurrentRoof = pathRooves .. variantCurrentRoof .. ".png"
                local img = Image{ fromFile=pathCurrentRoof }

                --drawX = drawStartX + ((ix - 1) * sectionWidth) + (sectionWidth / 2)
                --drawX = drawStartX + ((ix - 1) * sectionWidth) + (sectionWidth / 2) + (1 * ix)
                --drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight) - sectionHeight - 8

                -- Replicated straight from walls to test
                drawX = drawStartX + ((ix - 1) * sectionWidth) + (sectionWidth / 2) + 1
                drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight) - 55

                -- Place it into the cel at a given position
                cel.image = img
                cel.position = Point( drawX, drawY )
                replaceColours("roof", "left")

                -- Roof sides
                if ix == buildingWidth then
                
                    local roofSideLeft = sprite:newLayer()
                    roofSideLeft.name = "roof side left"
                    roofSideLeft.parent = roofGroup

                    local cel = sprite:newCel(roofSideLeft, 1)

                    -- Choose a roof side variant
                    local variantCurrentRoofSide = math.random(1)
                    local pathCurrentRoofSide = pathRoofSidesLeft .. variantCurrentRoofSide .. ".png"
                    local img = Image{ fromFile=pathCurrentRoofSide }

                    drawX = drawStartX + ((ix - 1) * sectionWidth) + sectionWidth + 2
                    drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight) - sectionHeight + 1

                    -- Place it into the cel at a given position
                    cel.image = img
                    cel.position = Point( drawX, drawY )
                    replaceColours("wall", "right")

                end

                -- Rooftops
                if buildingDepth > 2 then

                    -- Insert for loop up to building depth
                    local roofTopN

                    for roofTopN = 1, buildingDepth - 2, 1 do

                        local roofTop = sprite:newLayer()
                        roofTop.name = "roof top " .. ix
                        roofTop.parent = roofGroup

                        local cel = sprite:newCel(roofTop, 1)

                        -- Choose a rooftop variant
                        local variantCurrentRooftop = math.random(1)
                        local pathCurrentRooftop = pathRooftops .. variantCurrentRooftop .. ".png"
                        local img = Image{ fromFile=pathCurrentRooftop }

                        drawX = drawStartX + ((ix - 1) * sectionWidth) + (sectionWidth / 2) + (sectionWidth * roofTopN) + 1
                        drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionHeight * 2) - ((sectionWidth/2) * (roofTopN - 1)) + 2

                        -- Place it into the cel at a given position
                        cel.image = img
                        cel.position = Point( drawX, drawY )
                        replaceColours("roof", "top")

                    end
                    
                end
                
            end
        end

    end
end

-- Reset and go again for the other side
for iy = 1, buildingHeight, 1 do
    for iz = 1, buildingDepth, 1 do

        -- Create new layer and new cel
        local wallLayer = sprite:newLayer()
        wallLayer.name = "walls right level " .. iy .. ", section " .. iz
        local cel = sprite:newCel(wallLayer, 1)

        -- Add the wall
        local pathCurrentWall = pathWalls .. variantCurrentWall .. ".png"
        local img = Image{ fromFile=pathCurrentWall }

        -- Place it into the cel at a given position
        cel.image = img

        drawX = drawStartX + (sectionWidth * buildingWidth) + (iz - 1) * (sectionWidth) + 1
        drawY = drawStartY + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionWidth/2) + 1
        
        -- Flip the segment
        app.command.Flip{ target="mask", orientation="horizontal" }
        cel.position = Point( drawX, drawY )
        replaceColours("wall", "right")

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
        replaceColours("wall", "right")

        -- Horizontal trim
        local trimHorizontalLayer = sprite:newLayer()
        trimHorizontalLayer.name = "horizontal trim right level " .. iy .. ", section " .. iz
        trimHorizontalLayer.parent = trimHorizontalGroup

        local cel = sprite:newCel(trimHorizontalLayer, 1)
        local variantCurrentHorizontalTrim = math.random(1)
        local pathCurrentHorizontalTrim = pathHorizontalTrims .. variantCurrentHorizontalTrim .. ".png"
        
        local img = Image{ fromFile=pathCurrentHorizontalTrim }

        cel.image = img
        app.command.Flip{ target="mask", orientation="horizontal" }
        cel.position = Point( drawX, drawY + (sectionHeight / 2))
        replaceColours("trim", "right")

        -- Vertical trim
        local trimVerticalLayer = sprite:newLayer()
        trimVerticalLayer.name = "vertical trim right level " .. iy .. ", section " .. iz
        trimVerticalLayer.parent = trimVerticalGroup

        local cel = sprite:newCel(trimVerticalLayer, 1)
        --local variantCurrentVerticalTrim = math.random(1)
        local pathCurrentVerticalTrim = pathVerticalTrims .. variantCurrentVerticalTrim .. ".png"
        
        local img = Image{ fromFile=pathCurrentVerticalTrim }

        cel.image = img
        app.command.Flip{ target="mask", orientation="horizontal" }
        cel.position = Point( drawX + (sectionWidth/2), drawY - 7)
        replaceColours("trim", "right")

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
                    roofSideRight.parent = roofGroup

                    local cel = sprite:newCel(roofSideRight, 1)

                    -- Choose a roof side variant
                    local variantCurrentRoofSide = math.random(1)
                    local pathCurrentRoofSide = pathRoofSidesRight .. variantCurrentRoofSide .. ".png"
                    local img = Image{ fromFile=pathCurrentRoofSide }

                    drawX = drawStartX + (sectionWidth * buildingWidth) + (iz - 1) * (sectionWidth) - 1
                    drawY = drawStartY + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionWidth/2) - sectionHeight + 9

                    -- Place it into the cel at a given position
                    cel.image = img
                    cel.position = Point( drawX, drawY )
                    replaceColours("roof", "right")

                -- Else if we aren't the first section, add a flat gable end (current wall variant)
                elseif iz > 1 then

                    local gableEnd = sprite:newLayer()
                    gableEnd.name = "gable end"
                    gableEnd.parent = roofGroup

                    local cel = sprite:newCel(gableEnd, 1)

                    local img = Image{ fromFile=pathCurrentWall }

                    -- Place it into the cel at a given position
                    cel.image = img

                    drawX = drawStartX + (sectionWidth * buildingWidth) + (iz - 1) * (sectionWidth) + 1
                    drawY = drawStartY + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionWidth/2) - sectionHeight + 1
                    
                    -- Flip the segment
                    app.command.Flip{ target="mask", orientation="horizontal" }
                    cel.position = Point( drawX, drawY )
                    replaceColours("wall", "right")

                end
            end
        end

    end
end

------------------------------------------------------------------------------------------------------------------------
-- Reorder layers
local numberOfLayers = #(sprite.layers)
trimHorizontalGroup.stackIndex = numberOfLayers
trimVerticalGroup.stackIndex = numberOfLayers
trimCornerGroup.stackIndex = numberOfLayers
roofGroup.stackIndex = numberOfLayers

------------------------------------------------------------------------------------------------------------------------
app.refresh()

-- Get formatted date and time
local formattedDateAndTime = os.date("%d%m%y %H%M%S")

-- Export as a PNG
app.command.saveFileCopyAs {
    ui=false,
    filename="C:\\Users\\hidde\\Pictures\\aseprite\\generate-building\\" .. formattedDateAndTime .. ".png",
}