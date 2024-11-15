return {
  "mfussenegger/nvim-dap",

  dependencies = {
    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
  },

  config = function()
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { desc = "DAP: " .. desc })
    end

    map("<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
      "Breakpoint Condition")
    map("<leader>db", function() require("dap").toggle_breakpoint() end, "Toggle Breakpoint")
    map("<leader>dc", function() require("dap").continue() end, "Continue")
    map("<leader>dC", function() require("dap").run_to_cursor() end, "Run to Cursor")
    map("<leader>dg", function() require("dap").goto_() end, "Go to line (no execute)")
    map("<leader>di", function() require("dap").step_into() end, "Step Into")
    map("<leader>dj", function() require("dap").down() end, "Down")
    map("<leader>dk", function() require("dap").up() end, "Up")
    map("<leader>dl", function() require("dap").run_last() end, "Run Last")
    map("<leader>do", function() require("dap").step_out() end, "Step Out")
    map("<leader>dO", function() require("dap").step_over() end, "Step Over")
    map("<leader>dp", function() require("dap").pause() end, "Pause")
    map("<leader>dr", function() require("dap").repl.toggle() end, "Toggle REPL")
    map("<leader>ds", function() require("dap").session() end, "Session")
    map("<leader>dt", function() require("dap").terminate() end, "Terminate")
    map("<leader>dw", function() require("dap.ui.widgets").hover() end, "Widgets")

    -- C / C++ / RUST debug adapter
    local dap = require("dap")
    local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
    if not dap.adapters["codelldb"] then
      require("dap").adapters["codelldb"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = mason_path .. "bin/codelldb",
          args = {
            "--port",
            "${port}",
          },
        },
      }
    end
    for _, lang in ipairs({ "c", "cpp", "rust" }) do
      dap.configurations[lang] = {
        {
          type = "codelldb",
          request = "launch",
          name = "Launch file",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        }
      }
    end
  end,
}
