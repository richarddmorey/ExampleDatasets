#!C:/perl/bin/perl.exe
use CGI::Carp qw(fatalsToBrowser);
use CGI;
$query = new CGI;


#------------------------------------
# Create local variables from the information in the CGI packet
#*****=====notice we have added gender
#-----------------------------------

$gender=$query->param('gender');
$age=$query->param('age');
$region= $query->param('region');
$education=$query->param('education');
$english=$query->param('english');
$why_participate=$query->param('why_participate');
$how_find=$query->param('how_find');
$done_before=$query->param('done_before');
$internet_use=$query->param('internet_use');
$anticipation=$query->param('anticipation');
$v01= $query->param('experiment');
$v02= $query->param('order');
$v03= $query->param('stim12');
$v04= $query->param('stim35');
$v05= $query->param('stim20');
$v06= $query->param('stim18');
$v07= $query->param('stim16');
$v08= $query->param('stim07');
$v09= $query->param('stim05');
$v10= $query->param('stim11');


#---------------------------------------------------
# Create local variables from the environmental variables.
# The first batch creates local variables for the date and time.
# The next is for the ip address, and the last for the referring web page
#----------------------------------------------------

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);

$ip= $query->remote_addr();
$ref=$query->referer();

#-------------------------------------
# Begin an html page for sending the Thank you.
#-------------------------------------

print $query->header;
print $query->start_html(-title=>'Emotions and Aggression - Thanks');

#-------------------------------------------------
# Apparently the stuff below is handled differently by MS Explorer, vs Mozilla
# It seems that MS Explorer reads it whereas Mozilla does not
# So if you put in a white background rather than the LiteSlateGray that was there previously,
# and you use font color tags to make some text white, so as to make it invisible, you have
# to set the color below to black, as opposed to white against the LiteSlateGray background
# as it was set previously. Mozilla ignores the colors set here, but MS Explorer uses this info
# to override any colors that are not specifically set in the rest of the code

# I put in color black codes for all the numbers below the rating radio buttons in 'present_stim.pl'
# but once I realized that I could have set the color to black below, I realized that I
# didn't have to put in all those individual font color tags for every number.
# They could be removed.
# I removed the very first one to varifiy this. It is correct.
#--------------------------------------------

print "<style type='text/css'>
	body{
	margin: 20;
	padding: 0;
	font-size: 90%;
	font-family: arial;
	background-color: 'white';
	color: 'black';}
</style>";

#----------------------------------------------
# Open the text file for the data and lock it.
# Create local variables for the actual month and year
# Print the date, time, ip address, referring page, and all the data to the text file, then close it.
#---------------------------------------------

            open(INFO, ">>$ENV{'DOCUMENT_ROOT'}/www/data/picture_rating_2_web/picture_rating_2_data_web.txt");
            flock(INFO, 2);
                $actmon = $mon + 1;
                $actyear = $year + 1900;

#*****===== Here we will once again add gender
                print INFO "$gender, ";
                print INFO "$age, ";
                print INFO "$region, ";
                print INFO "$education, ";
                print INFO "$english, ";
                print INFO "$why_participate, ";
                print INFO "$how_find, ";
                print INFO "$done_before, ";
                print INFO "$internet_use, ";
                print INFO "$anticipation, ";
                print INFO "$actmon/$mday/$actyear\, ";
                print INFO "$hour:$min:$sec\, ";
                print INFO "$ip, $ref, ";
                print INFO "$v01,";
                print INFO "$v02,";
                print INFO "$v03,";
                print INFO "$v04,";
                print INFO "$v05,";
                print INFO "$v06,";
                print INFO "$v07,";
                print INFO "$v08,";
                print INFO "$v09,";
                print INFO "$v10,";
                print INFO "endline\n";
            close (INFO);

#----------------------------------------------------------
# Thank the participant and end the html page.
#-----------------------------------------------------------


print "<BR><BR><BR><CENTER><FONT FACE = 'times' SIZE = '5'><B><I>Thank you for participating in Emotions and Aggression

!</I></B></FONT><BR><br><BR><br><BR><br><font size = 2>
If you have any questions about this experiment, contact Dr. Robert S. Ryan at rryan\@kutztown.edu</CENTER></font> 

<BR><BR><HR>";

print $query->end_html;