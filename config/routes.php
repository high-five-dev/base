<?php

use craft\config\GeneralConfig;
use craft\helpers\App;

return GeneralConfig::create()
    // Set the default week start day for date pickers (0 = Sunday, 1 = Monday, etc.)
    ->defaultWeekStartDay(1)
    // Prevent generated URLs from including "index.php"
    ->omitScriptNameInUrls()
    // Enable Dev Mode (see https://craftcms.com/guides/what-dev-mode-does)
    ->devMode(App::env('DEV_MODE') ?? false)
    // Preload Single entries as Twig variables
    ->preloadSingles()
    // Allow administrative changes
    ->allowAdminChanges(App::env('ALLOW_ADMIN_CHANGES') ?? false)
    // Disallow robots
    ->disallowRobots(App::env('DISALLOW_ROBOTS') ?? false)
    ->cpTrigger('beheer')
    ->defaultCpLanguage('nl-NL')
    ->allowUpdates(false)
    ->cacheDuration('P1D')

;
