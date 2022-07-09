vim.o.mouse = "a"
local keys = {
    "ScrollWheelUp",
    "ScrollWheelDown",
    "ScrollWheelLeft",
    "ScrollWheelRight",
}
local modes = { "n", "i", "v" }
for _, key in ipairs(keys) do
    for _, mode in ipairs(modes) do
        vim.keymap.set(mode, '<'   .. key .. '>', '<nop>', {})
        vim.keymap.set(mode, '<S-' .. key .. '>', '<nop>', {})
        vim.keymap.set(mode, '<C-' .. key .. '>', '<nop>', {})
    end
end
