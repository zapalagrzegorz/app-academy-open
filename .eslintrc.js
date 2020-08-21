module.exports = {
  root: true,
  env: {
    es2020: true,
    browser: true,
    commonjs: true,
  },
  extends: 'eslint:recommended',
  parserOptions: {
    ecmaVersion: 11,
    sourceType: 'module',
  },
  rules: {
    indent: ['error', 2],
    'linebreak-style': ['error', 'unix'],
    quotes: ['warn', 'single'],
    semi: ['error', 'always'],
  },
};
