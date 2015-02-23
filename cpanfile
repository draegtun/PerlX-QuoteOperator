requires 'Devel::Declare', '>= 0.006007';
requires 'Text::Balanced';

on configure => sub {
    requires 'Module::Build', '>= 0.38';
};

on test => sub {
    requires 'Test::More';
};
