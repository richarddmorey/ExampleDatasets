#!C:/perl/bin/perl.exe
use CGI::Carp qw(fatalsToBrowser);
use CGI;
$query = new CGI;


print $query->header;
print $query->start_html(-title=>'Emotions and Aggression - Instructions');

#***** ===== To pick up gender from demograpic_info.pl
$gender= $query->param('gender');
$age= $query->param('age');
$region= $query->param('region');
$education=$query->param('education');
$english=$query->param('english');
$why_participate=$query->param('why_participate');
$how_find=$query->param('how_find');
$done_before=$query->param('done_before');
$internet_use=$query->param('internet_use');
$anticipation=$query->param('anticipation');

#=======================
# Create a form that will send the appropriate condition number to present_stim.pl. Present_stim.pl will
# use that number to present the graphics in the correct order
# Notice that the path to the file to which this one sends is specified starting with /cgi-bin/
#=======================

print "<FORM ACTION = '/cgi-bin/picture_rating_2_web/present_stim.pl' METHOD = 'post'>";

#****** ==== To pass gender to present_stim.pl (note that since we are not within a print statement,
# we have to start and and a print statement for the input tag

print "<INPUT TYPE=hidden NAME=gender VALUE=$gender>";
print "<INPUT TYPE=hidden NAME=age VALUE=$age>";
print "<INPUT TYPE=hidden NAME=region VALUE=$region>";
print "<INPUT TYPE=hidden NAME='education' VALUE=$education>";
print "<INPUT TYPE=hidden NAME='english' VALUE=$english>";
print "<INPUT TYPE=hidden NAME='why_participate' VALUE=$why_participate>";
print "<INPUT TYPE=hidden NAME='how_find' VALUE=$how_find>";
print "<INPUT TYPE=hidden NAME='done_before' VALUE=$done_before>";
print "<INPUT TYPE=hidden NAME='internet_use' VALUE=$internet_use>";
print "<INPUT TYPE=hidden NAME='anticipation' VALUE=$anticipation>";

#====================
# Send the instructions to the user's html page.
#===================
print "<H3>
  <P ALIGN=Center>
  Emotions and Aggression
       </H3>



Instructions:
<P>
In this study you will see a series of pictures of insects. We want you to
rate each picture regarding how much you would want to kill, or at least
in some way, get rid of each insect. The rating scale will be from 0 to 10.
A rating of 0 will mean you would not want to kill the insect at all. A rating
of 10 will mean you have the greatest possible desire to kill the insect.
<P>
The reason we say \"or at least get rid of\" is because some people might not
want to kill the insect themselves because they might not want to risk touching it.
Also, some people might consider killing it to violate a personal moral standard
against killing living things. Therefore, your rating should reflect how
much you would want to, in some way, get rid of the insect, regardless of
whether you were willing to kill it yourself, have someone else kill it,
or just get rid of it some way without actually killing it.
<P>
The next web page will show you all the pictures at once in a small size called a thumbnail.
You may have to scroll the page down a little to center the page, so that you can see the
[NEXT PAGE] link at the bottom. Please look at the thumbnail pictures first, without giving any ratings, 
just to get an idea of the range of different types of insects depicted by
the pictures. This will help you decide how to use the 0 to 10 scale. The
following pages will show you pictures of each insect, one at a time, in
full size. The pictures will be in the order in which we want you to rate
them. 
<P>
The rating scale will be below the picture. Please rate the pictures
one at a time in the order they are presented. Be sure to click a number
to indicate your rating for each insect before clicking on the link for the next page. Thank you.";


#===================
# End of instructions
#====================


#===================
# Read in the current value ($counter) of the counter from counter.txt
#==================

	open(INFO, "$ENV{'DOCUMENT_ROOT'}/www/data/picture_rating_2_web/counter.txt");
		@counter = <INFO>;
	close(INFO);

	foreach $key (@counter)
	{
		@data1=split(/,/,$key);
	}
	$counter = $data1[0];

#=======================================
# Read in the trial order (@data2) for the current block of trials
#=======================================
	open(INFO, "$ENV{'DOCUMENT_ROOT'}/www/data/picture_rating_2_web/numbers.txt");
		@numbers = <INFO>;
	close(INFO);

	foreach $key (@numbers)


	{
		@data2=split(/,/,$key);
	}


#=============================================
# The following lines are commented out for actually running the script.
# If necessary, the comment outs can be removed to print some info to the screen for testing the script
#==============================================

#      print "<BR><BR>Counter equals $counter. <BR>";
#      print "<BR><BR>The values in the numbers.txt file are @data2. <BR>";
#      print "The current condition (based on those numbers and the value of counter) is @data2[$counter].<BR>";
#      print "The Subject Pool ID number is $subj_pool_id.";


#=========================
# Create the hidden variable representing the number of the condition to be used.
# It will be created as a hidden variable that will be passed to present_stim.pl.
#==========================

#------------------------- First create a local variable whose value will be the correct condition number
$condition_number = @data2[$counter];

#------------------------- Create the hidden variable that has that value
print "<INPUT TYPE = 'hidden'  NAME = 'condition_number'  VALUE = $condition_number >";






#=====================
# Update the value of counter
#======================

	$counter = $counter + 1;


# =======================
# Again, this is commented out for actually running the script, but could be used
# to test if necessary.
#=========================

#	print "<BR>The new value of the counter (for the next time the page is loaded) is $counter. <BR>";

#===================================
# Save the new value of counter into the appropriate file, overwritting the old one
#======================================

	open(INFO2, ">$ENV{'DOCUMENT_ROOT'}/www/data/picture_rating_2_web/counter.txt");
		 print INFO2 "$counter";  
	close(INFO2);

#============================================================
# If $counter >= 16, set counter to 0 and randomize the order of trials in the numbers.txt file
# Notice, that there are also comments within this section regarding some IMPORTANT details.
#==============================================================

	if($counter >= 16){
		
                #===============
		# Reset counter
                #===============
		$counter = 0;

                #=============================
		# Randomize trial order and call it @varlist
                #=============================

		@varlist= (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16);
		srand;
		@new = ();
		while (@varlist){
		 push(@new, splice(@varlist, rand @varlist,1));
		}
		@varlist= @new;
		
                # ==== !!! IMPORTANT !!!========================================================================
		# Clunky code to insert a comma between each element of varlist so that something like 1,4,7,2 gets saved to the file rather than 1 4 7 2
                #========================================================================================

		@varlist = $varlist[0] . "," . $varlist[1] . "," . $varlist[2] . "," . $varlist[3] . "," .$varlist[4] . "," . $varlist[5] . "," . $varlist[6] . "," . $varlist[7] . "," . $varlist[8] . "," . $varlist[9] . "," . $varlist[10] . "," . $varlist[11] . "," . $varlist[12] . "," . $varlist[13] . "," . $varlist[14] . "," . $varlist[15];

#==============================================
# Overwrite the numbers.txt file with the new (random) order of trials
#==============================================

		open(INFO, ">$ENV{'DOCUMENT_ROOT'}/www/data/picture_rating_2_web/numbers.txt");
			 print INFO "@varlist";  
		close(INFO);

#==========================
# update the reset value of counter too
#=========================

		open(INFO, ">$ENV{'DOCUMENT_ROOT'}/www/data/picture_rating_2_web/counter.txt");
			 print INFO "$counter";  
		close(INFO);


	}

print "&nbsp&nbsp<INPUT TYPE = 'submit'   VALUE = 'Continue'>";

print $query->end_html;

