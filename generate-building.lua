------------------------------------------------------------------------------------------------------------------------
-- SETUP
-- Define variables
local canvasWidth = 400
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
local pathCornerTrimsCentre = pathDirectory .. "corner trims, centre/"
local pathCornerTrimsSide = pathDirectory .. "corner trims, side/"
local pathRooves = pathDirectory .. "rooves/"
local pathRoofSidesLeft = pathDirectory .. "roof sides, left/"
local pathRoofSidesRight = pathDirectory .. "roof sides, right/"
local pathRoofTrimsLeft = pathDirectory .. "roof trims, left/"
local pathRoofTrimsRight = pathDirectory .. "roof trims, right/"
local pathRoofTrimsCentre = pathDirectory .. "roof trims, centre/"
local pathRooftops = pathDirectory .. "rooftops/"
local pathDoors = pathDirectory .. "doors/"
local pathBase = pathDirectory .. "base/"

local wallVariantCount = 7
local windowVariantCount = 3
local horizontalTrimVariantCount = 7
local verticalTrimVariantCount = 3
local cornerTrimVariantCount = 3
local roofVariantCount = 1
local doorVariantCount = 2
local baseVariantCount = 1
local roofTrimVariantCount = 1

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
local colorReplaceOrangeBaseG = math.random(170, 190)
local colorReplaceOrangeBaseB = math.random(10, 30)
local colorReplaceOrange = Color{ r=colorReplaceOrangeBaseR, g=colorReplaceOrangeBaseG, b=colorReplaceOrangeBaseB, a=255 }

-- Yellow
local colorReplaceYellowBaseR = math.random(210, 230)
local colorReplaceYellowBaseG = math.random(210, 230)
local colorReplaceYellowBaseB = math.random(160, 180)
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
local colorReplaceWhiteBaseR = math.random(240, 255)
local colorReplaceWhiteBaseG = math.random(240, 255)
local colorReplaceWhiteBaseB = math.random(240, 255)
local colorReplaceWhite = Color{ r=colorReplaceWhiteBaseR, g=colorReplaceWhiteBaseG, b=colorReplaceWhiteBaseB, a=255 }

local tableColors = {
    colorReplaceRed,
    colorReplaceOrange,
    colorReplaceYellow,
    colorReplaceGreen,
    colorReplaceGrey,
    colorReplaceBlack,
    colorReplaceWhite,
}
local tableRoofColors = {
    colorReplaceGrey,
    colorReplaceBlack,
}
local tableTrimColors = {
    colorReplaceOrange,
    colorReplaceYellow,
    colorReplaceWhite,
}
local tableBaseColors = {
    colorReplaceGrey,
    colorReplaceBlack,
}

local colorRooves = tableRoofColors[math.random(#tableRoofColors)]
local colorWalls = tableColors[math.random(#tableColors)]
local colorTrims = tableTrimColors[math.random(#tableTrimColors)]
local colorBase = tableBaseColors[math.random(#tableBaseColors)]

------------------------------------------------------------------------------------------------------------------------
-- Functions
function clamp(value, minimum, maximum)
    return math.min(math.max(value, minimum), maximum)
end

function replaceColours(component, direction)

    local recolorColor

    if component == "roof" then
        recolorColor = colorRooves
    elseif component == "wall" then
        recolorColor = colorWalls
    elseif component == "trim" then
        recolorColor = colorTrims
    elseif component == "base" then
        recolorColor = colorBase
    end

    -- Generate all colour variants 
    local colorReplace1A = recolorColor
    local colorReplace1B = Color{ r=recolorColor.red * 0.90, g=recolorColor.green * 0.90, b=clamp(recolorColor.blue * 1.05, 0, 255), a=255 }
    local colorReplace1C = Color{ r=recolorColor.red * 0.80, g=recolorColor.green * 0.80, b=clamp(recolorColor.blue * 1.10, 0, 255), a=255 }
    local colorReplace1D = Color{ r=recolorColor.red * 0.70, g=recolorColor.green * 0.70, b=clamp(recolorColor.blue * 1.15, 0, 255), a=255 }
    local colorReplace1E = Color{ r=recolorColor.red * 0.60, g=recolorColor.green * 0.60, b=clamp(recolorColor.blue * 1.20, 0, 255), a=255 }

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

local gableTable = {"left", "right"}

local gableSide = gableTable[math.random(#gableTable)]
gableSide = "left"

-- Choose variants
local variantCurrentWall = math.random(wallVariantCount)
local variantCurrentWindow = math.random(windowVariantCount)
local variantCurrentCornerTrim = math.random(cornerTrimVariantCount)
local variantCurrentDoor = math.random(doorVariantCount)
local variantCurrentRoofTrim = math.random(roofTrimVariantCount)

-- Populate tables with trim choices for rows
local tableRowTrimsLeft = {}
for rowNum = 1, buildingHeight, 1 do
    tableRowTrimsLeft[rowNum] = math.random(horizontalTrimVariantCount)
end

local tableRowTrimsRight = {}
for rowNum = 1, buildingHeight, 1 do
    tableRowTrimsRight[rowNum] = math.random(horizontalTrimVariantCount)
end

-- Populate tables with trim choices for columns
local tableColTrimsLeft = {}
for colNum = 1, buildingWidth, 1 do
    tableColTrimsLeft[colNum] = math.random(verticalTrimVariantCount)
end

local tableColTrimsRight = {}
for colNum = 1, buildingDepth, 1 do
    tableColTrimsRight[colNum] = math.random(verticalTrimVariantCount)
end

-- Choose door location
local doorLocation = math.random(buildingWidth)

------------------------------------------------------------------------------------------------------------------------
-- Generate canvas
sprite = Sprite(canvasWidth, canvasHeight)
app.activeSprite = sprite

-- Create layer groups
local baseGroup = sprite:newGroup()
baseGroup.name = "base"
baseGroup.isCollapsed = true

local wallsGroup = sprite:newGroup()
wallsGroup.name = "walls"
wallsGroup.isCollapsed = true

local trimHorizontalLeftGroup = sprite:newGroup()
trimHorizontalLeftGroup.name = "horizontal trims, left"
trimHorizontalLeftGroup.isCollapsed = true

local trimHorizontalRightGroup = sprite:newGroup()
trimHorizontalRightGroup.name = "horizontal trims, right"
trimHorizontalRightGroup.isCollapsed = true

local windowsLeftGroup = sprite:newGroup()
windowsLeftGroup.name = "windows, left"
windowsLeftGroup.isCollapsed = true

local windowsRightGroup = sprite:newGroup()
windowsRightGroup.name = "windows, right"
windowsRightGroup.isCollapsed = true

local trimVerticalGroup = sprite:newGroup()
trimVerticalGroup.name = "vertical trims"
trimVerticalGroup.isCollapsed = true

local doorGroup = sprite:newGroup()
doorGroup.name = "door"
doorGroup.isCollapsed = true

local trimRoofGroupRear = sprite:newGroup()
trimRoofGroupRear.name = "roof trims rear"
trimRoofGroupRear.isCollapsed = true

local trimCornerGroup = sprite:newGroup()
trimCornerGroup.name = "corner trims"
trimCornerGroup.isCollapsed = true

local roofGroup = sprite:newGroup()
roofGroup.name = "rooves"
roofGroup.isCollapsed = true

local gableTrimHorizontalGroup = sprite:newGroup()
gableTrimHorizontalGroup.name = "horizontal gable trims"
gableTrimHorizontalGroup.isCollapsed = true

local gableTrimVerticalGroup = sprite:newGroup()
gableTrimVerticalGroup.name = "vertical gable trims"
gableTrimVerticalGroup.isCollapsed = true

local trimRoofGroupFore = sprite:newGroup()
trimRoofGroupFore.name = "roof trims fore"
trimRoofGroupFore.isCollapsed = true

------------------------------------------------------------------------------------------------------------------------
-- Nested loop to build sections for as many times as building is wide, and then for as many times as the building is high
local ix
local iy
local iz

-- Calculate draw start position based on building sections
local buildingPixelWidth = (buildingWidth + buildingDepth) * (sectionWidth + 2)
local buildingPixelHeight = (buildingHeight * sectionHeight) + (buildingWidth * sectionWidth) + (sectionHeight + 2) * 3

local drawStartX = ((canvasWidth - buildingPixelWidth) / 2) - (sectionWidth / 2)
local drawStartY = canvasHeight - ((canvasHeight - buildingPixelHeight) / 2) - sectionHeight - (buildingWidth * sectionWidth) + sectionHeight/2

local drawX
local drawY

for iy = 1, buildingHeight, 1 do
    for ix = 1, buildingWidth, 1 do

        -- Wall
        local wallLayer = sprite:newLayer()
        wallLayer.name = "walls left level " .. iy .. ", section " .. ix
        wallLayer.parent = wallsGroup

        local cel = sprite:newCel(wallLayer, 1)

        local pathCurrentWall = pathWalls .. variantCurrentWall .. ".png"
        local img = Image{ fromFile=pathCurrentWall }

        drawX = drawStartX + ((ix - 1) * sectionWidth) + 1
        drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight)

        -- Place it into the cel at a given position
        cel.image = img
        cel.position = Point( drawX, drawY )
        replaceColours("wall", "left")

        -- Door or window
        if iy == 1 then

            -- Door
            if ix == doorLocation then

                local doorLayer = sprite:newLayer()
                doorLayer.name = "door"
                doorLayer.parent = windowsLeftGroup

                local cel = sprite:newCel(doorLayer, 1)
                local pathCurrentDoor = pathDoors .. variantCurrentDoor .. ".png"
                
                local img = Image{ fromFile=pathCurrentDoor }

                cel.image = img
                cel.position = Point( drawX, drawY )
                replaceColours("trim", "left")
            end

        else
            -- Window
            local windowLayer = sprite:newLayer()
            windowLayer.name = "windows left level " .. iy .. ", section " .. ix
            windowLayer.parent = windowsLeftGroup

            local cel = sprite:newCel(windowLayer, 1)
            local pathCurrentWindow = pathWindows .. variantCurrentWindow .. ".png"
            
            local img = Image{ fromFile=pathCurrentWindow }

            cel.image = img
            cel.position = Point( drawX, drawY )
            replaceColours("trim", "left")
        end

        -- Horizontal trim
        local trimHorizontalLayer = sprite:newLayer()
        trimHorizontalLayer.name = "horizontal trim left level " .. iy .. ", section " .. ix
        trimHorizontalLayer.parent = trimHorizontalLeftGroup

        local cel = sprite:newCel(trimHorizontalLayer, 1)
        local variantCurrentHorizontalTrim = tableRowTrimsLeft[iy]
        local pathCurrentHorizontalTrim = pathHorizontalTrims .. variantCurrentHorizontalTrim .. ".png"
        
        local img = Image{ fromFile=pathCurrentHorizontalTrim }

        cel.image = img
        cel.position = Point( drawX, drawY )
        replaceColours("trim", "left")

        -- Corner trim, side
        if ix == 1 then

            local trimCornerLayer = sprite:newLayer()
            trimCornerLayer.name = "corner trim level " .. iy
            trimCornerLayer.parent = trimCornerGroup

            local cel = sprite:newCel(trimCornerLayer, 1)
            local pathCurrentCornerTrimSide = pathCornerTrimsSide .. variantCurrentCornerTrim .. ".png"
            
            local img = Image{ fromFile=pathCurrentCornerTrimSide }

            cel.image = img
            cel.position = Point( drawX - (sectionWidth/2), drawY - 7 )
            replaceColours("trim", "top")

        -- Corner trim, centre
        elseif ix == buildingWidth then

            local trimCornerLayer = sprite:newLayer()
            trimCornerLayer.name = "corner trim level " .. iy
            trimCornerLayer.parent = trimCornerGroup

            local cel = sprite:newCel(trimCornerLayer, 1)
            local pathCurrentCornerTrimCentre = pathCornerTrimsCentre .. variantCurrentCornerTrim .. ".png"
            
            local img = Image{ fromFile=pathCurrentCornerTrimCentre }

            cel.image = img
            cel.position = Point( drawX + (sectionWidth/2), drawY + 7)
            replaceColours("trim", "top")

        end
    
        if ix > 1 then

            -- Vertical trim
            local trimVerticalLayer = sprite:newLayer()
            trimVerticalLayer.name = "vertical trim left level " .. iy .. ", section " .. ix
            trimVerticalLayer.parent = trimVerticalGroup

            local cel = sprite:newCel(trimVerticalLayer, 1)
            local variantCurrentVerticalTrim = tableColTrimsLeft[ix]
            local pathCurrentVerticalTrim = pathVerticalTrims .. variantCurrentVerticalTrim .. ".png"
            
            local img = Image{ fromFile=pathCurrentVerticalTrim }

            cel.image = img
            cel.position = Point( drawX - (sectionWidth/2), drawY - 7)
            replaceColours("trim", "top") -- Because the vertical trims contain a top section, so this fixes recolouring

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

                -- Replicated straight from walls to test
                drawX = drawStartX + ((ix - 1) * sectionWidth) + (sectionWidth / 2) + 2
                drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight) - 56

                -- Place it into the cel at a given position
                cel.image = img
                cel.position = Point( drawX, drawY )
                replaceColours("roof", "left")

                -- Roof sides and trims
                if ix == buildingWidth then
                
                    -- Roof side
                    local roofSideLeft = sprite:newLayer()
                    roofSideLeft.name = "roof side left"
                    roofSideLeft.parent = roofGroup

                    local cel = sprite:newCel(roofSideLeft, 1)

                    -- Roof side variant is wall variant
                    local variantCurrentRoofSide = variantCurrentWall
                    local pathCurrentRoofSide = pathRoofSidesLeft .. variantCurrentRoofSide .. ".png"
                    local img = Image{ fromFile=pathCurrentRoofSide }

                    drawX = drawStartX + ((ix - 1) * sectionWidth) + sectionWidth + 2
                    drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight) - sectionHeight + 1

                    -- Place it into the cel at a given position
                    cel.image = img
                    cel.position = Point( drawX, drawY )
                    replaceColours("wall", "right")
                
                    -- Roof trim fore
                    roofTrimLeft = sprite:newLayer()
                    roofTrimLeft.name = "roof trim left"
                    roofTrimLeft.parent = trimRoofGroupFore

                    local cel = sprite:newCel(roofTrimLeft, 1)

                    local pathCurrentRoofTrimLeft = pathRoofTrimsLeft .. variantCurrentRoofTrim .. ".png"
                    local img = Image{ fromFile=pathCurrentRoofTrimLeft }

                    drawX = drawStartX + ((ix - 1) * sectionWidth) + sectionWidth + 2
                    drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight) - sectionHeight + 1

                    -- Place it into the cel at a given position
                    cel.image = img
                    cel.position = Point( drawX, drawY )
                    replaceColours("trim", "top")
                
                    -- Roof trim rear
                    roofTrimLeftRear = sprite:newLayer()
                    roofTrimLeftRear.name = "roof trim left rear"
                    roofTrimLeftRear.parent = trimRoofGroupRear

                    local cel = sprite:newCel(roofTrimLeftRear, 1)

                    local pathCurrentRoofTrimLeft = pathRoofTrimsLeft .. variantCurrentRoofTrim .. ".png"
                    local img = Image{ fromFile=pathCurrentRoofTrimLeft }

                    drawX = drawX - (sectionWidth * buildingWidth) - 5
                    drawY = drawY - ((sectionWidth / 2) * buildingWidth) - 1

                    -- Place it into the cel at a given position
                    cel.image = img
                    cel.position = Point( drawX, drawY )
                    replaceColours("trim", "top")

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
        wallLayer.parent = wallsGroup

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
        windowLayer.parent = windowsRightGroup

        local cel = sprite:newCel(windowLayer, 1)
        local variantCurrentWindow = math.random(1)
        local pathCurrentWindow = pathWindows .. variantCurrentWindow .. ".png"
        
        local img = Image{ fromFile=pathCurrentWindow }

        cel.image = img
        app.command.Flip{ target="mask", orientation="horizontal" }
        cel.position = Point( drawX, drawY )
        replaceColours("trim", "right")

        -- Horizontal trim
        local trimHorizontalLayer = sprite:newLayer()
        trimHorizontalLayer.name = "horizontal trim right level " .. iy .. ", section " .. iz
        trimHorizontalLayer.parent = trimHorizontalRightGroup

        local cel = sprite:newCel(trimHorizontalLayer, 1)
        local variantCurrentHorizontalTrim = tableRowTrimsRight[iy]
        local pathCurrentHorizontalTrim = pathHorizontalTrims .. variantCurrentHorizontalTrim .. ".png"
        
        local img = Image{ fromFile=pathCurrentHorizontalTrim }

        cel.image = img
        app.command.Flip{ target="mask", orientation="horizontal" }
        cel.position = Point( drawX, drawY )
        replaceColours("trim", "right")

        if iy == buildingHeight then

            if iz > 1 then
                if iz < buildingDepth then

                    -- Gable horizontal trim
                    local trimGableLayer = sprite:newLayer()
                    trimGableLayer.name = "horizontal trim right gable, section " .. iz
                    trimGableLayer.parent = gableTrimHorizontalGroup

                    local cel = sprite:newCel(trimGableLayer, 1)
                    local variantCurrentHorizontalTrim = tableRowTrimsRight[iy]
                    local pathCurrentHorizontalTrim = pathHorizontalTrims .. variantCurrentHorizontalTrim .. ".png"
                    
                    local img = Image{ fromFile=pathCurrentHorizontalTrim }

                    cel.image = img
                    app.command.Flip{ target="mask", orientation="horizontal" }
                    cel.position = Point( drawX, drawY - sectionHeight - 7)
                    replaceColours("trim", "right")

                end
            end
        end

        -- Corner trim
        if iz == buildingDepth then

            local trimCornerLayer = sprite:newLayer()
            trimCornerLayer.name = "corner trim level " .. iy
            trimCornerLayer.parent = trimCornerGroup

            local cel = sprite:newCel(trimCornerLayer, 1)
            local pathCurrentCornerTrimSide = pathCornerTrimsSide .. variantCurrentCornerTrim .. ".png"
            
            local img = Image{ fromFile=pathCurrentCornerTrimSide }

            cel.image = img
            app.command.Flip{ target="mask", orientation="horizontal" }
            cel.position = Point( drawX + (sectionWidth/2), drawY - 8)
            replaceColours("trim", "top")

        else
            -- Vertical trim
            local trimVerticalLayer = sprite:newLayer()
            trimVerticalLayer.name = "vertical trim right level " .. iy .. ", section " .. iz
            trimVerticalLayer.parent = trimVerticalGroup

            local cel = sprite:newCel(trimVerticalLayer, 1)
            local variantCurrentVerticalTrim = tableColTrimsRight[iz]
            local pathCurrentVerticalTrim = pathVerticalTrims .. variantCurrentVerticalTrim .. ".png"
            
            local img = Image{ fromFile=pathCurrentVerticalTrim }

            cel.image = img
            app.command.Flip{ target="mask", orientation="horizontal" }
            cel.position = Point( drawX + (sectionWidth/2), drawY - 7)
            replaceColours("trim", "left") -- Because vertical trims contain a top colour, so this moves colours "up" one to fix

        end

        -- Gable check
        if iy == buildingHeight then

            if iz < buildingDepth then

                -- Gable vertical trim
                local trimGableLayer = sprite:newLayer()
                trimGableLayer.name = "vertical trim right gable, section " .. iz
                trimGableLayer.parent = gableTrimVerticalGroup

                local cel = sprite:newCel(trimGableLayer, 1)
                local variantCurrentVerticalTrim = tableColTrimsRight[iz]
                local pathCurrentVerticalTrim = pathVerticalTrims .. variantCurrentVerticalTrim .. ".png"
                
                local img = Image{ fromFile=pathCurrentVerticalTrim }

                cel.image = img
                app.command.Flip{ target="mask", orientation="horizontal" }
                cel.position = Point( drawX + (sectionWidth/2), drawY - sectionHeight - 7)
                replaceColours("trim", "left")

            end

            -- Flipped gable process
            if gableSide == "right" then

            -- If gable isn't this end...
            else
                -- If we are section buildingDepth, add the flipped diagonal gable face and roof trim
                if iz == buildingDepth then

                    local roofSideRight = sprite:newLayer()
                    roofSideRight.name = "roof side right"
                    roofSideRight.parent = roofGroup

                    local cel = sprite:newCel(roofSideRight, 1)

                    -- Choose a roof side variant
                    local variantCurrentRoofSide = variantCurrentWall
                    local pathCurrentRoofSide = pathRoofSidesRight .. variantCurrentRoofSide .. ".png"
                    local img = Image{ fromFile=pathCurrentRoofSide }

                    drawX = drawStartX + (sectionWidth * buildingWidth) + (iz - 1) * (sectionWidth) - 1
                    drawY = drawStartY + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionWidth/2) - sectionHeight + 9

                    -- Place it into the cel at a given position
                    cel.image = img
                    cel.position = Point( drawX, drawY )
                    replaceColours("wall", "right")

                    -- Roof trim fore
                    roofTrimRight = sprite:newLayer()
                    roofTrimRight.name = "roof trim right"
                    roofTrimRight.parent = trimRoofGroupFore

                    local cel = sprite:newCel(roofTrimRight, 1)

                    local pathCurrentRoofTrimRight = pathRoofTrimsRight .. variantCurrentRoofTrim .. ".png"
                    local img = Image{ fromFile=pathCurrentRoofTrimRight }

                    drawX = drawStartX + (sectionWidth * buildingWidth) + (iz - 1) * (sectionWidth) + 2
                    drawY = drawStartY + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionWidth/2) - sectionHeight + 1

                    -- Place it into the cel at a given position
                    cel.image = img
                    cel.position = Point( drawX, drawY )
                    replaceColours("trim", "top")

                    -- Roof trim rear
                    roofTrimRightRear = sprite:newLayer()
                    roofTrimRightRear.name = "roof trim right rear"
                    roofTrimRightRear.parent = trimRoofGroupRear

                    local cel = sprite:newCel(roofTrimRightRear, 1)

                    local pathCurrentRoofTrimRight = pathRoofTrimsRight .. variantCurrentRoofTrim .. ".png"
                    local img = Image{ fromFile=pathCurrentRoofTrimRight }

                    drawX = drawX - (sectionWidth * buildingWidth) - 5
                    drawY = drawY - ((sectionWidth / 2) * buildingWidth) - 1

                    -- Place it into the cel at a given position
                    cel.image = img
                    cel.position = Point( drawX, drawY )
                    replaceColours("trim", "top")


                -- Else if we aren't the first section, add a flat gable end (current wall variant), and centre roof trim
                elseif iz > 1 then

                    -- Flat gable
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

                    -- Centre roof trim fore
                    local roofTrimCentre = sprite:newLayer()
                    roofTrimCentre.name = "roof trim centre"
                    roofTrimCentre.parent = trimRoofGroupFore

                    -- Reorder layers
                    roofTrimCentre.stackIndex = 0

                    local cel = sprite:newCel(roofTrimCentre, 1)

                    local pathCurrentRoofTrimCentre = pathRoofTrimsCentre .. variantCurrentRoofTrim .. ".png"
                    local img = Image{ fromFile=pathCurrentRoofTrimCentre }

                    drawX = drawStartX + (sectionWidth * buildingWidth) + (iz - 1) * (sectionWidth) + 4
                    drawY = drawStartY + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionWidth/2) - (sectionHeight * 1.5) - 3

                    -- Place it into the cel at a given position
                    cel.image = img
                    cel.position = Point( drawX, drawY )
                    replaceColours("trim", "top")

                    -- Centre roof trim rear
                    local roofTrimCentreRear = sprite:newLayer()
                    roofTrimCentreRear.name = "roof trim centre"
                    roofTrimCentreRear.parent = trimRoofGroupRear

                    -- Reorder layers
                    roofTrimCentreRear.stackIndex = 0

                    local cel = sprite:newCel(roofTrimCentreRear, 1)

                    local pathCurrentRoofTrimCentre = pathRoofTrimsCentre .. variantCurrentRoofTrim .. ".png"
                    local img = Image{ fromFile=pathCurrentRoofTrimCentre }

                    drawX = drawX - (sectionWidth * buildingWidth) - 5
                    drawY = drawY - ((sectionWidth / 2) * buildingWidth) - 1

                    -- Place it into the cel at a given position
                    cel.image = img
                    cel.position = Point( drawX, drawY )
                    replaceColours("trim", "top")

                end
            end
        end

    end
end

local bx, bz
local baseDrawX = drawStartX + (buildingDepth * sectionWidth)
local baseDrawY = drawStartY - (buildingDepth * (sectionWidth / 2)) - sectionWidth

-- Base loop
for bz = 0, buildingDepth + 1, 1 do
    for bx = 0, buildingWidth + 1, 1 do

        -- Base
        local baseLayer = sprite:newLayer()
        baseLayer.name = "base " .. bx .. ", section " .. bz
        baseLayer.parent = baseGroup

        local cel = sprite:newCel(baseLayer, 1)
        local pathCurrentBase = pathBase .. math.random(baseVariantCount) .. ".png"
        local img = Image{ fromFile=pathCurrentBase }

        -- Place it into the cel at a given position
        cel.image = img
        --cel.position = Point( baseDrawX + (sectionWidth * (bx)) - (sectionWidth / 2), baseDrawY - 16 + ((sectionHeight / 2) * bx) + (bz * sectionHeight/2) )
        cel.position = Point( baseDrawX + (sectionWidth * (bx)) - (sectionWidth / 2), baseDrawY - 16 + ((sectionHeight / 2) * bx)  - (8 * bx) )
        replaceColours("base", "top")
        
    end
    bx = 0
    baseDrawX = baseDrawX - sectionWidth
    baseDrawY = baseDrawY + (sectionWidth / 2)
end

------------------------------------------------------------------------------------------------------------------------
-- Reorder layers
local numberOfRoofTrims = #(trimRoofGroupFore.layers)
roofTrimRight.stackIndex = 0
roofTrimLeft.stackIndex = numberOfRoofTrims

roofTrimRightRear.stackIndex = 0
roofTrimLeftRear.stackIndex = numberOfRoofTrims

------------------------------------------------------------------------------------------------------------------------
app.refresh()

-- Get formatted date and time
local formattedDateAndTime = os.date("%d%m%y %H%M%S")

-- Export as a PNG
app.command.saveFileCopyAs {
    ui=false,
    filename="C:\\Users\\hidde\\Pictures\\aseprite\\generate-building\\" .. formattedDateAndTime .. ".png",
}