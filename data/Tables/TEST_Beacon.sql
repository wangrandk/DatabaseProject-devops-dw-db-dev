CREATE TABLE [data].[TEST_Beacon] (
    [event_date]                    DATE           NULL,
    [event_timestamp]               DATETIME2 (7)  NULL,
    [event_name]                    NVARCHAR (MAX) NULL,
    [event_params]                  NVARCHAR (MAX) NULL,
    [event_previous_timestamp]      DATETIME2 (7)  NULL,
    [event_value_in_usd]            FLOAT (53)     NULL,
    [event_bundle_sequence_id]      BIGINT         NULL,
    [event_server_timestamp_offset] BIGINT         NULL,
    [user_id]                       INT            NULL,
    [user_pseudo_id]                NVARCHAR (MAX) NULL,
    [privacy_info]                  NVARCHAR (MAX) NULL,
    [user_properties]               NVARCHAR (MAX) NULL,
    [user_first_touch_timestamp]    DATETIME2 (7)  NULL,
    [user_ltv]                      INT            NULL,
    [device]                        NVARCHAR (MAX) NULL,
    [geo]                           NVARCHAR (MAX) NULL,
    [app_info]                      NVARCHAR (MAX) NULL,
    [traffic_source]                NVARCHAR (MAX) NULL,
    [stream_id]                     NVARCHAR (MAX) NULL,
    [platform]                      NVARCHAR (MAX) NULL,
    [event_dimensions]              INT            NULL,
    [ecommerce]                     INT            NULL,
    [items]                         NVARCHAR (MAX) NULL
);


GO

