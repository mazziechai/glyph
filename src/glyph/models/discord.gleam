//// This contains all types needed to communicate with either the Gateway or REST API.

import gleam/option.{type Option}

/// The data structure Discord uses for UUIDs: https://discord.com/developers/docs/reference#snowflakes
pub type Snowflake =
  String

/// Model for a Discord Application: https://discord.com/developers/docs/resources/application
/// Note to self: summary is deprecated and will be removed in v11
pub type Application {
  Application(
    id: Snowflake,
    name: String,
    icon: Option(String),
    description: String,
    rpc_origins: Option(List(String)),
    bot_public: Bool,
    bot_require_code_grant: Bool,
    bot: Option(Bot),
    terms_of_service_url: Option(String),
    privacy_policy_url: Option(String),
    owner: Option(Owner),
    summary: Option(String),
    verify_key: String,
    team: Option(Team),
    guild_id: Option(Snowflake),
    primary_sku_id: Option(Snowflake),
    slug: Option(String),
    cover_image: Option(String),
    flags: Option(Int),
    approximate_guild_count: Option(Int),
    redirect_uris: Option(List(String)),
    interactions_endpoint_url: Option(String),
    role_connections_verification_url: Option(String),
    tags: Option(List(String)),
    install_params: Option(InstallParams),
    custom_install_url: Option(String),
  )
}

/// Model for a Discord User: https://discord.com/developers/docs/resources/user#user-object
/// Some additional fields marked as optional here due to the use of partial user objects
/// in other areas of the API.
pub type User {
  User(
    id: Snowflake,
    username: String,
    discriminator: String,
    global_name: Option(String),
    avatar: Option(String),
    bot: Option(Bool),
    system: Option(Bool),
    mfa_enabled: Option(Bool),
    banner: Option(String),
    accent_color: Option(Int),
    locale: Option(String),
    email: Option(String),
    flags: Option(Int),
    premium_type: Option(Int),
    public_flags: Option(Int),
    avatar_decoration: Option(String),
  )
}

pub type Bot =
  User

pub type Owner =
  User

/// Model for a Team object: https://discord.com/developers/docs/topics/teams#data-models-team-object
pub type Team {
  Team(
    id: Snowflake,
    icon: Option(String),
    members: List(Member),
    name: String,
    owner_user_id: Snowflake,
  )
}

/// Model for a Team Member object: https://discord.com/developers/docs/topics/teams#data-models-team-member-object
pub type Member {
  Member(membership_state: Int, team_id: Snowflake, user: User, role: String)
}

/// Model for Membership State: https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum
pub type MembershipState {
  INVITED
  // -> 1
  ACCEPTED
  // -> 2
}

/// Model for Install Params: https://discord.com/developers/docs/resources/application#install-params-object
pub type InstallParams {
  InstallParams(scopes: List(String), permissions: String)
}