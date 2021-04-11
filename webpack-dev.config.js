const path = require("path");
const { merge } = require("webpack-merge");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const commonConfig = require("./webpack-common.config.js");
// const WorkboxPlugin = require("workbox-webpack-plugin");

module.exports = merge(commonConfig, {
  mode: "development",
  entry: "./src/index-dev.js",
  devtool: "inline-source-map",
  devServer: {
    contentBase: "./dist",
    hot: true,
  },
  output: {
    filename: "main.js",
    path: path.resolve(__dirname, "dist"),
  },
  module: {
    rules: [
      {
        test: /\.purs$/,
        use: { loader: "purs-loader", options: { spago: true } },
      },
    ],
  },
});
