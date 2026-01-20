return {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx'
    },
    root_markers = {
        'tsconfig.json',
        'jsconfig.json',
        'package.json',
    },
    settings = {
        typescript = {
            indentStyle = "space",
            indentSize = 2,
        },
    },
}
