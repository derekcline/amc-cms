#!/usr/bin/env perl

use Dancer2;
use Dancer2::Plugin::Database;
use DBI;
use File::Spec;
use File::Slurper qw/ read_text /;
use Template;
use Erik qw( off );

#set 'database'     => File::Spec->catfile(File::Spec->tmpdir(), 'dancr.db');
set 'session'      => 'Simple';
set 'template'     => 'template_toolkit';
set 'logger'       => 'console';
set 'log'          => 'debug';
set 'show_errors'  => 1;
set 'startup_info' => 1;
set 'warnings'     => 1;
set 'username'     => 'admin';
set 'password'     => 'password';
set 'layout'       => 'main';

my $flash;

sub set_flash {
    my $message = shift;

    Erik::warn();
    $flash = $message;
}

sub get_flash {

    my $msg = $flash;
    $flash = "";
    Erik::warn();

    return $msg;
}

sub connect_db {

    #my $dbh = DBI->connect("dbi:SQLite:dbname=".setting('database')) or
    #die $DBI::errstr;
    my $dbh = database('amc')
      or die $DBI::errstr;
    Erik::warn();

    return $dbh;
}

sub init_db {
    Erik::warn();
    my $db     = connect_db();
    my $schema = read_text('./sql/schema.sql');
    $db->do($schema) or die $db->errstr;
}

hook before_template_render => sub {
    my $tokens = shift;
    Erik::warn();

    $tokens->{'css_url'} = request->base . 'css/style.css';
    Erik::warn();
    $tokens->{'login_url'} = uri_for('/login');
    Erik::warn();
    $tokens->{'logout_url'} = uri_for('/logout');
    Erik::warn();
};

get '/' => sub {
    my $db  = connect_db();
    my $sql = 'select id, title, text from entries order by id desc';
    my $sth = $db->prepare($sql) or die $db->errstr;
    $sth->execute or die $sth->errstr;

    if ( session('logged_in') ) {
        redirect '/menu';
    }
    else {
        redirect '/login';
    }

    template 'show_menu.tt',
      {
        'msg'           => get_flash(),
        'add_entry_url' => uri_for('/users'),
      };
};

post '/add' => sub {
    if ( not session('logged_in') ) {
        send_error( "Not logged in", 401 );
    }

    my $db  = connect_db();
    my $sql = 'insert into entries (title, text) values (?, ?)';
    my $sth = $db->prepare($sql) or die $db->errstr;
    $sth->execute( params->{'title'}, params->{'text'} ) or die $sth->errstr;

    set_flash('New entry posted!');
    redirect '/';
};

any '/menu' => sub {
    Erik::dump( session => session );
    if ( not session('logged_in') ) {
        send_error( "Not logged in", 401 );
    }
    session 'logged_in' => true;

    template 'menu.tt', {};
};

any '/users' => sub {
    Erik::dump( session => session );
    if ( not session('logged_in') ) {
        send_error( "Not logged in", 401 );
    }
    session 'logged_in' => true;

    my $db = connect_db();
    my $sql =
'select id, first_name, middle_initial, last_name, email, phone from user';
    my $sth = $db->prepare($sql) or die $db->errstr;
    $sth->execute or die $sth->errstr;
    template 'show_users.tt',
      {
        'msg'           => get_flash(),
        'add_entry_url' => uri_for('/add_user'),
        'users'         => $sth->fetchall_hashref('id'),
      };

    #set_flash('New entry posted!');
    #redirect '/';
};

any [ 'get', 'post' ] => '/login' => sub {
    Erik::warn();
    my $err;

    if ( request->method() eq "POST" ) {

        # process form input
        if ( params->{'username'} ne setting('username') ) {
            $err = "Invalid username";
        }
        elsif ( params->{'password'} ne setting('password') ) {
            $err = "Invalid password";
        }
        else {
            session 'logged_in' => true;
            set_flash('You are logged in.');
            return redirect '/';
        }
    }

    # display login form
    template 'login.tt', { 'err' => $err, };

};

get '/logout' => sub {
    Erik::warn();
    app->destroy_session;
    set_flash('You are logged out.');
    redirect '/';
};

init_db();
start;

