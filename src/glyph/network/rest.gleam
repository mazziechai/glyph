//// This handles the logic for communicating with the Discord REST API. For more information: https://discord.com/developers/docs/reference#http-api

import gleam/hackney.{type Error as HackneyError}
import gleam/http
import gleam/http/request
import gleam/http/response

const api_version = "v10"

/// Acceptable values for an Authorization header
pub type TokenType {
  Bearer
  Bot
}

fn token_type_to_string(token_type: TokenType) -> String {
  case token_type {
    Bearer -> "Bearer"
    Bot -> "Bot"
  }
}

pub fn set_bot_user_agent(
  r: request.Request(a),
  url: String,
  version: String,
) -> request.Request(a) {
  r
  |> request.set_header(
    "User-Agent",
    "DiscordBot(" <> url <> ", " <> version <> ")",
  )
}

pub fn set_authorization(
  r: request.Request(String),
  token_type: TokenType,
  token: String,
) -> request.Request(String) {
  r
  |> request.set_header(
    "Authorization",
    token_type_to_string(token_type) <> " " <> token,
  )
}

pub fn new() -> request.Request(String) {
  request.new()
  |> request.set_scheme(http.Https)
  |> request.set_host("discord.com")
}

pub fn get(
  r: request.Request(String),
  endpoint: String,
) -> Result(response.Response(String), HackneyError) {
  r
  |> request.set_method(http.Get)
  |> request.set_path("/api/" <> api_version <> endpoint)
  |> hackney.send
}