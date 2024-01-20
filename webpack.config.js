// webpack.config.js

const { VueLoaderPlugin } = require('vue-loader')
const { WebpackManifestPlugin } = require('webpack-manifest-plugin')
const path = require('path')

module.exports = {
  mode: 'development',
  entry: {
    menu: './app/javascripts/menu.js',
    relationship: './app/javascripts/relationship.js',
  },
  output: {
    path: path.resolve(__dirname, './public/assets'),
    filename: '[name].js',
  },
  module: {
    rules: [
      {
        test: /\.vue$/,
        loader: 'vue-loader',
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
      {
        test: /\.(css|sass|scss)$/,
        use: ['vue-style-loader', 'css-loader', 'sass-loader'],
      },
      {
        test: /\.(jpg|png|gif)$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              outputPath: 'images',
              publicPath: 'assets/images',
              name: '[name].[ext]',
            },
          },
        ],
      },
    ],
  },
  plugins: [new VueLoaderPlugin(), new WebpackManifestPlugin()],
  resolve: {
    alias: {
      vue$: 'vue/dist/vue.runtime.esm-bundler.js',
    },
  },
  devServer: {
    disableHostCheck: true,
    hot: true,
    public: 'localhost:8080',
    headers: {
      'Access-Control-Allow-Origin': '*',
    },
    contentBase: path.resolve(__dirname, '../../public/assets'),
  },
}
