<?php
use craft\helpers\App;
use craft\mail\transportadapters\Smtp;
use modules\highfive\HighFive;

$config = [
    'id' => App::env('CRAFT_APP_ID') ?: 'CraftCMS',
    '*'  => [
        'modules'   => [
            // 'highfive' => HighFive::class,
        ],
        'bootstrap' => [
            // 'highfive'
        ],
    ],
];

if (!empty(App::env('MAILHOG_SMTP_HOSTNAME')) && !empty(App::env('MAILHOG_SMTP_PORT'))) {
    $config['*']['components']['mailer'] = static function () {
        $settings = App::mailSettings();

        $settings->transportType     = Smtp::class;
        $settings->transportSettings = [
            'host' => App::env('MAILHOG_SMTP_HOSTNAME'),
            'port' => App::env('MAILHOG_SMTP_PORT'),
        ];

        return App::mailerConfig($settings);
    };
}

return $config;