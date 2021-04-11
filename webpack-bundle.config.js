const path = require("path");
const { merge } = require("webpack-merge");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const TerserPlugin = require("terser-webpack-plugin");
const commonConfig = require("./webpack-common.config.js");

module.exports = merge(commonConfig, {
  mode: "production",
  devtool: "source-map",
  entry: "./src/index-bundle.js",
  output: { filename: "main.js", path: path.resolve(__dirname, "dist") },
  optimization: {
    minimize: true,
    minimizer: [
      new TerserPlugin({
        // Use multi-process parallel running to improve the build speed
        // Default number of concurrent runs: os.cpus().length - 1
        parallel: true,
      }),
    ],
  },
});
