#!C:/perl/bin/perl.exe
use CGI::Carp qw(fatalsToBrowser);
use CGI;
$query = new CGI;


#==========================
# Create a local variable from the NAME of the variable being passed from select_order.pl that
# represents the condition number.
# Notice that the NAME was just condition_number, but that the local variable is $condition_number
#*****===== and we have added gender
#==========================

$condition_number= $query->param('condition_number');
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

#=====================
# Start the html page
#=====================


print $query->header;
print $query->start_html(-title=>'Emotions and Aggression - Stimuli');


#-------------------------------------------------
# Apparently the stuff below is handled differently by MS Explorer, vs Mozilla
# It seems that MS Explorer reads it whereas Mozilla does not
# So if you put in a white background rather than the LiteSlateGray that was there previously,
# and you use font color tags to make some text white, so as to make it invisible, you have
# to set the color below to black, as opposed to white against the LiteSlateGray background
# as it was set previously. Mozilla ignores the colors set here, but MS Explorer uses this info
# to override any colors that are not specifically set in the rest of the code

# I put in color black codes for all the numbers below the rating radio buttons
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

#=====================
# Create local variables whose values equal the reference to the images
#=====================
$thumb01 = "../../images/picture_rating_2/antlion.jpg WIDTH=180 HEIGHT=144";
$thumb02 = "../../images/picture_rating_2/wasp_1.jpg WIDTH=139 HEIGHT=144";
$thumb03 = "../../images/picture_rating_2/cicada_killer1.jpg WIDTH=192 HEIGHT=144";
$thumb04 = "../../images/picture_rating_2/divingBeetle.jpg WIDTH=240 HEIGHT=144";
$thumb05 = "../../images/picture_rating_2/JuneBeetle.jpg WIDTH=142 HEIGHT=144";
$thumb06 = "../../images/picture_rating_2/scorpion2.jpg WIDTH=152 HEIGHT=144";
$thumb07 = "../../images/picture_rating_2/cockroach2.JPG WIDTH=144 HEIGHT=144";
$thumb08 = "../../images/picture_rating_2/Assassinbug.jpg WIDTH=178 HEIGHT=144";

$fullsize01 = "../../images/picture_rating_2/antlion.jpg WIDTH=360 HEIGHT=288";
$fullsize02 = "../../images/picture_rating_2/wasp_1.jpg";
$fullsize03 = "../../images/picture_rating_2/cicada_killer1.jpg WIDTH=398 HEIGHT=298";
$fullsize04 = "../../images/picture_rating_2/divingBeetle.jpg WIDTH=384 HEIGHT=230";
$fullsize05 = "../../images/picture_rating_2/JuneBeetle.jpg WIDTH=360 HEIGHT=342";
$fullsize06 = "../../images/picture_rating_2/scorpion2.jpg WIDTH=286 HEIGHT=270";
$fullsize07 = "../../images/picture_rating_2/cockroach2.JPG WIDTH=384 HEIGHT=384";
$fullsize08 = "../../images/picture_rating_2/Assassinbug.jpg WIDTH=360 HEIGHT=291";

#============================
# Use a set of if statements to create the appropriate array to use to present the simuli and response
# variables conditioned on the condition number.
#============================

if ($condition_number == 1) {

@thumbs = ($thumb01,$thumb02,$thumb03,$thumb04,$thumb05,$thumb06,$thumb07,$thumb08);
@resp_vars = (stim11,stim07,stim16,stim20,stim35,stim05,stim18,stim12);
@fullsize = ($fullsize01,$fullsize02,$fullsize03,$fullsize04,$fullsize05,$fullsize06,$fullsize07,$fullsize08);
}

if($condition_number == 2){

@thumbs = ($thumb08,$thumb01,$thumb02,$thumb03,$thumb04,$thumb05,$thumb06,$thumb07);
@resp_vars = (stim12,stim11,stim07,stim16,stim20,stim35,stim05,stim18);
@fullsize = ($fullsize08,$fullsize01,$fullsize02,$fullsize03,$fullsize04,$fullsize05,$fullsize06,$fullsize07);
}

if ($condition_number == 3) {

@thumbs = ($thumb07,$thumb08,$thumb01,$thumb02,$thumb03,$thumb04,$thumb05,$thumb06);
@resp_vars = (stim18,stim12,stim11,stim07,stim16,stim20,stim35,stim05);
@fullsize = ($fullsize07,$fullsize08,$fullsize01,$fullsize02,$fullsize03,$fullsize04,$fullsize05,$fullsize06);
}

if($condition_number == 4){

@thumbs = ($thumb06,$thumb07,$thumb08,$thumb01,$thumb02,$thumb03,$thumb04,$thumb05);
@resp_vars = (stim05,stim18,stim12,stim11,stim07,stim16,stim20,stim35);
@fullsize = ($fullsize06,$fullsize07,$fullsize08,$fullsize01,$fullsize02,$fullsize03,$fullsize04,$fullsize05);
}


if ($condition_number == 5) {

@thumbs = ($thumb05,$thumb06,$thumb07,$thumb08,$thumb01,$thumb02,$thumb03,$thumb04);
@resp_vars = (stim35,stim05,stim18,stim12,stim11,stim07,stim16,stim20);
@fullsize = ($fullsize05,$fullsize06,$fullsize07,$fullsize08,$fullsize01,$fullsize02,$fullsize03,$fullsize04);
}

if($condition_number == 6){

@thumbs = ($thumb04,$thumb05,$thumb06,$thumb07,$thumb08,$thumb01,$thumb02,$thumb03);
@resp_vars = (stim20,stim35,stim05,stim18,stim12,stim11,stim07,stim16);
@fullsize = ($fullsize04,$fullsize05,$fullsize06,$fullsize07,$fullsize08,$fullsize01,$fullsize02,$fullsize03);
}

if ($condition_number == 7) {

@thumbs = ($thumb03,$thumb04,$thumb05,$thumb06,$thumb07,$thumb08,$thumb01,$thumb02);
@resp_vars = (stim16,stim20,stim35,stim05,stim18,stim12,stim11,stim07);
@fullsize = ($fullsize03,$fullsize04,$fullsize05,$fullsize06,$fullsize07,$fullsize08,$fullsize01,$fullsize02);
}

if($condition_number == 8){

@thumbs = ($thumb02,$thumb03,$thumb04,$thumb05,$thumb06,$thumb07,$thumb08,$thumb01);
@resp_vars = (stim07,stim16,stim20,stim35,stim05,stim18,stim12,stim11);
@fullsize = ($fullsize02,$fullsize03,$fullsize04,$fullsize05,$fullsize06,$fullsize07,$fullsize08,$fullsize01);
}


if ($condition_number == 9) {

@thumbs = ($thumb02,$thumb07,$thumb01,$thumb06,$thumb04,$thumb03,$thumb08,$thumb05);
@resp_vars = (stim07,stim18,stim11,stim05,stim20,stim16,stim12,stim35);
@fullsize = ($fullsize02,$fullsize07,$fullsize01,$fullsize06,$fullsize04,$fullsize03,$fullsize08,$fullsize05);
}

if($condition_number == 10){

@thumbs = ($thumb05,$thumb02,$thumb07,$thumb01,$thumb06,$thumb04,$thumb03,$thumb08);
@resp_vars = (stim35,stim07,stim18,stim11,stim05,stim20,stim16,stim12);
@fullsize = ($fullsize05,$fullsize02,$fullsize07,$fullsize01,$fullsize06,$fullsize04,$fullsize03,$fullsize08);
}

if ($condition_number == 11) {

@thumbs = ($thumb08,$thumb05,$thumb02,$thumb07,$thumb01,$thumb06,$thumb04,$thumb03);
@resp_vars = (stim12,stim35,stim07,stim18,stim11,stim05,stim20,stim16);
@fullsize = ($fullsize08,$fullsize05,$fullsize02,$fullsize07,$fullsize01,$fullsize06,$fullsize04,$fullsize03);
}

if($condition_number == 12){

@thumbs = ($thumb03,$thumb08,$thumb05,$thumb02,$thumb07,$thumb01,$thumb06,$thumb04);
@resp_vars = (stim16,stim12,stim35,stim07,stim18,stim11,stim05,stim20);
@fullsize = ($fullsize03,$fullsize08,$fullsize05,$fullsize02,$fullsize07,$fullsize01,$fullsize06,$fullsize04);
}


if ($condition_number == 13) {

@thumbs = ($thumb04,$thumb03,$thumb08,$thumb05,$thumb02,$thumb07,$thumb01,$thumb06);
@resp_vars = (stim20,stim16,stim12,stim35,stim07,stim18,stim11,stim05);
@fullsize = ($fullsize04,$fullsize03,$fullsize08,$fullsize05,$fullsize02,$fullsize07,$fullsize01,$fullsize06);
}

if($condition_number == 14){

@thumbs = ($thumb06,$thumb04,$thumb03,$thumb08,$thumb05,$thumb02,$thumb07,$thumb01);
@resp_vars = (stim05,stim20,stim16,stim12,stim35,stim07,stim18,stim11);
@fullsize = ($fullsize06,$fullsize04,$fullsize03,$fullsize08,$fullsize05,$fullsize02,$fullsize07,$fullsize01);
}

if ($condition_number == 15) {

@thumbs = ($thumb01,$thumb06,$thumb04,$thumb03,$thumb08,$thumb05,$thumb02,$thumb07);
@resp_vars = (stim11,stim05,stim20,stim16,stim12,stim35,stim07,stim18);
@fullsize = ($fullsize01,$fullsize06,$fullsize04,$fullsize03,$fullsize08,$fullsize05,$fullsize02,$fullsize07);
}

if($condition_number == 16){

@thumbs = ($thumb07,$thumb01,$thumb06,$thumb04,$thumb03,$thumb08,$thumb05,$thumb02);
@resp_vars = (stim18,stim11,stim05,stim20,stim16,stim12,stim35,stim07);
@fullsize = ($fullsize07,$fullsize01,$fullsize06,$fullsize04,$fullsize03,$fullsize08,$fullsize05,$fullsize02);
}



#===============================
# Continue with the body of the web page with the necessary forms and tables to collect the data
#*****===== notice we have added gender
#===============================


print "<BODY BGCOLOR=#ffffff>
<FORM ACTION=../../../cgi-bin/picture_rating_2_web/picture_rating_2_savedata.pl
METHOD=POST>
  <INPUT TYPE=hidden NAME='experiment' VALUE=picture_rating_2_web>
  <INPUT TYPE=hidden NAME='order' VALUE=$condition_number>
  <INPUT TYPE=hidden NAME='gender' VALUE=$gender>
  <INPUT TYPE=hidden NAME='age' VALUE=$age>
  <INPUT TYPE=hidden NAME=region VALUE=$region>
  <INPUT TYPE=hidden NAME='education' VALUE=$education>
  <INPUT TYPE=hidden NAME='english' VALUE=$english>
  <INPUT TYPE=hidden NAME='why_participate' VALUE=$why_participate>
  <INPUT TYPE=hidden NAME='how_find' VALUE=$how_find>
  <INPUT TYPE=hidden NAME='done_before' VALUE=$done_before>
  <INPUT TYPE=hidden NAME='internet_use' VALUE=$internet_use>
  <INPUT TYPE=hidden NAME='anticipation' VALUE=$anticipation>
  
 <H2>
<P ALIGN=Center>
Thumbnails - Emotions and Aggression
</H2>




<!#==============
# --- Below, use  @thumbs[n] to represent the references to the thumbnails in the appropriate order
# defined by the array for the appropriate condition. Similarly, use @fullsize[n] to represent the
# references to the full size pictures, and use @resp_vars[n] to represent the response variables.
#================ -->

  <TABLE CELLPADDING=20>
    <TR>
      <TD><P ALIGN=Center>
	<IMG SRC=@thumbs[0]></TD>
      <TD><P ALIGN=Center>
	<IMG SRC=@thumbs[1]></TD>
      <TD><P ALIGN=Center>
	<IMG SRC=@thumbs[2]></TD>
      <TD><P ALIGN=Center>
	<IMG SRC=@thumbs[3]></TD>
    </TR>
    <TR>
      <TD><P ALIGN=Center>
	<IMG SRC=@thumbs[4]></TD>
      <TD><P ALIGN=Center>
	<IMG SRC=@thumbs[5]></TD>
      <TD><P ALIGN=Center>
	<IMG SRC=@thumbs[6]></TD>
      <TD><P ALIGN=Center>
	<IMG SRC=@thumbs[7]></TD>
    </TR>
  </TABLE>
  <P ALIGN=Center>
  <A HREF=#page1>[ NEXT PAGE ]</A><BR>
  <P ALIGN=Left>
  <FONT COLOR=#ffffff>.</FONT>
  <P ALIGN=Left>
  <FONT COLOR=#ffffff>.</FONT>
  <P ALIGN=Left>
  <FONT COLOR=#ffffff>.</FONT>
  <P ALIGN=Left>
  <FONT COLOR=#ffffff>.</FONT>
  <P ALIGN=Left>
  <FONT COLOR=#ffffff>.</FONT>
  <P ALIGN=Left>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
    <HR>





  <P>
  <A NAME=page1></A>
  <TABLE CELLPADDING=2>
    <TR>
      <TD COLSPAN=13><FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT></TD>
    </TR>
    <TR>
      <TD><FONT COLOR=#ffffff>..............................................................</FONT></TD>
      <TD COLSPAN=11><P ALIGN=Center>
	<IMG SRC=@fullsize[0]></TD>
      <TD><FONT COLOR=#ffffff>........................................................</FONT></TD>
    </TR>
    <TR>
      <TD COLSPAN=13></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[0] VALUE=0></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[0] VALUE=1></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[0] VALUE=2></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[0] VALUE=3></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[0] VALUE=4></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[0] VALUE=5></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[0] VALUE=6></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[0] VALUE=7></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[0] VALUE=8></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[0] VALUE=9></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[0] VALUE=10></TD>
      <TD></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>0</TD>
      <TD><P ALIGN=Center><FONT COLOR=#000000>1</FONT></TD>
      <TD><P ALIGN=Center><FONT COLOR=#000000>2</FONT></TD>
      <TD><P ALIGN=Center><FONT COLOR=#000000>3</FONT></TD>
      <TD><P ALIGN=Center><FONT COLOR=#000000>4</FONT></TD>
      <TD><P ALIGN=Center><FONT COLOR=#000000>5</FONT></TD>
      <TD><P ALIGN=Center><FONT COLOR=#000000>6</FONT></TD>
      <TD><P ALIGN=Center><FONT COLOR=#000000>7</FONT></TD>
      <TD><P ALIGN=Center><FONT COLOR=#000000>8</FONT></TD>
      <TD><P ALIGN=Center><FONT COLOR=#000000>9</FONT></TD>
      <TD><P ALIGN=Center><FONT COLOR=#000000>10</FONT></TD>
      <TD></TD>
    </TR>
    <TR>
      <TD COLSPAN=13><P ALIGN=Center>
	<FONT COLOR=#ffffff>.</FONT><A HREF=#page2>[ NEXT PAGE ]</A>
	<P>
	<FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
      </TD>
    </TR>
  </TABLE>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT> 
    <HR>




  <A NAME=page2><!-- --></A>
  <TABLE CELLPADDING=2>
    <TR>
      <TD COLSPAN=13><FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT></TD>
    </TR>
    <TR>
      <TD><FONT COLOR=#ffffff>..............................................................</FONT></TD>
      <TD COLSPAN=11><P ALIGN=Center>
	<IMG SRC=@fullsize[1]></TD>
      <TD><FONT COLOR=#ffffff>........................................................</FONT></TD>
    </TR>
    <TR>
      <TD COLSPAN=13></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[1] VALUE=0></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[1] VALUE=1></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[1] VALUE=2></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[1] VALUE=3></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[1] VALUE=4></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[1] VALUE=5></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[1] VALUE=6></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[1] VALUE=7></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[1] VALUE=8></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[1] VALUE=9></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[1] VALUE=10></TD>
      <TD></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>0</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>1</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>2</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>3</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>4</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>5</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>6</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>7</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>8</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>9</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>10</FONT></TD>
      <TD></TD>
    </TR>
    <TR>
      <TD COLSPAN=13><P ALIGN=Center>
	<FONT COLOR=#ffffff>.</FONT><A HREF=#page3>[ NEXT PAGE ]</A>
	<P>
	<FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
      </TD>
    </TR>
  </TABLE>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT> 
    <HR>






  <A NAME=page3><!-- --></A>
  <TABLE CELLPADDING=2>
    <TR>
      <TD COLSPAN=13><FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT></TD>
    </TR>
    <TR>
      <TD><FONT COLOR=#ffffff>..............................................................</FONT></TD>
      <TD COLSPAN=11><P ALIGN=Center>
	<IMG SRC=@fullsize[2]></TD>
      <TD><FONT COLOR=#ffffff>........................................................</FONT></TD>
    </TR>
    <TR>
      <TD COLSPAN=13></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[2] VALUE=0></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[2] VALUE=1></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[2] VALUE=2></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[2] VALUE=3></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[2] VALUE=4></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[2] VALUE=5></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[2] VALUE=6></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[2] VALUE=7></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[2] VALUE=8></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[2] VALUE=9></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[2] VALUE=10></TD>
      <TD></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>0</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>1</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>2</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>3</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>4</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>5</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>6</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>7</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>8</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>9</FONT></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>10</FONT></TD>
      <TD></TD>
    </TR>
    <TR>
      <TD COLSPAN=13><P ALIGN=Center>
	<FONT COLOR=#ffffff>.</FONT><A HREF=#page4>[ NEXT PAGE ]</A>
	<P>
	<FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
      </TD>
    </TR>
  </TABLE>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT> 
    <HR>






  <A NAME=page4><!-- --></A>
  <TABLE CELLPADDING=2>
    <TR>
      <TD COLSPAN=13><FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT></TD>
    </TR>
    <TR>
      <TD><FONT COLOR=#ffffff>..............................................................</FONT></TD>
      <TD COLSPAN=11><P ALIGN=Center>
	<IMG SRC=@fullsize[3]></TD>
      <TD><FONT COLOR=#ffffff>........................................................</FONT></TD>
    </TR>
    <TR>
      <TD COLSPAN=13></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[3] VALUE=0></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[3] VALUE=1></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[3] VALUE=2></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[3] VALUE=3></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[3] VALUE=4></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[3] VALUE=5></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[3] VALUE=6></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[3] VALUE=7></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[3] VALUE=8></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[3] VALUE=9></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[3] VALUE=10></TD>
      <TD></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>0</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>1</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>2</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>3</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>4</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>5</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>6</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>7</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>8</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>9</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>10</FONT</TD>
      <TD></TD>
    </TR>
    <TR>
      <TD COLSPAN=13><P ALIGN=Center>
	<A HREF=#page5><FONT COLOR=#ffffff>.</FONT>[ NEXT PAGE ]</A>
	<P>
	<FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
      </TD>
    </TR>
  </TABLE>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT> 
    <HR>






  <A NAME=page5><!-- --></A>
  <TABLE CELLPADDING=2>
    <TR>
      <TD COLSPAN=13><FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT></TD>
    </TR>
    <TR>
      <TD><FONT COLOR=#ffffff>..............................................................</FONT></TD>
      <TD COLSPAN=11><P ALIGN=Center>
	<IMG SRC=@fullsize[4]></TD>
      <TD><FONT COLOR=#ffffff>........................................................</FONT></TD>
    </TR>
    <TR>
      <TD COLSPAN=13></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[4] VALUE=0></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[4] VALUE=1></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[4] VALUE=2></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[4] VALUE=3></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[4] VALUE=4></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[4] VALUE=5></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[4] VALUE=6></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[4] VALUE=7></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[4] VALUE=8></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[4] VALUE=9></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[4] VALUE=10></TD>
      <TD></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>0</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>1</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>2</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>3</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>4</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>5</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>6</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>7</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>8</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>9</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>10</FONT</TD>
      <TD></TD>
    </TR>
    <TR>
      <TD COLSPAN=13><P ALIGN=Center>
	<A HREF=#page6><FONT COLOR=#ffffff>.</FONT>[ NEXT PAGE ]</A>
	<P>
	<FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
      </TD>
    </TR>
  </TABLE>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT> 
    <HR>






  <A NAME=page6><!-- --></A>
  <TABLE CELLPADDING=2>
    <TR>
      <TD COLSPAN=13><FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT></TD>
    </TR>
    <TR>
      <TD><FONT COLOR=#ffffff>..............................................................</FONT></TD>
      <TD COLSPAN=11><P ALIGN=Center>
	<IMG SRC=@fullsize[5]></TD>
      <TD><FONT COLOR=#ffffff>........................................................</FONT></TD>
    </TR>
    <TR>
      <TD COLSPAN=13></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[5] VALUE=0></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[5] VALUE=1></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[5] VALUE=2></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[5] VALUE=3></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[5] VALUE=4></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[5] VALUE=5></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[5] VALUE=6></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[5] VALUE=7></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[5] VALUE=8></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[5] VALUE=9></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[5] VALUE=10></TD>
      <TD></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>0</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>1</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>2</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>3</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>4</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>5</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>6</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>7</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>8</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>9</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>10</FONT</TD>
      <TD></TD>
    </TR>
    <TR>
      <TD COLSPAN=13><P ALIGN=Center>
	<A HREF=#page7><FONT COLOR=#ffffff>.</FONT>[ NEXT PAGE ]</A>
	<P>
	<FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
      </TD>
    </TR>
  </TABLE>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT> 
    <HR>






  <A NAME=page7><!-- --></A>
  <TABLE CELLPADDING=2>
    <TR>
      <TD COLSPAN=13><FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT></TD>
    </TR>
    <TR>
      <TD><FONT COLOR=#ffffff>..............................................................</FONT></TD>
      <TD COLSPAN=11><P ALIGN=Center>
	<IMG SRC=@fullsize[6]></TD>
      <TD><FONT COLOR=#ffffff>........................................................</FONT></TD>
    </TR>
    <TR>
      <TD COLSPAN=13></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[6] VALUE=0></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[6] VALUE=1></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[6] VALUE=2></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[6] VALUE=3></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[6] VALUE=4></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[6] VALUE=5></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[6] VALUE=6></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[6] VALUE=7></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[6] VALUE=8></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[6] VALUE=9></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[6] VALUE=10></TD>
      <TD></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>0</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>1</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>2</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>3</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>4</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>5</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>6</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>7</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>8</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>9</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>10</FONT</TD>
      <TD></TD>
    </TR>
    <TR>
      <TD COLSPAN=13><P ALIGN=Center>
	<FONT COLOR=#ffffff>.</FONT><A HREF=#page8>[ NEXT PAGE ]</A>
	<P>
	<FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
      </TD>
    </TR>
  </TABLE>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT> 
    <HR>





  <P>
  <A NAME=page8><!-- --></A>
  <TABLE CELLPADDING=2>
    <TR>
      <TD COLSPAN=13><FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT></TD>
    </TR>
    <TR>
      <TD><FONT COLOR=#ffffff>..............................................................</FONT></TD>
      <TD COLSPAN=11><P ALIGN=Center>
	<IMG SRC=@fullsize[7]></TD>
      <TD><FONT COLOR=#ffffff>........................................................</FONT></TD>
    </TR>
    <TR>
      <TD COLSPAN=13></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[7] VALUE=0></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[7] VALUE=1></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[7] VALUE=2></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[7] VALUE=3></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[7] VALUE=4></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[7] VALUE=5></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[7] VALUE=6></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[7] VALUE=7></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[7] VALUE=8></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[7] VALUE=9></TD>
      <TD><P ALIGN=Center>
	<INPUT TYPE=radio NAME=@resp_vars[7] VALUE=10></TD>
      <TD></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>0</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>1</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>2</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>3</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>4</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>5</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>6</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>7</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>8</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>9</FONT</TD>
      <TD><P ALIGN=Center>
	<FONT COLOR=#000000>10</FONT</TD>
      <TD></TD>
    </TR>
    <TR>
      <TD COLSPAN=13><P ALIGN=Center>
	<FONT COLOR=#ffffff>.</FONT><A HREF=#page9>[ NEXT PAGE ]</A>
	<P>
	<FONT COLOR=#ffffff>.</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
	<FONT COLOR=#ffffff> .</FONT>
	<P>
      </TD>
    </TR>
  </TABLE>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT> 
    <HR>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>


<!--# Finish with the submit button and use perl code to end the html page.  -->




  <A NAME=page9><!-- --></A> <FONT COLOR=#ffffff>.</FONT>
  <P ALIGN=Center>
  <INPUT TYPE=submit VALUE= 'Submit My Ratings'>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
  <FONT COLOR=#ffffff>.</FONT>
  <P>
    <HR>
</FORM>
</BODY>";



print $query->end_html;