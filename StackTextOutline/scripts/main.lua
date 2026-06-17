-- Size: 0+ | Color channels (R/G/B): 0.0–1.0 | Alpha: 0.0 (transparent) – 1.0 (opaque)
local OUTLINE_SIZE  = 2
local OUTLINE_RED   = 0.004
local OUTLINE_GREEN = 0.004
local OUTLINE_BLUE  = 0.004
local OUTLINE_ALPHA = 1.0

local function ApplyOutline(tb)
    if not tb or not tb:IsValid() then return end
    local font = tb.Font
    font.OutlineSettings.OutlineSize    = OUTLINE_SIZE
    font.OutlineSettings.OutlineColor.R = OUTLINE_RED
    font.OutlineSettings.OutlineColor.G = OUTLINE_GREEN
    font.OutlineSettings.OutlineColor.B = OUTLINE_BLUE
    font.OutlineSettings.OutlineColor.A = OUTLINE_ALPHA
    tb.Font = font
end

local function ShouldApply(tb)
    local name = tb:GetFullName()
    return name:find("AmountText")
        and not name:find("BP_RepairCost")
        and not name:find("PrimarySlot")
        and not name:find("SecondarySlot")
end

-- Intercept every TextBlock the engine creates, globally
NotifyOnNewObject("/Script/UMG.TextBlock", function(tb)
    if ShouldApply(tb) then ApplyOutline(tb) end
end)

-- Apply to any AmountText TextBlocks already loaded
local existing = FindAllOf("TextBlock")
if existing then
    for _, tb in pairs(existing) do
        if tb:IsValid() and ShouldApply(tb) then ApplyOutline(tb) end
    end
end

print("[StackTextOutline] Mod loaded.\n")
