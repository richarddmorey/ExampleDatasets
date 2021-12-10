#!C:/perl/bin/perl.exe
use CGI::Carp qw(fatalsToBrowser);
use CGI;
$query = new CGI;


print $query->header;
print $query->start_html(-title=>'Emotions and Aggression - Demographic Information');

print "<H2>
  First, we'd like a little information about you.
</H2>
<P>
<FONT face=arial size=3>Providing this information is optional, but having
it could help us to answer some interesting questions. It is only intended
to help us learn&nbsp;about the groups of people who participate in our
experiment, not individuals. For example, perhaps people of a certain age
group tend to participate in this experiment more than others. Or, the results
we get from women may be different than those of men. So, we hope you will
help us by providing this information. Press the \"Continue\" button when you
are ready to begin.<I>Thanks</I>.</FONT>
<P>
<FORM ACTION=select_order.pl METHOD=POST>
  <table border=4 cellspacing=2 cellpadding=5>
    <tr>
      <td>
      1. Your gender?
      <td> 
      <INPUT TYPE=radio NAME=gender VALUE=1>Male
      <INPUT TYPE=radio NAME=gender VALUE=2>Female
   </tr>
   <tr>
     <td>
      2. How old are you?
    <td> 
      I am $nbsp<INPUT TYPE=text NAME=age SIZE=4 MAXLENGTH=3>&nbsp years old.
    </tr>
   <tr>
     <td>
      3. Where are you from?
    <td> 
      <SELECT NAME=region>
      <OPTION SELECTED>--- Please select one region ---- 
      <OPTION>North America 
      <OPTION>South America 
      <OPTION>Europe 
      <OPTION>Africa 
      <OPTION>Asia 
      <OPTION>Australia 
      <OPTION>Other</SELECT>
    </tr>
   <tr>
     <td>
      4. What is your level of education? 
     <td>
      <SELECT NAME=education>
      <OPTION SELECTED>--- Please select one ---- 
      <OPTION>less than high school 
      <OPTION>high school graduate 
      <OPTION>some college 
      <OPTION>college graduate 
      <OPTION>partial advanced degree training 
      <OPTION>advanced degree</SELECT>
    </tr>
   <tr>
     <td>
      5. Is English your native language?
     <td>
      <INPUT TYPE=radio NAME=english VALUE=1>Yes
      <INPUT TYPE=radio NAME=english VALUE=0>No
    </tr>
   <tr>
     <td>
      6. Why are you participating in this experiment? 
     <td>
      <SELECT NAME=why_participate>
      <OPTION SELECTED>--- Please select one --- 
      <OPTION>Just for fun 
      <OPTION>Looking for something to do 
      <OPTION>Interested in psychology 
      <OPTION>As an assignment for school 
      <OPTION>Other</SELECT>
    </tr>
   <tr>
     <td>
      7. How did you find out about this experiment? 
    <td>
      <SELECT NAME=how_find>
      <OPTION SELECTED>--- Please select one --- 
      <OPTION>Just browsing the web 
      <OPTION>Was looking for a psychology experiment 
      <OPTION>Heard about it from someone 
      <OPTION>Read about it on another web site</SELECT>
   </tr>
   <tr>
     <td>
      8. Have you done psychology experiments on the web before?
     <td>
      <SELECT NAME=done_before>
      <OPTION SELECTED>--- Please select one --- 
      <OPTION>Never 
      <OPTION>One before this one 
      <OPTION>Several before this one
      <OPTION>Many before this one</SELECT>
    </tr>
   <tr>
     <td>
      9. How much do you use the internet? 
     <td>
      <SELECT NAME=internet_use>
      <OPTION SELECTED>--- Please select one --- 
      <OPTION>Seldom
      <OPTION>Occasionally 
      <OPTION>Fairly often 
      <OPTION>Every day</SELECT>
    </tr>
   <tr>
     <td>
      10. Do you think you will enjoy this experiment?
     <td>
      <INPUT TYPE=radio NAME=anticipation VALUE=1>Yes
      <INPUT TYPE=radio NAME=anticipation VALUE=0>No
      <INPUT TYPE=radio NAME=anticipation VALUE=2>We'll see
 </tr>
</table>
<p align=center>
      <input type=submit value=Continue >
</FORM>
<P>";
print $query->end_html;

