vim.g.rainbow_conf = {
  guifgs = {'royalblue3', 'darkorange3', 'seagreen3', 'firebrick'},
  ctermfgs = {'lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'},
  guis = {''},
  cterms = {''},
  operators = '_,_',
  parentheses = {
    {start = '(', end = ')', fold = true},
    {start = '[', end = ']', fold = true},
    {start = '{', end = '}', fold = true},
  },
  separately = {
    ['*'] = {},
    lua = {
      parentheses = {
        {start = '(', end = ')', fold = true},
        {start = '[', end = ']', fold = true},
        {start = '{', end = '}', fold = true},
      },
    },
    markdown = {
      parentheses_options = 'containedin=markdownCode contained', -- enable rainbow for code blocks only
    },
    lisp = {
      guifgs = {'royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'}, -- lisp needs more colors for parentheses
    },
    haskell = {
      parentheses = {
        {start = '(', end = ')', fold = true},
        {start = '[', end = ']', fold = true},
        {start = '\\v\\{\\ze[^-]', end = '}', fold = true}, -- the haskell lang pragmas should be excluded
      },
    },
    vim = {
      parentheses_options = 'containedin=vimFuncBody', -- enable rainbow inside vim function body
    },
    perl = {
      syn_name_prefix = 'perlBlockFoldRainbow', -- solve the perl indent-depending-on-syntax problem
    },
    stylus = {
      parentheses = {
        {start = '{', end = '}', fold = true, contains = '@colorableGroup'}, -- vim css color compatibility
      },
    },
    css = 0, -- disable this plugin for css files
    nerdtree = 0, -- rainbow is conflicting with NERDTree, creating extra parentheses
  },
}

