-- Clipboard: WSL clipboard integration
local is_wsl = (vim.fn.has("wsl") == 1)
  or (vim.env.WSL_INTEROP ~= nil)
  or (vim.env.WSL_DISTRO_NAME ~= nil)

if is_wsl then
  -- Use Windows clipboard via built-ins
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
