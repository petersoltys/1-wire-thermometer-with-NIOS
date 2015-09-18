#Copyright (C)2006 System Level Solutions


use europa_all;
use strict;

my $project = e_project->new(@ARGV);

#new version
my $module = $project->top();

my $SLAVE = $project->module_ptf()->{"SLAVE s1"};
#old version
#delete $SLAVE->{PORT_WIRING};

my $DW = $project->SBI("s1")->{Data_Width};
my $AW = $project->SBI("s1")->{Address_Width};
my $BEW = int($DW / 8);

#old version
#my $share_pins = 0;

my $SLAVE = $project->module_ptf()->{"SLAVE s1"};

#new version
my $system_frequency = $project->get_module_clock_frequency();
#old version
#my $system_frequency = $project->system_ptf()
#    ->{WIZARD_SCRIPT_ARGUMENTS}{clock_freq};

my $SLAVE_SBI = $SLAVE->{SYSTEM_BUILDER_INFO};  


if ($system_frequency > 100E6)
{
   $SLAVE_SBI->{Read_Wait_States} = '20ns';
   $SLAVE_SBI->{Write_Wait_States} = '10ns';
   $SLAVE_SBI->{Hold_Time} = '10ns';
   $SLAVE_SBI->{Setup_Time} = '5ns';
}
elsif ($system_frequency > 50E6)
{
   $SLAVE_SBI->{Read_Wait_States} = 1;
   $SLAVE_SBI->{Write_Wait_States} = 1;
   $SLAVE_SBI->{Hold_Time} = 1;
   $SLAVE_SBI->{Setup_Time} = 1;
}
else
{
   $SLAVE_SBI->{Read_Wait_States} = '0ns';
   $SLAVE_SBI->{Write_Wait_States} = '0ns';
   $SLAVE_SBI->{Hold_Time} = 'half';
   $SLAVE_SBI->{Setup_Time} = 0;
}


#new version
my @port_list =
            (
               e_port->new(
               {
                  name      => 'data',
                  width     => $DW,
                  direction => "inout",
                  type      => "data",
               }),
               e_port->new(
               {
                  name      => 'address',
                  width     => $AW,
                  direction => "input",
                  type      => "address",
               }),
               e_port->new(
               {
                  name      => 'read_n',
                  width     => "1",
                  direction => "input",
                  type      => "read_n",
               }),
               e_port->new(
               {
                  name      => 'write_n',
                  width     => "1",
                  direction => "input",
                  type      => "write_n",
               }),
               e_port->new(
               {
                  name      => 'be_n',
                  width     => $BEW,
                  direction => "input",
                  type      => "byteenable_n",
               }),
               e_port->new(
               {
                  name      => 'select_n',
                  width     => "1",
                  direction => "input",
                  type      => "chipselect_n",
               }),
            );
$module->add_contents(@port_list);

#old version
#$SLAVE->{PORT_WIRING} = 
#            {
#               'PORT data' => 
#               {
#                  width => $DW,
#                  is_shared => 1,
#                  direction => "inout",
#                  type => "data",
#               },
#               'PORT address' => 
#               {
#                  width => $AW,
#                  is_shared => 1,
#                  direction => "input",
#                  type => "address",
#               },
#               'PORT read_n' =>
#               {
#                  width => "1",
#                  is_shared => $share_pins,
#                  direction => "input",
#                  type => "read_n",
#               },
#               'PORT write_n' => 
#               {
#                  width => "1",
#                  is_shared => $share_pins,
#                  direction => "input",
#                  type => "write_n",
#               },
#               'PORT be_n' => 
#               {
#                  width => $BEW,
#                  is_shared => $share_pins,
#                  direction => "input",
#                  type => "byteenable_n",
#               },
#               'PORT select_n' =>
#               {
#                  width     => "1",
#                  is_shared => "0",
#                  direction => "input",
#                  type      => "chipselect_n",
#               },
#            };



if ($project->module_ptf()->{SYSTEM_BUILDER_INFO}{Make_Memory_Model}) {
    my $options = 
    { name => $project->_target_module_name(),
      make_individual_byte_lanes => 1,
      num_lanes => $BEW,
    };
    $project->do_makefile_target_ptf_assignments
        (
         's1',
         ['dat', 'sym',],
         $options,
         );
} else { # Destroy memory model make instructions
    $project->do_makefile_target_ptf_assignments
        (
         '',
         [],
         );
};

$project->ptf_to_file();
