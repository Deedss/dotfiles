require("bufferline").setup{
    options = {
    show_buffer_icons = false,
    show_close_icon = false,
    show_buffer_close_icons = false,
    numbers = function(opts)
        return string.format('[%s]', opts.id)
    end
},
}