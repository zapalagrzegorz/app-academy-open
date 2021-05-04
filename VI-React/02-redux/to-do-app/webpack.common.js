const path = require('path');
// const webpack = require('webpack');

module.exports = {
  entry: './frontend/todo_redux.jsx',
  output: {
    path: path.resolve(__dirname, 'app/assets/javascripts'),
  },

  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
    ],
  },
  resolve: {
    extensions: ['.js', '.jsx'],
  },
};
