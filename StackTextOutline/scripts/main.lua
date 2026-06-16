local OUTLINE_SIZE  = 2
local OUTLINE_RED   = 0.0
local OUTLINE_GREEN = 0.0
local OUTLINE_BLUE  = 0.0
local OUTLINE_ALPHA = 1.0

local function ApplyOutlineToAmountText(tb)
    if not tb then return end

    local widget = tb:get()

    if not widget or not widget:IsValid() then return end

    local font = widget.Font

    font.OutlineSettings.OutlineSize    = OUTLINE_SIZE
    font.OutlineSettings.OutlineColor.R = OUTLINE_RED
    font.OutlineSettings.OutlineColor.G = OUTLINE_GREEN
    font.OutlineSettings.OutlineColor.B = OUTLINE_BLUE
    font.OutlineSettings.OutlineColor.A = OUTLINE_ALPHA

    widget.Font = font

    print("[StackTextOutline] Outline applied.\n")
end

RegisterHook(
    "/Game/SurvivalGameKitV2/Blueprints/Widgets/BP_InventoryItemIcon.BP_InventoryItemIcon_C:Construct",
    function(self)
        ApplyOutlineToAmountText(self.AmountText)
    end
)

-- Fallback scan for already-existing widgets
ExecuteWithDelay(2000, function()
    local allTextBlocks = FindAllOf("TextBlock")
    if not allTextBlocks then return end

    local count = 0
    for _, tb in pairs(allTextBlocks) do
        -- In the fallback scan, FindAllOf returns objects directly
        -- so no :get() needed here — just IsValid() directly
        if tb:IsValid() then
            local name = tb:GetFullName()
            if name:find("AmountText") then
                local font = tb.Font
                font.OutlineSettings.OutlineSize    = OUTLINE_SIZE
                font.OutlineSettings.OutlineColor.R = OUTLINE_RED
                font.OutlineSettings.OutlineColor.G = OUTLINE_GREEN
                font.OutlineSettings.OutlineColor.B = OUTLINE_BLUE
                font.OutlineSettings.OutlineColor.A = OUTLINE_ALPHA
                tb.Font = font
                count = count + 1
            end
        end
    end

    print(string.format("[StackTextOutline] Fallback scan outlined %d widget(s).\n", count))
end)

print("[StackTextOutline] Mod loaded.\n")