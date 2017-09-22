use strict;
use warnings;

# The script expects command line args when executing
my $args = $#ARGV + 1;

# If the script does not get the parameters it needs to execute it suggests args and exits
if ( $args != 5 )
{
    print "\nMore parameters were expected when running this script!                  \n";
    print "\nE.G => perl tool.pl [symm] [test_id] [dev_label] [type] [extra_loops]  \n\n";
    exit;
}

# Assign all variables based on command line args
my $sid         = $ARGV[0];
my $test_id     = $ARGV[1];
my $dev_label   = $ARGV[2];
my $type        = $ARGV[3];
my $extra_loops = $ARGV[4];

# General variables used in script
my $start  = gmtime();
my $count  = 0;
my $output = "";

# Basic error check
if ( $type ne "pers" and $type ne "pre" )
{
    print "\nUser selected invalid type of allocation! Either [pers] or [pre] are valid values! \n\n";
    exit( 1 );
}

#----------------------------------------------------------------------------------------
# Function:     printBanner
# Description:  Function that takes in a string + symbol and prints it to a banner
#----------------------------------------------------------------------------------------

sub printBanner
{
    my %args = @_;
    my $new_head   = $args{HEADING};
    my $new_symbol = $args{SYMBOL};

    print "\n";
    for( my $x = 0; $x < 10; $x++){ print $new_symbol; }
    print "\n$new_head \n";
    for( my $x = 0; $x < 10; $x++){ print $new_symbol; }
    print "\n";
}

#----------------------------------------------------------------------------------------
# Function:     executeAndOutputCmd
# Description:  ...
#----------------------------------------------------------------------------------------

sub executeAndOutputCmd
{
    my %args = @_;
    my $new_cmd = $args{COMMAND};

    print "\nExecuting Command : [ $new_cmd ]  \n";
    my $out = qx( /usr/symapi/bin/$new_cmd 2>&1 );
    my $ret = $?;

    print $out;
    printBanner( HEADING => "rc:[$ret]" , SYMBOL => "<" );
    print "\n\n";
}

#----------------------------------------------------------------------------------------
# Function:     getTestLatestLogFile
# Description:  ....
#----------------------------------------------------------------------------------------

sub getTestLatestLogFile
{
    my %args = @_;
    my $new_test_id = $args{ID};

    my $return_log = 0;
    my @sb_files   = split /\n/, qx( ls -l /usr/adios/log/tests/ );

    foreach my $file( @sb_files )
    {
        #   -rw-r--r--   1 root     root       68020 Nov 17 13:59 85983_0001_3.txt
        #   -rw-r--r--   1 root     root        1166 Nov 19 10:09 85983_0024.sum
        #   -rw-r--r--   1 root     root      639314 Nov 23 11:22 85888_0035.log
        #   -rw-r--r--   1 root     root      643350 Nov 23 12:44 85888_0036.log
        if ( $file =~ /\S+\s+\S+\s+\S+\s+\d+\s+\S{3}\s+\d+\s+\d{2}:\d{2}\s+$new_test_id+_(\d{4}).log$/ )
        {
            if ( $1 > $return_log )
            {
                $return_log = $1;
            }
        }
    }

    return $return_log;
}

#----------------------------------------------------------------------------------------
# Function:     getAllSmartBuilderTestDevs
# Description:  ...    
#----------------------------------------------------------------------------------------

sub getAllSmartBuilderTestDevs
{
    my %args    = @_;
    my $new_id  = $args{ID};
    my $new_log = $args{LOG_FILE};

    my $new_sb_log = '/usr/adios/log/tests/' . $new_id . '_' . $new_log . '.log';
    my $temp_label = "";
    my %return_devs;

    # If the tester doesn't want to retreive SB devs and instead wanted a dev range (XXX:YYY) we exit from this function
    if ( $new_id eq "NO_ID" )
    {
        return %return_devs;
    }

    print "+ Reading in devs for test id [$new_id]                  \n";
    print "+ Latest log for test id [$new_id] is log [$new_sb_log]  \n";

    open( FH, '<', $new_sb_log ) or Error( "Could not read file!" );
    my @lines = <FH>;

    LINE: foreach my $line ( @lines )
    {
        if ( $line =~ /choosen for Label\s+([\S ]*)/ )
        {
            print $line;
            $temp_label = substr( $1, 0, -1 )
        }

        elsif ( $line =~ /Dev:\s+0x(\S+)/ )
        {
            print $line;
            push( @{ $return_devs{ $temp_label } }, $1 );
        }
    }

    print "\n";

    close FH;
    return %return_devs;
}

#----------------------------------------------------------------------------------------
# Function:     getSpecificDevs
# Description:  ...
#----------------------------------------------------------------------------------------

sub getSpecificDevs
{
    my %args = @_;
    my $new_label = $args{LABEL};
    my %new_devs  = %{$args{DEVS}};

    my @return_devs;

    print "Selected devs to allocate on are...\n\n";

    # If the tester decides to use all devs from every device list
    if( $new_label eq "ALL" )
    {
        foreach my $curr_label( keys %new_devs )
        {
            print  $curr_label . "\n";
            foreach my $dev( @{$new_devs{$curr_label}} )
            {
                print $dev . "\n";
                push( @return_devs , $dev );
            }
            print "\n";
        }
    }

    # Else if the tester decides to use a specific dev range seperate from all SB dev labels e.g 100:128
    elsif( $new_label =~ /:/ )
    {
        my @lines = split /\n/, qx( /usr/symapi/bin/symdev list -devs $new_label -sid $sid 2>&1 );
        
        foreach my $line( @lines )
        {
            if ( $line =~ /([A-F0-9]{5})\s+\S+/ )
            {
                print $1 . "\n";
                push( @return_devs , $1 );
            }
        }
    }

    else
    {
        # If the tester decides they want to use a specific device label and its accompanying devs
        foreach my $curr_label( keys %new_devs )
        {
            if ( $new_label eq $curr_label )
            {
                print  $curr_label . "\n";
                foreach my $dev( @{$new_devs{$curr_label}} )
                {
                    print $dev . "\n";
                    push( @return_devs , $dev );
                }
                print "\n";
            }
        }
    }

    @return_devs = cleanDevs( DEVS => \@return_devs ); # Encase duplicates are present   
    return @return_devs;
}

#----------------------------------------------------------------------------------------
# Function:     cleanDevs
# Description:  ...
#----------------------------------------------------------------------------------------

sub cleanDevs
{
    my %args = @_;
    my @devs = @{$args{DEVS}};
    my %hash   = map { $_, 1 } @devs;
    my @unique = keys %hash;
    return @unique;
}

#----------------------------------------------------------------------------------------
# Function:     allocateAndDeallocate
# Description:  ...
#----------------------------------------------------------------------------------------

sub allocateAndDeallocate
{
    my %args = @_;
    my @new_devs   = @{$args{DEVS}};
    my $devs_param = "";

    foreach my $dev( @new_devs )
    {
        $devs_param .= $dev . ",";
    }

    $devs_param = substr( $devs_param, 0, -1 );

    printBanner( HEADING => "Beginning deallocation (setup)" , SYMBOL => "++++++++" );

    executeAndOutputCmd( COMMAND => "-sid $sid -devs $devs_param not_ready -nop" );
    executeAndOutputCmd( COMMAND => "-sid $sid -devs $devs_param free -all -nop" );

    sleep( 20 );

    checkAllocationLevel( COMMAND      => "list -sid $sid -tdev -devs $devs_param",
                          PERCENTAGE   => 0,
                          MAX_ATTEMPTS => 10 );

    #----------------------------------------------
    # Allocating based on user specification
    #----------------------------------------------

    sleep( 10 );

    printBanner( HEADING => "Starting allocation based on user input" , SYMBOL => "++++++++" );

    if ( $type eq "pers" )
    {
        executeAndOutputCmd( COMMAND => "-sid $sid -devs $devs_param allocate -persistent -nop" );
    }
    elsif ( $type eq "pre" )
    {
        executeAndOutputCmd( COMMAND => "-sid $sid -devs $devs_param allocate -nop" );
    }

    sleep( 30 );

    printBanner( HEADING => "Confirming allocation is 100%" , SYMBOL => "++++++++" );

    checkAllocationLevel( COMMAND      => "list -sid $sid -tdev -dev $devs_param",
                          PERCENTAGE   => 100,
                          MAX_ATTEMPTS => 10 );

    printBanner( HEADING => "Beginning deallocation" , SYMBOL => "++++++++" );

    executeAndOutputCmd( COMMAND => "-sid $sid -devs $devs_param not_ready -nop" );
    executeAndOutputCmd( COMMAND => "-sid $sid -devs $devs_param free -all -nop" );

    checkAllocationLevel( COMMAND      => "list -sid $sid -tdev -devs $devs_param",
                          PERCENTAGE   => 0,
                          MAX_ATTEMPTS => 10 );
}

#----------------------------------------------------------------------------------------
# Function:     checkAllocationLevel
# Description:  ...
#----------------------------------------------------------------------------------------

sub checkAllocationLevel
{
    my %args = @_;
    my $cmd               = $args{COMMAND};
    my $wanted_percentage = $args{PERCENTAGE};
    my $attempts          = $args{MAX_ATTEMPTS};

    my $counter = 0;
    my $flag    = 0;

    # While we still haven't got the desired % of allocation on our devs
    while ( $counter != $attempts )
    {
        $flag = 0;
        print "\nExecuting Command : [ $cmd ] \n";

        my $out = qx(/usr/symapi/bin/$cmd 2>&1);
        my $ret = $?;

        print $out . "\n";
        printBanner( HEADING => "rc:[$ret]" , SYMBOL => "<" );
        print "\n\n";

        my @cli_lines = split /\n/, $out;       # Splitting output from CLI out so it can be analysed
        my @allocated_percentage;               # Used to store ALL devices allocated percentages

        # Scan every line and store each devs allocation percentage
        foreach my $line ( @cli_lines )
        {
            if ( $line =~ /\S+\s+\S+\s+\S{4}\s+\d+\s+\d+\s+(\d+)/ )
            {
                push( @allocated_percentage , $1 );
            }
        }

        # Check every device allocation percentage
        foreach my $dev_perc( @allocated_percentage )
        {
            # If any single device isn't the desired percentage
            if ( $dev_perc != $wanted_percentage )
            {
                $flag = 1;
            }
        }

        # If no device has caused an issue and is at the desired allocation level we break out from the loop
        if ( $flag == 0 )
        {
            last;
        }
        else
        {
            printBanner( HEADING => "Not [$wanted_percentage%] yet...re-checking in 10 seconds" , SYMBOL => "XXXXX" );
            $counter++;
            sleep(10);
        }
    }

    if ( $counter == $attempts )
    {
        printBanner( HEADING => "Exiting script as there is a problem, Attempted : [$attempts] times " , SYMBOL => "XXXXX" );
        exit(1);
    }
}

print "\n\n\n\n";
#---------------------------------------------------------------------------------------------------------------------------------

printBanner( HEADING => "[ALLOCATE TOOL]" , SYMBOL => "XXXXXXXXXX" );

my $latest_log  = getTestLatestLogFile( ID => $test_id );
my %all_sb_devs = getAllSmartBuilderTestDevs( ID => $test_id, LOG_FILE => $latest_log );
my @alloc_devs  = getSpecificDevs( LABEL => $dev_label , DEVS => \%all_sb_devs );

if ( $extra_loops eq "INFINITY" )
{
    while( 1 == 1 )
    {
        printBanner( HEADING => "Tool loop [$count] of [INFINITE] loops!" , SYMBOL => "++++++++++++" );
        allocateAndDeallocate( DEVS => \@alloc_devs );
        $count++;
    }
}
elsif ( $extra_loops =~ /^\d+$/ )
{
    for ( $count = 0; $count <= $extra_loops; $count++ )
    {
        printBanner( HEADING => "Tool loop [$count] of [$extra_loops] loops!" , SYMBOL => "++++++++++++" );
        allocateAndDeallocate( DEVS => \@alloc_devs );
    }
}

printBanner( HEADING => "[TOOL COMPLETE]" , SYMBOL => "XXXXXXXXXX" );

my $end = localtime;
print "+------------------------------------------------+     \n";
print "Script commenced at | $start                           \n";
print "Script ended at     | $end                             \n";
print "+------------------------------------------------+ \n\n\n";

    © 2017 GitHub, Inc.
    Terms
    Privacy
    Security
    Status
    Help

    Contact GitHub
    API
    Training
    Shop
    Blog
    About

