------------------------------------------------------------------------------------------------------------------------
-- SETUP
-- Define variables
local canvasWidth = 400
local canvasHeight = 480

local sectionWidth = 32
local sectionHeight = 48

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

local wallVariantCount = 10
local windowVariantCount = 10
local horizontalTrimVariantCount = 10
local verticalTrimVariantCount = 10
local cornerTrimVariantCount = 10
local roofVariantCount = 10
local doorVariantCount = 10
local baseVariantCount = 10

-- Defining the colours we replace in the original sprites
local color1A = Color{ r=255, g=255, b=255, a=255 }
local color1B = Color{ r=203, g=219, b=252, a=255 }
local color1C = Color{ r=155, g=173, b=183, a=255 }

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

function placeComponent(componentName, componentGroup, componentTypePath, componentVariant, componentX, componentY, componentType, componentDirection, booleanFlipped)

        local componentLayer = sprite:newLayer()
        componentLayer.name = componentName
        componentLayer.parent = componentGroup

        local cel = sprite:newCel(componentLayer, 1)

        local pathComponent = componentTypePath .. componentVariant .. ".png"
        local img = Image{ fromFile=pathComponent }

        -- Place it into the cel at a given position
        cel.image = img
        if booleanFlipped == true then
            app.command.Flip{ target="mask", orientation="horizontal" }
        end
        cel.position = Point( componentX, componentY )
        replaceColours(componentType, componentDirection)
end

------------------------------------------------------------------------------------------------------------------------
-- Establish building variables; how many sections wide, tall, etc
local buildingWidth = math.random(2, 4)
local buildingHeight = math.random(1, 5)
local buildingDepth = math.random(2, 4)

-- Choose variants
local variantCurrentWall = math.random(wallVariantCount)
local variantCurrentWindow = math.random(windowVariantCount)
local variantCurrentCornerTrim = math.random(cornerTrimVariantCount)
local variantCurrentDoor = math.random(doorVariantCount)
local variantCurrentRoof = math.random(roofVariantCount)
local variantCurrentRoofTrim = 1

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

local trimVerticalGroup = sprite:newGroup()
trimVerticalGroup.name = "vertical trims"
trimVerticalGroup.isCollapsed = true

local windowsLeftGroup = sprite:newGroup()
windowsLeftGroup.name = "windows, left"
windowsLeftGroup.isCollapsed = true

local windowsRightGroup = sprite:newGroup()
windowsRightGroup.name = "windows, right"
windowsRightGroup.isCollapsed = true

local trimRoofGroupRearRight = sprite:newGroup()
trimRoofGroupRearRight.name = "roof trims rear right"
trimRoofGroupRearRight.isCollapsed = true

local trimRoofGroupRearCentre = sprite:newGroup()
trimRoofGroupRearCentre.name = "roof trims rear centre"
trimRoofGroupRearCentre.isCollapsed = true

local trimRoofGroupRearLeft = sprite:newGroup()
trimRoofGroupRearLeft.name = "roof trims rear left"
trimRoofGroupRearLeft.isCollapsed = true

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

local trimRoofGroupForeRight = sprite:newGroup()
trimRoofGroupForeRight.name = "roof trims fore right"
trimRoofGroupForeRight.isCollapsed = true

local trimRoofGroupForeCentre = sprite:newGroup()
trimRoofGroupForeCentre.name = "roof trims fore centre"
trimRoofGroupForeCentre.isCollapsed = true

local trimRoofGroupForeLeft = sprite:newGroup()
trimRoofGroupForeLeft.name = "roof trims fore left"
trimRoofGroupForeLeft.isCollapsed = true

------------------------------------------------------------------------------------------------------------------------
-- Nested loop to build sections for as many times as building is wide, and then for as many times as the building is high
local ix, iy, iz

-- Calculate draw start position based on building sections
local buildingPixelWidth = (buildingWidth + buildingDepth) * (sectionWidth + 2)
local buildingPixelHeight = (buildingHeight * sectionHeight) + (buildingWidth * sectionWidth) + (sectionHeight + 2) * 3

local drawStartX = ((canvasWidth - buildingPixelWidth) / 2) - (sectionWidth / 2)
local drawStartY = canvasHeight - ((canvasHeight - buildingPixelHeight) / 2) - sectionHeight - (buildingWidth * sectionWidth) + sectionHeight/2

local drawX
local drawY

for iy = 1, buildingHeight, 1 do
    for ix = 1, buildingWidth, 1 do

        -- Walls
        drawX = drawStartX + ((ix - 1) * sectionWidth) + 1
        drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight)
        placeComponent("walls left", wallsGroup, pathWalls, variantCurrentWall, drawX, drawY, "wall", "left", false)

        -- Door or window
        if iy == 1 then
            if ix == doorLocation then
                placeComponent("door", windowsLeftGroup, pathDoors, variantCurrentDoor, drawX, drawY, "trim", "left", false)
            end
        else
            placeComponent("windows left", windowsLeftGroup, pathWindows, variantCurrentWindow, drawX, drawY, "trim", "left", false)
        end

        -- Horizontal trim
        placeComponent("horizontal trim left", trimHorizontalLeftGroup, pathHorizontalTrims, tableRowTrimsLeft[iy], drawX, drawY, "trim", "left", false)

        -- Corner trim, side
        if ix == 1 then
            placeComponent("corner trim", trimCornerGroup, pathCornerTrimsSide, variantCurrentCornerTrim, drawX - (sectionWidth/2), drawY - 7, "trim", "top", false)

        -- Corner trim, centre
        elseif ix == buildingWidth then
            placeComponent("corner trim", trimCornerGroup, pathCornerTrimsCentre, variantCurrentCornerTrim, drawX + (sectionWidth/2), drawY + 7, "trim", "top", false)
        end
    
        -- Vertical trim
        if ix > 1 then
            placeComponent("vertical trim left", trimVerticalGroup, pathVerticalTrims, tableColTrimsLeft[ix], drawX - (sectionWidth/2), drawY - 7, "trim", "top", false)
        end

        -- Gable
        if iy == buildingHeight then

            -- Replicated straight from walls to test
            drawX = drawStartX + ((ix - 1) * sectionWidth) + (sectionWidth / 2) + 1
            drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight) - 56
            placeComponent("roof left", roofGroup, pathRooves, variantCurrentRoof, drawX, drawY, "roof", "left", false)

            -- Roof sides and trims
            if ix == buildingWidth then
                
                drawX = drawStartX + ((ix - 1) * sectionWidth) + sectionWidth + 1
                drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight) - sectionHeight + 2
                placeComponent("roof side left", roofGroup, pathRoofSidesLeft, variantCurrentWall, drawX, drawY, "wall", "right", false)
            
                -- Roof trim fore
                drawX = drawStartX + ((ix - 1) * sectionWidth) + sectionWidth + 2
                drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight) - sectionHeight + 1
                placeComponent("roof trim left fore", trimRoofGroupForeLeft, pathRoofTrimsLeft, variantCurrentRoofTrim, drawX, drawY, "trim", "top", false)

                -- Roof trim rear
                drawX = drawX - (sectionWidth * buildingWidth) - 3
                drawY = drawY - ((sectionWidth / 2) * buildingWidth) - 2
                placeComponent("roof trim left rear", trimRoofGroupRearLeft, pathRoofTrimsLeft, variantCurrentRoofTrim, drawX, drawY, "trim", "top", false)

            end

            -- Rooftops
            if buildingDepth > 2 then

                -- Insert for loop up to building depth
                local roofTopN
                for roofTopN = 1, buildingDepth - 2, 1 do

                    drawX = drawStartX + ((ix - 1) * sectionWidth) + (sectionWidth / 2) + (sectionWidth * roofTopN) + 1
                    drawY = drawStartY + ((ix - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionHeight * 2) - ((sectionWidth/2) * (roofTopN - 1)) - 2
                    placeComponent("roof top", roofGroup, pathRooftops, variantCurrentRoof, drawX, drawY, "roof", "top", false)

                end
            end
        end
    end
end

-- Reset and go again for the other side
for iy = 1, buildingHeight, 1 do
    for iz = 1, buildingDepth, 1 do

        -- Walls
        drawX = drawStartX + (sectionWidth * buildingWidth) + (iz - 1) * (sectionWidth) + 1
        drawY = drawStartY + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionWidth/2) + 1
        placeComponent("walls right", wallsGroup, pathWalls, variantCurrentWall, drawX, drawY, "wall", "right", true)
            
        -- Window
        placeComponent("walls right", windowsRightGroup, pathWindows, variantCurrentWindow, drawX, drawY, "trim", "right", true)

        -- Horizontal trim
        placeComponent("horizontal trim right", trimHorizontalRightGroup, pathHorizontalTrims, tableRowTrimsRight[iy], drawX, drawY, "trim", "right", true)

        -- Gable horizontal trim
        if (iy == buildingHeight and iz > 1 and iz < buildingDepth) then
            placeComponent("horizontal trim right gable", gableTrimHorizontalGroup, pathHorizontalTrims, tableRowTrimsRight[iy], drawX, drawY - sectionHeight - 7, "trim", "right", true)
        end

        -- Corner trim
        if iz == buildingDepth then
            placeComponent("corner trim", trimCornerGroup, pathCornerTrimsSide, variantCurrentCornerTrim, drawX + (sectionWidth/2), drawY - 8, "trim", "top", true)
        else
            -- Vertical trim
            placeComponent("vertical trim right", trimVerticalGroup, pathVerticalTrims, tableColTrimsRight[iz], drawX + (sectionWidth/2), drawY - 7, "trim", "left", true)
        end

        -- Gable check
        if iy == buildingHeight then

            -- Gable vertical trim
            if iz < buildingDepth then
                placeComponent("vertical trim right gable", gableTrimVerticalGroup, pathVerticalTrims, tableColTrimsRight[iz], drawX + (sectionWidth/2), drawY - sectionHeight - 7, "trim", "left", true)
            end

            -- If we are section buildingDepth, add the flipped diagonal gable face and roof trim
            if iz == buildingDepth then

                drawX = drawStartX + (sectionWidth * buildingWidth) + (iz - 1) * (sectionWidth) - 1
                drawY = drawStartY + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionWidth/2) - sectionHeight + 9
                placeComponent("roof side right", roofGroup, pathRoofSidesRight, variantCurrentWall, drawX, drawY, "wall", "right", false)

                -- Roof trim fore
                drawX = drawStartX + (sectionWidth * buildingWidth) + (iz - 1) * (sectionWidth) + 2
                drawY = drawStartY + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionWidth/2) - sectionHeight + 1
                placeComponent("roof trim right fore", trimRoofGroupForeRight, pathRoofTrimsRight, variantCurrentRoofTrim, drawX, drawY, "trim", "top", false)

                -- Roof trim rear
                drawX = drawX - (sectionWidth * buildingWidth) - 3
                drawY = drawY - ((sectionWidth / 2) * buildingWidth) - 2
                placeComponent("roof trim right rear", trimRoofGroupRearRight, pathRoofTrimsRight, variantCurrentRoofTrim, drawX, drawY, "trim", "top", false)

            -- Else if we aren't the first section, add a flat gable end (current wall variant), and centre roof trim
            elseif iz > 1 then

                -- Flat gable
                drawX = drawStartX + (sectionWidth * buildingWidth) + (iz - 1) * (sectionWidth) + 1
                drawY = drawStartY + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionWidth/2) - sectionHeight + 1
                placeComponent("gable end", roofGroup, pathWalls, variantCurrentWall, drawX, drawY, "wall", "right", true)

                -- Centre roof trim fore
                drawX = drawStartX + (sectionWidth * buildingWidth) + (iz - 1) * (sectionWidth) + 4
                drawY = drawStartY + (buildingWidth * (sectionWidth/2)) - ((iz - 1) * (sectionWidth/2)) - (iy * sectionHeight) - (sectionWidth/2) - (sectionHeight * 1.5) - 3
                placeComponent("roof trim centre fore", trimRoofGroupForeCentre, pathRoofTrimsCentre, variantCurrentRoofTrim, drawX, drawY, "trim", "top", false)

                -- Centre roof trim rear
                drawX = drawX - (sectionWidth * buildingWidth) - 3
                drawY = drawY - ((sectionWidth / 2) * buildingWidth) - 2
                placeComponent("roof trim centre rear", trimRoofGroupRearCentre, pathRoofTrimsCentre, variantCurrentRoofTrim, drawX, drawY, "trim", "top", false)

                -- Reorder layers
                app.transaction(function()

                    local foreLayers = {}
                    local rearLayers = {}

                    for i, layer in ipairs(trimRoofGroupForeCentre.layers) do
                        table.insert(foreLayers, layer)
                        table.insert(rearLayers, trimRoofGroupRearCentre.layers[i])
                    end

                    -- Reverse both groups identically
                    for i = #foreLayers, 1, -1 do
                        local newIndex = #foreLayers - i + 1

                        foreLayers[i].stackIndex = newIndex
                        rearLayers[i].stackIndex = newIndex
                    end

                end)

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
        placeComponent("base", baseGroup, pathBase, math.random(baseVariantCount), baseDrawX + (sectionWidth * (bx)) - (sectionWidth / 2), baseDrawY - (sectionWidth / 2) + ((sectionHeight / 2) * bx)  - (8 * bx) , "base", "top", false)  
    end
    bx = 0
    baseDrawX = baseDrawX - sectionWidth
    baseDrawY = baseDrawY + (sectionWidth / 2)
end

------------------------------------------------------------------------------------------------------------------------
app.refresh()

-- Get formatted date and time
local formattedDateAndTime = os.date("%d%m%y %H%M%S")

-- Export as a PNG
app.command.saveFileCopyAs {
    ui=false,
    filename="C:\\Users\\hidde\\Pictures\\aseprite\\generate-building\\" .. formattedDateAndTime .. ".png",
}