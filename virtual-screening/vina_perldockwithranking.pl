#!/usr/bin/perl

use strict;
use warnings;

# ---------------------------------------
# INPUT FILE
# ---------------------------------------
print "Enter the filename containing ligand names: ";
chomp(my $ligand_file = <STDIN>);

open(my $fh, '<', $ligand_file)
    or die "Could not open file '$ligand_file': $!\n";


# ---------------------------------------
# FILES / DIRECTORIES
# ---------------------------------------
my $receptor = './receptor.pdbqt';
my $out_base = './output';
my $conf = './conf.txt';

my $combined_log = './all_docking_logs.txt';
my $ranking_file = './docking_ranking.txt';


# ---------------------------------------
# STORAGE FOR RESULTS
# ---------------------------------------
my @results;


# ---------------------------------------
# OPEN COMBINED LOG
# ---------------------------------------
open(my $log_fh, '>', $combined_log)
    or die "Could not open '$combined_log': $!\n";


# ---------------------------------------
# PROCESS EACH LIGAND
# ---------------------------------------
while (my $ligand = <$fh>) {

    chomp $ligand;

    # Skip empty lines
    next if $ligand eq '';

    my $out = "$out_base\_$ligand.pdbqt";

    print "\nDocking $ligand ...\n";

    # -----------------------------------
    # VINA COMMAND
    # -----------------------------------
    my $command =
        "vina --receptor $receptor " .
        "--ligand $ligand " .
        "--out $out " .
        "--config $conf";

    open(my $vina_output, "-|", $command)
        or die "Failed to run Vina for $ligand: $!\n";


    # -----------------------------------
    # CAPTURE VINA OUTPUT
    # -----------------------------------
    my @vina_lines;

    while (<$vina_output>) {

        push @vina_lines, $_;

        print $log_fh $_;
    }

    close($vina_output);


    # -----------------------------------
    # EXTRACT BEST VINA ENERGY
    # -----------------------------------
    my $best_energy;

    foreach my $line (@vina_lines) {

        # Vina table lines look approximately like:
        #
        # 1       -8.5      0.000      0.000
        #
        if ($line =~ /^\s*1\s+(-?\d+(?:\.\d+)?)/) {

            $best_energy = $1;
            last;
        }
    }


    # -----------------------------------
    # STORE RESULT
    # -----------------------------------
    if (defined $best_energy) {

        push @results, {
            ligand => $ligand,
            energy => $best_energy
        };

        print "Completed: $ligand | Best energy: $best_energy kcal/mol\n";

    } else {

        print "WARNING: Could not find energy for $ligand\n";

    }


    # -----------------------------------
    # SEPARATOR IN COMBINED LOG
    # -----------------------------------
    print $log_fh "\n";
    print $log_fh "============================================\n";
    print $log_fh "Ligand completed: $ligand\n";
    print $log_fh "Best energy: ",
                  (defined $best_energy ? $best_energy : "NOT FOUND"),
                  " kcal/mol\n";
    print $log_fh "============================================\n\n";
}


close($log_fh);
close($fh);


# ---------------------------------------
# SORT BY ENERGY
# MOST NEGATIVE = BEST
# ---------------------------------------
@results = sort {
    $a->{energy} <=> $b->{energy}
} @results;


# ---------------------------------------
# WRITE RANKING FILE
# ---------------------------------------
open(my $rank_fh, '>', $ranking_file)
    or die "Could not open '$ranking_file': $!\n";

print $rank_fh "VINA DOCKING RANKING\n";
print $rank_fh "===================\n\n";

printf $rank_fh "%-8s %-40s %-15s\n",
    "Rank", "Ligand", "Energy(kcal/mol)";

print $rank_fh "-" x 68;
print $rank_fh "\n";


my $rank = 1;

foreach my $result (@results) {

    printf $rank_fh "%-8d %-40s %-15.3f\n",
        $rank,
        $result->{ligand},
        $result->{energy};

    $rank++;
}


close($rank_fh);


# ---------------------------------------
# FINISHED
# ---------------------------------------
print "\n";
print "============================================\n";
print "DOCKING COMPLETE\n";
print "============================================\n";
print "Combined Vina log : $combined_log\n";
print "Ranking file       : $ranking_file\n";
print "============================================\n";